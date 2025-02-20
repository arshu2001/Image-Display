import 'dart:html' as html;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class PlatformImageWidget extends StatefulWidget {
  final String imageUrl;

  PlatformImageWidget({required this.imageUrl}) {
    final String viewType = 'image-view-$imageUrl';

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      viewType,
      (int viewId) => html.ImageElement()
        ..src = imageUrl
        ..style.width = '300px'
        ..style.height = '300px'
        ..style.objectFit = 'cover',
    );
  }

  @override
  _PlatformImageWidgetState createState() => _PlatformImageWidgetState();
}

class _PlatformImageWidgetState extends State<PlatformImageWidget> {
  bool _isMenuOpen = false;

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  void _enterFullscreen() {
    html.document.documentElement?.requestFullscreen();
    _closeMenu();
  }

  void _exitFullscreen() {
    html.document.exitFullscreen();
    _closeMenu();
  }

  void _closeMenu() {
    setState(() {
      _isMenuOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String viewType = 'image-view-${widget.imageUrl}';

    return Stack(
      children: [
        // Background overlay when menu is open
        if (_isMenuOpen)
          Positioned.fill(
            child: GestureDetector(
              onTap: _closeMenu,
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),

        // Main content - Image display
        Center(
          child: SizedBox(
            width: 300,
            height: 300,
            child: HtmlElementView(viewType: viewType),
          ),
        ),

        // Floating Action Button
        Positioned(
          bottom: 20,
          right: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Context Menu
              if (_isMenuOpen)
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: _enterFullscreen,
                        child: Text('Enter fullscreen'),
                      ),
                      TextButton(
                        onPressed: _exitFullscreen,
                        child: Text('Exit fullscreen'),
                      ),
                    ],
                  ),
                ),

              // Plus Button
              FloatingActionButton(
                onPressed: _toggleMenu,
                child: Icon(Icons.add),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
