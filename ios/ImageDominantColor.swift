//
//  ImageDominantColor.swift
//
//  Created by Arkadiy Khoroshikh on 12.01.2024.
//  Copyright © 2024 Facebook. All rights reserved.
//

import Foundation
import UIKit

@objc(ImageDominantColor)
class ImageDominantColor: NSObject {
  private var defaultError = NSError(domain: "", code: 200, userInfo: nil)

  @objc(getColor:withResolver:withRejecter:)
  func getColor(imageUrl: String, resolve: @escaping RCTPromiseResolveBlock,
                reject: @escaping RCTPromiseRejectBlock) -> Void {
    guard let imageUrl = URL(string: imageUrl) else {
      reject("INVALID_URL", "Invalid image URL", nil)
              return
          }
    getDominantColor(from: imageUrl) { dominantColor in
      if let color = dominantColor {
          // Get the components in the RGBA format
          var red: CGFloat = 0
          var green: CGFloat = 0
          var blue: CGFloat = 0
          var alpha: CGFloat = 0

          color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
          let dominantColor: String = "rgba(\(red), \(green), \(blue), \(alpha))"

          let result: [String: Any] = [
            "dominantColor": dominantColor,
          ]
          let convertedObjectResult = RCTConvert.nsDictionary(result)
          resolve(convertedObjectResult)
        } else {
          reject("Error", "Failed to fetch or calculate dominant color.", self.defaultError)
        }
    }
  }

  func getDominantColor(from imageUrl: URL, completion: @escaping (UIColor?) -> Void) {
      // Fetch the image data from the URL
      DispatchQueue.global().async {
          if let data = try? Data(contentsOf: imageUrl),
             let image = UIImage(data: data) {

              // Calculate the average color of the image
              let averageColor = image.averageColor

              // Return the result on the main thread
              DispatchQueue.main.async {
                  completion(averageColor)
              }
          } else {
              // Handle error if unable to fetch image or calculate color
              DispatchQueue.main.async {
                  completion(nil)
              }
          }
      }
  }

}

extension UIImage {
    var averageColor: UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }

        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)

        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]),
              let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: nil)
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)

        return UIColor(red: CGFloat(bitmap[0]), green: CGFloat(bitmap[1]), blue: CGFloat(bitmap[2]), alpha: 1.0)
    }
}
