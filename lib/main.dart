import 'package:flutter/material.dart';
import 'package:img_display/image_platform.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImageDisplayScreen(),
    );
  }
}

class ImageDisplayScreen extends StatefulWidget {
  @override
  _ImageDisplayScreenState createState() => _ImageDisplayScreenState();
}

class _ImageDisplayScreenState extends State<ImageDisplayScreen> {
  final TextEditingController _urlController = TextEditingController();
  String _imageUrl = '';

  void _displayImage() {
    setState(() {
      _imageUrl = _urlController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Display')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _urlController,
              decoration: InputDecoration(
                hintText: 'Enter image URL',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _displayImage,
              child: Text('Display Image'),
            ),
            SizedBox(height: 20),
            if (_imageUrl.isNotEmpty) PlatformImageWidget(imageUrl: _imageUrl), // Cross-platform image
          ],
        ),
      ),
    );
  }
}
