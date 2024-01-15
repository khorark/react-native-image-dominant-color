package com.imagedominantcolor

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import androidx.palette.graphics.Palette
import com.facebook.react.bridge.Arguments
import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.WritableMap
import java.net.URL

class ImageDominantColorModule(reactContext: ReactApplicationContext) :
    ReactContextBaseJavaModule(reactContext) {

  override fun getName(): String {
    return NAME
  }

  @ReactMethod
  fun getColor(imageUrl: String, promise: Promise) {
    try {
      val url = URL(imageUrl)
      val inputStream = url.openStream()
      val bitmap = BitmapFactory.decodeStream(inputStream)

      // Calculate dominant color
      val dominantColor = calculateDominantColor(bitmap)
      val result = Arguments.createMap()
      result.putString(
          "dominantColor",
          "rgba(" +
              "${dominantColor.getDouble("red")}, " +
              "${dominantColor.getDouble("green")}, " +
              "${dominantColor.getDouble("blue")}, " +
              "${dominantColor.getDouble("alpha")})"
      )

      // Resolve the promise with the color map
      promise.resolve(result)
    } catch (e: Exception) {
      // Reject the promise if there's an error
      promise.reject("IMAGE_PROCESSING_ERROR", "Failed to fetch or calculate dominant color.", e)
    }
  }

  private fun calculateDominantColor(bitmap: Bitmap): WritableMap {
    val palette = Palette.from(bitmap).generate()

    val dominantSwatch = palette.dominantSwatch

    // Create a WritableMap to store the RGBA values
    val colorMap = Arguments.createMap()
    dominantSwatch?.let {
      colorMap.putDouble("red", (it.rgb shr 16 and 0xFF).toDouble()) // Red component
      colorMap.putDouble("green", (it.rgb shr 8 and 0xFF).toDouble()) // Green component
      colorMap.putDouble("blue", (it.rgb and 0xFF).toDouble()) // Blue component
      colorMap.putDouble("alpha", (it.rgb ushr 24 and 0xFF).toDouble()) // Alpha component
    }

    return colorMap
  }

  companion object {
    const val NAME = "ImageDominantColor"
  }
}
