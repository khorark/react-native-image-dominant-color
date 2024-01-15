# react-native-image-dominant-color

Get dominant color from image url

## Installation

```sh
npm install react-native-image-dominant-color
```

## Usage

```js
import { getColor } from 'react-native-image-dominant-color';

// ...

const result = await getColor('https://all-image.com/1.jpg'); // your image url

console.log(result.dominantColor); // format by rgba
```

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT

---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)
