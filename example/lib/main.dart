import 'package:flutter/material.dart';
import 'package:generic_image/generic_image.dart';

void main() => runApp(const GenericImageExampleApp());

class GenericImageExampleApp extends StatelessWidget {
  const GenericImageExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GenericImage Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ImageFormat? _selectedFormat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GenericImage Example'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image Format Selector
              DropdownButton<ImageFormat>(
                value: _selectedFormat,
                hint: const Text('Select Image Format'),
                onChanged: (ImageFormat? newValue) {
                  setState(() {
                    _selectedFormat = newValue;
                  });
                },
                items: const [
                  DropdownMenuItem<ImageFormat>(
                    value: ImageFormat.png,
                    child: Text("PNG Format"),
                  ),
                  DropdownMenuItem<ImageFormat>(
                    value: ImageFormat.svg,
                    child: Text("SVG Format"),
                  ),
                  DropdownMenuItem<ImageFormat>(
                    value: ImageFormat.network,
                    child: Text("Network Image"),
                  )
                ],
              ),

              // SVG Image Example
              if (_selectedFormat == ImageFormat.svg || _selectedFormat == null)
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: GenericImage(
                    src: 'assets/home-icon.svg',
                    format: ImageFormat.svg,
                    height: 250,
                    width: 200,
                  ),
                ),

              // PNG Image Example
              if (_selectedFormat == ImageFormat.png || _selectedFormat == null)
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: GenericImage(
                    src: 'assets/facebook-square-icon.png',
                    format: ImageFormat.png,
                    height: 250,
                    width: 200,
                  ),
                ),

              // PNG Image Example
              if (_selectedFormat == ImageFormat.network ||
                  _selectedFormat == null)
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: GenericImage(
                    src:
                        'https://cdn.pixabay.com/photo/2023/08/19/17/36/bird-8200917_1280.jpg',
                    format: ImageFormat.jpg,
                    height: 250,
                    width: 200,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
