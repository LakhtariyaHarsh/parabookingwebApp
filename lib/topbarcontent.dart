import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Topbarcontent extends StatefulWidget {
  const Topbarcontent({super.key});

  @override
  State<Topbarcontent> createState() => _TopbarcontentState();
}

class _TopbarcontentState extends State<Topbarcontent> {
  late VideoPlayerController _controller;

  final Map<String, Map<String, List<String>>> popupMenuData = {
    "BIR-BILLING⮟": {
      "PARAGLIDING": [
        "Classic Paragliding",
        "Prime Paragliding",
        "XC Paragliding",
        "Paragliding for Seniors",
      ],
      "EXPERIENCES": [
        "Coffee 101",
        "E-Cycling to the 108 Stupas",
        "Bir Beyond Boundaries: 360° Trek",
        "Travel Guide",
      ],
    },
    "KULLU MANALI⮟": {
      "": ["Classic Paragliding"],
      " ": ["Prime Paragliding"],
    },
    "DHARAMSHALA⮟": {
      "PARAGLIDING": [],
      "EXPERIENCES": [
        "McLeodganj to Barnet MTB Tour",
      ],
    },
  };

  String? hoveredText; // Track currently hovered text
  OverlayEntry? _overlayEntry;

  @override
void initState() {
  super.initState();
  _controller = VideoPlayerController.asset('assets/video.mp4')
    ..setLooping(true) // Enable looping first
    ..initialize().then((_) {
      // Ensure the video is initialized before attempting playback
      setState(() {
        _controller.setVolume(0); // Mute the video
        _controller.play(); // Start playback
      });
    }).catchError((error) {
      // Handle initialization errors gracefully
      debugPrint("Error initializing video: $error");
    });
}


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Builds the popup menu with items from the data
  List<PopupMenuEntry<String>> buildPopupMenu(String text) {
    if (!popupMenuData.containsKey(text)) return [];
    return popupMenuData[text]!.entries.expand((entry) {
      return [
        PopupMenuItem<String>(
          value: entry.key,
          child: Text(
            entry.key,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        ...entry.value.map(
          (item) => PopupMenuItem<String>(
            value: item,
            child: Text(item),
          ),
        )
      ];
    }).toList();
  }

  // Show popup menu at the position of mouse hover
  void showPopup(BuildContext context, String text, Offset position) {
    if (!popupMenuData.containsKey(text)) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: position.dy + 10,
        left: position.dx,
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          child: Container(
            padding: const EdgeInsets.all(10),
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: popupMenuData[text]!.entries.expand((entry) {
                return [
                  Text(
                    entry.key,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...entry.value.map(
                    (item) => GestureDetector(
                      onTap: () {
                        debugPrint('Selected: $item');
                        hidePopup(); // Close the popup after selection
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                ];
              }).toList(),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  // Hide the popup
  void hidePopup() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Stack(
     children: <Widget>[
      SizedBox.expand(
        child: AspectRatio(
          aspectRatio: _controller.value.isInitialized
              ? _controller.value.aspectRatio
              : 16 / 9, // Default aspect ratio in case video isn't initialized
          child: VideoPlayer(_controller),
        ),
      ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo
              SizedBox(
                width: 300,
                child: Image.asset(
                  "assets/parabooking.png",
                ),
              ),
              // Top Bar Menu with MouseRegion for Hover
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: 800,
                  height: 600,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var text in [
                        "BIR-BILLING⮟",
                        "KULLU MANALI⮟",
                        "SHIMLA",
                        "DHARAMSHALA⮟",
                        "BLOG"
                      ])
                        MouseRegion(
                          onEnter: (event) {
                            setState(() {
                              hoveredText = text;
                            });
                            showPopup(context, text, event.position);
                          },
                          onExit: (_) {
                            setState(() {
                              hoveredText = null;
                              hidePopup();
                            });
                          },
                          child: PopupMenuButton<String>(
                            onSelected: (value) {
                              debugPrint("Selected: $value");
                              hidePopup(); // Hide the popup when an item is selected
                            },
                            itemBuilder: (_) => buildPopupMenu(text),
                            child: Text(
                              text,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: hoveredText == text
                                    ? FontWeight.bold
                                    : FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                      // Custom item with prefix icon
                      MouseRegion(
                        onHover: (_) {
                          setState(() {
                            hoveredText = "UPDATE";
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            hoveredText = "";
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.info,
                              size: 22,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "UPDATE",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: hoveredText == "UPDATE"
                                    ? FontWeight.bold
                                    : FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Login
              SizedBox(
                height: 60,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MouseRegion(
                      onEnter: (_) {
                        setState(() {
                          hoveredText = "LOGIN";
                        });
                      },
                      onExit: (_) {
                        setState(() {
                          hoveredText = null;
                        });
                      },
                      child: PopupMenuButton<String>(
                        onSelected: (value) {
                          debugPrint("Selected: $value");
                        },
                        itemBuilder: (_) => [
                          const PopupMenuItem<String>(
                            value: "Login",
                            child: Text("Login"),
                          ),
                        ],
                        child: const Text(
                          "LOGIN",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
