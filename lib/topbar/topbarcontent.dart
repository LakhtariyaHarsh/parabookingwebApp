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
  bool ishoverd = false;
  String? hoveredText; // Track currently hovered text

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
        Container(
          color: Colors.black.withOpacity(0.3), // Adjust opacity (0.0 - 1.0)
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
                Padding(
                  padding: deviceType == DeviceScreenType.mobile
                      ? EdgeInsets.only(top: 100, bottom: 10)
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
                Container(
                  width: 200,
                  height: 150,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: MouseRegion(
                      onEnter: (event) {
                        setState(() {
                          ishoverd = true;
                        });
                      },
                      onExit: (event) {
                        setState(() {
                          ishoverd = false;
                        });
                      },
                      child: AnimatedContainer(
                        height: 90,
                        width: 90,
                        duration: Duration(milliseconds: 400),
                        decoration: BoxDecoration(
                          color: ishoverd
                              ? Colors.blue
                              : Colors.white24, // Change background color
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          // Ensures the child is aligned at the center
                          child: FittedBox(
                            fit: BoxFit
                                .contain, // Scales the icon proportionally to fit the container
                            child: Icon(
                              Icons.play_circle_outline,
                              size: 90, // Size matching the container
                              color: Colors.white, // Icon color
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    child: deviceType == DeviceScreenType.mobile
                        ? Container()
                        : ClickableRows()),
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
  if (size.width < 600) {
    return DeviceScreenType.mobile;
  } else if (size.width < 1200) {
    return DeviceScreenType.tablet;
  } else {
    return DeviceScreenType.desktop;
  }
}
