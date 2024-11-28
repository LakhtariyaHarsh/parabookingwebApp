import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'clickablerows.dart';
class Topbarcontent extends StatefulWidget {
  const Topbarcontent({super.key});

  @override
  State<Topbarcontent> createState() => _TopbarcontentState();
}

class _TopbarcontentState extends State<Topbarcontent> {
  late VideoPlayerController _controller;
  Color backgroundColor = Colors.transparent;

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
      ..setLooping(true)
      ..initialize().then((_) {
        setState(() {
          _controller.setVolume(0);
          _controller.play();
        });
      }).catchError((error) {
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
                        hidePopup();
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

  void hidePopup() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var deviceType = getDeviceType(screenSize);

    return Stack(
      children: <Widget>[
        // Fullscreen Video Background
        SizedBox.expand(
          child: _controller.value.isInitialized
              ? FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
                  ),
                )
              : Container(
                  color: Colors.black,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
        ),
        // Content overlay
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: deviceType == DeviceScreenType.desktop ? 50 : 10,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceEvenly, // Apply spacing between items
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Logo
                    Flexible(
                      flex: 3,
                      child: Image.asset(
                        "assets/parabooking.png",
                        height:
                            deviceType == DeviceScreenType.mobile ? 50 : 100,
                      ),
                    ),
                    // Navigation Menu Section
                    if (deviceType == DeviceScreenType.mobile)
                      IconButton(
                        icon: const Icon(Icons.menu, color: Colors.white),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors
                                .transparent, // Make the modal drawer transparent
                            builder: (_) => Align(
                              alignment: Alignment.centerRight,
                              child: FractionallySizedBox(
                                heightFactor: 1,
                                widthFactor:
                                    0.75, // Adjust width for right-side modal
                                // alignment: Alignment.centerRight,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Close Button
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                            icon: const Icon(Icons.close,
                                                color: Colors.black),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      ),
                                      // Navigation Items
                                      Expanded(
                                        child: ListView(
                                          padding: EdgeInsets.zero,
                                          children: [
                                            for (var text in [
                                              "BIR-BILLING⮟",
                                              "KULLU MANALI⮟",
                                              "DHARAMSHALA⮟",
                                            ])
                                              PopupMenuButton<String>(
                                                onSelected: (value) {
                                                  debugPrint(
                                                      "$text: $value selected");
                                                  Navigator.pop(context);
                                                },
                                                itemBuilder: (context) {
                                                  if (popupMenuData
                                                      .containsKey(text)) {
                                                    return popupMenuData[text]!
                                                        .entries
                                                        .expand((entry) {
                                                      return [
                                                        PopupMenuItem<String>(
                                                          value: entry.key,
                                                          child: Text(
                                                            entry.key,
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        ...entry.value.map(
                                                          (item) =>
                                                              PopupMenuItem<
                                                                  String>(
                                                            value: item,
                                                            child: Text(item),
                                                          ),
                                                        )
                                                      ];
                                                    }).toList();
                                                  }
                                                  return [
                                                    PopupMenuItem<String>(
                                                      value: text,
                                                      child: Text(text),
                                                    ),
                                                  ];
                                                },
                                                child: Column(
                                                  children: [
                                                    ListTile(
                                                      title: Text(
                                                        text,
                                                        style: const TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                    Divider(),
                                                  ],
                                                ),
                                              ),
                                            ListTile(
                                              title: Text("SHIMALA"),
                                            ),
                                            Divider(),
                                            ListTile(
                                              title: Text("BLOG"),
                                            ),
                                            Divider(),
                                            ListTile(
                                              title: Row(
                                                children: [
                                                  Icon(Icons.info),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  Text(
                                                    "UPDATE",
                                                    style: const TextStyle(
                                                        fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Divider(),
                                            ListTile(
                                              title: Text("LOGIN"),
                                            ),
                                            Divider(),
                                            ListTile(
                                              title: Row(
                                                children: [
                                                  Icon(Icons.facebook_outlined),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  Icon(Icons.mail_outline),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  Icon(Icons
                                                      .video_camera_back_outlined),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  Icon(Icons.facebook_outlined),
                                                ],
                                              ),
                                            ),
                                            Divider(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    else
                      Flexible(
                        flex: 8,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            width: 800,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                        hidePopup();
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
                                // Custom "Update" Item
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
                                        size: deviceType ==
                                                DeviceScreenType.mobile
                                            ? 18
                                            : 22,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "UPDATE",
                                        style: TextStyle(
                                          fontSize: deviceType ==
                                                  DeviceScreenType.mobile
                                              ? 14
                                              : 18,
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
                      ),
                    // Login Button
                    if (deviceType != DeviceScreenType.mobile)
                      Flexible(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: MouseRegion(
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
                        ),
                      )
                  ],
                ),
                Padding(
                  padding: deviceType == DeviceScreenType.mobile
                      ? EdgeInsets.only(top: 50)
                      : EdgeInsets.all(0),
                  child: Center(
                    child: AutoSizeText(
                      "EXPERIENCE THE JOY OF FLYING",
                      style: TextStyle(
                        fontSize: deviceType == DeviceScreenType.mobile
                            ? 26
                            : (deviceType == DeviceScreenType.tablet ? 55 : 97),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: AutoSizeText(
                    "Welcome to Bir-Billing‘s most trusted platform for Tandem Paragliding",
                    style: TextStyle(
                      fontSize: deviceType == DeviceScreenType.mobile ? 20 : 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        // Toggle background color on click
                        backgroundColor = backgroundColor == Colors.transparent
                            ? Colors.blue
                            : Colors.transparent;
                      });
                    },
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: backgroundColor, // Dynamic background color
                        shape: BoxShape
                            .circle, // Ensure the background is a perfect circle
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/open.png'), // Path to your image
                          fit: BoxFit
                              .cover, // Fit the image within the circular container
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  child: deviceType == DeviceScreenType.mobile ? Container() : ClickableRows()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

enum DeviceScreenType { mobile, tablet, desktop }

DeviceScreenType getDeviceType(Size size) {
  if (size.width > 950) {
    return DeviceScreenType.desktop;
  } else if (size.width > 600) {
    return DeviceScreenType.tablet;
  } else {
    return DeviceScreenType.mobile;
  }
}
