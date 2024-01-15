# react-native-image-dominant-color

Get dominant color from image url

## Installation

```sh
npm install react-native-image-dominant-color --save
```

or

```sh
yarn add react-native-image-colors
```

Install Pods

```sh
cd ios && pod install
```

## Usage

```js
import { getColor } from 'react-native-image-dominant-color';

// ...

async function getDominantColor(imageUrl: string): Promise<void> {
  const result = await getColor('https://all-image.com/1.jpg'); // your image url
  console.log(result.dominantColor); //Ex rgba(64.0, 72.0, 240.0, 1.0)
}
```

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT

---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)
