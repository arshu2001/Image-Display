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


// DartPad code

// import 'dart:html' as html;
// import 'dart:ui' as ui;
// import 'package:flutter/material.dart';

// /// The main entry point of the application.
// void main() {
//   runApp(MyApp());
// }

// /// The root widget of the application.
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: ImageDisplayScreen(),
//     );
//   }
// }

// /// Screen for image display and fullscreen toggle.
// class ImageDisplayScreen extends StatefulWidget {
//   @override
//   _ImageDisplayScreenState createState() => _ImageDisplayScreenState();
// }

// class _ImageDisplayScreenState extends State<ImageDisplayScreen> {
//   final TextEditingController _urlController = TextEditingController();
//   String _imageUrl = '';
//   bool _isMenuOpen = false;

//   /// Displays the image based on the entered URL.
//   void _displayImage() {
//     setState(() {
//       _imageUrl = _urlController.text;
//     });

//     if (_imageUrl.isNotEmpty) {
//       final String viewType = 'image-view';
//       // ignore: undefined_prefixed_name
//       ui.platformViewRegistry.registerViewFactory(
//         viewType,
//         (int viewId) => html.ImageElement()
//           ..src = _imageUrl
//           ..style.width = '300px'
//           ..style.height = 'auto',
//       );
//     }
//   }

//   /// Toggles fullscreen mode.
//   void _toggleFullscreen(bool enterFullscreen) {
//     if (enterFullscreen) {
//       html.document.documentElement?.requestFullscreen();
//     } else {
//       html.document.exitFullscreen();
//     }
//   }

//   /// Shows the floating action button menu.
//   void _showContextMenu(BuildContext context) {
//     setState(() => _isMenuOpen = true);
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.transparent,
//       builder: (BuildContext context) {
//         return GestureDetector(
//           onTap: () => Navigator.pop(context), // Close when tapped outside
//           child: Stack(
//             children: [
//               Container(color: Colors.black.withOpacity(0.5)), // Dim background
//               Positioned(
//                 bottom: 80,
//                 right: 20,
//                 child: Material(
//                   color: Colors.white,
//                   elevation: 4,
//                   borderRadius: BorderRadius.circular(10),
//                   child: ConstrainedBox(
//                     constraints: BoxConstraints(maxWidth: 250),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         ListTile(
//                           leading: Icon(Icons.fullscreen),
//                           title: Text('Enter Fullscreen'),
//                           onTap: () {
//                             _toggleFullscreen(true);
//                             Navigator.pop(context);
//                           },
//                         ),
//                         ListTile(
//                           leading: Icon(Icons.fullscreen_exit),
//                           title: Text('Exit Fullscreen'),
//                           onTap: () {
//                             _toggleFullscreen(false);
//                             Navigator.pop(context);
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     ).whenComplete(() => setState(() => _isMenuOpen = false));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final String viewType = 'image-view';

//     return Scaffold(
//       appBar: AppBar(title: Text('Image Display with Fullscreen')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _urlController,
//               decoration: InputDecoration(
//                 hintText: 'Enter image URL',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _displayImage,
//               child: Text('Display Image'),
//             ),
//             SizedBox(height: 20),
//             if (_imageUrl.isNotEmpty)
//               GestureDetector(
//                 onDoubleTap: () => _toggleFullscreen(true),
//                 child: SizedBox(
//                   width: 300,
//                   height: 300,
//                   child: HtmlElementView(viewType: viewType),
//                 ),
//               ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _showContextMenu(context),
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
