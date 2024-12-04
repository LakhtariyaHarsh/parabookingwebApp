import 'package:flutter/material.dart';
import 'package:parabooking_webapp/footer.dart' as footer;
import 'package:parabooking_webapp/loginmodel.dart';

class CustomAppBar extends StatefulWidget {
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  String? hoveredText; // Track currently hovered text
  OverlayEntry? _overlayEntry;

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

  // Function to hide the popup
  void hidePopup() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var deviceType = footer.getDeviceType(screenSize); // Get the device type

    return AppBar(
      title: Container(
        height: 80.0, // Ensure this height is consistent with the AppBar height
      padding: EdgeInsets.only(top: 10), // Padding for top space inside AppBar
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Logo
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Flexible(
                flex: 3,
                child: Image.asset(
                  "assets/parabooking.png",
                  height: deviceType == footer.DeviceScreenType.mobile ? 40 : 80,
                  color: Color(0xff2377af),
                ),
              ),
            ),
            // Navigation Menu Section for mobile
            if (deviceType == footer.DeviceScreenType.mobile)
              IconButton(
                icon: const Icon(Icons.menu,),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor:
                        Colors.transparent, // Make the modal drawer transparent
                    builder: (_) => Align(
                      alignment: Alignment.centerRight,
                      child: FractionallySizedBox(
                        heightFactor: 1,
                        widthFactor: 0.75, // Adjust width for right-side modal
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Close Button
                              Padding(
                                padding: const EdgeInsets.all(5.0),
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
                                          debugPrint("$text: $value selected");
                                          Navigator.pop(context);
                                        },
                                        itemBuilder: (context) {
                                          if (popupMenuData.containsKey(text)) {
                                            return popupMenuData[text]!
                                                .entries
                                                .expand((entry) {
                                              return [
                                                PopupMenuItem<String>(
                                                  value: entry.key,
                                                  child: Text(
                                                    entry.key,
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                    ),
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
                                                style:
                                                    const TextStyle(fontSize: 16),
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
                                            style: const TextStyle(fontSize: 16),
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
                                          Icon(Icons.video_camera_back_outlined),
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
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ), // Custom "Update" Item
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
                                size: deviceType == footer.DeviceScreenType.mobile
                                    ? 18
                                    : 22,
                               color: Colors.black54,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "UPDATE",
                                style: TextStyle(
                                  fontSize:
                                      deviceType == footer.DeviceScreenType.mobile
                                          ? 14
                                          : 18,
                                  fontWeight: hoveredText == "UPDATE"
                                      ? FontWeight.bold
                                      : FontWeight.w400,
                                 color: Colors.black54,
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
            if (deviceType != footer.DeviceScreenType.mobile)
              Flexible(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: HoverAndLoginModal(),
                ),
              )
          ],
        ),
      ),
    );
  }
}
