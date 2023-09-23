# Generic Image for Flutter

A versatile Flutter widget for displaying images of various formats including SVG, PNG, JPEG, and Network Image . With built-in functionalities for placeholders, error handling, and more, `GenericImage` streamlines the process of working with different image formats.

## Video Demo

Check out the [video demonstration](https://github.com/mohit-2003/generic_image_flutter/blob/master/demo.mp4) of the `generic_image` package.

## Features

- Supports multiple image formats: SVG, PNG, JPEG.
- Automatic format detection based on file extension.
- Built-in placeholder and error widgets.
- Cache support for network images.
- Extensive customization through the `SvgStyle` class.

## Installation

### 1. Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  generic_image: ^0.1.0
```

### 2. Install the package:

```bash
flutter pub get
```

## Usage

### Basic Usage

```dart
import 'package:generic_image/generic_image.dart';

GenericImage(
  src: 'path_to_your_image/image.svg',
  format: ImageFormat.svg,
)
```

### Automatic Format Detection

```dart
GenericImage(
  src: 'path_to_your_image/image.svg',
  format: ImageFormat.detectAutomatically,
)
```

### Using Placeholders and Error Widgets

```dart
GenericImage(
  src: 'https://your_image_url/image.png',
  format: ImageFormat.png,
  placeholder: (context, url) => CircularProgressIndicator(),
  errorWidget: (context, url, error) => Icon(Icons.error),
)
```

### SVG Styling

Utilize the `SvgStyle` class for extensive styling options for SVG images.

```dart
GenericImage(
  src: 'path_to_your_image/image.svg',
  format: ImageFormat.svg,
  svgStyle: SvgStyle(
    color: Colors.red,
    alignment: Alignment.center,
    // ... other style properties ...
  ),
)
```

## Example App

There's a detailed example project in the `example` directory showcasing various features of the `generic_image` package. To run it:

1. Navigate to the `example` directory:

```bash
cd example
```

2. Run the example app:

```bash
flutter run
```

## Contribution

Feel free to open an issue or submit a pull request if you find any bugs or have some suggestions for improvements.

## License

[MIT License](https://opensource.org/licenses/MIT)

---

Please adapt the content as per your requirements, such as the version number, additional features, etc. The `README.md` should be comprehensive, up-to-date, and offer clear instructions and descriptions for your users.
