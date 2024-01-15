import { NativeModules, Platform } from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-image-dominant-color' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

const ImageDominantColor = NativeModules.ImageDominantColor
  ? NativeModules.ImageDominantColor
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

interface Result {
  dominantColor: string;
}

export async function getColor(imageUrl: string): Promise<Result> {
  return ImageDominantColor.getColor(imageUrl);
}
