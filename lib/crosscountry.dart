import 'package:flutter/material.dart';
import 'topbar/topbarcontent.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Crosscountry extends StatefulWidget {
  const Crosscountry({super.key});

  @override
  State<Crosscountry> createState() => _CrosscountryState();
}

class _CrosscountryState extends State<Crosscountry> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var deviceType = getDeviceType(screenSize);

    // Decide whether to use Row or Column
    bool isMobile = deviceType == DeviceScreenType.mobile;

    return isMobile
        ? Column(
            children: [
              Flexible(
                flex: 50,
                child: SizedBox.expand(
                  child: Image.asset(
                    "assets/image3.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Flexible(
                flex: 50,
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: Container(
                      width:
                          double.infinity, // Expand content to fit the screen
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            "CLASSIC PARAGLIDING",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff2377af),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          AutoSizeText(
                            "IN BIR-BILLING",
                            style: TextStyle(
                              fontSize: 15,
                              color: const Color(0xff2377af),
                              letterSpacing: 3,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          AutoSizeText(
                            "If you want a taste of what paragliding can be, the Classic flight is your gateway. This 20-minute joy flight with an experienced pilot will take you from 2500m at billing top to 1400m at the landing site in Bir.",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: () {
                              // Your action here
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(
                                  0xffff700c), // Button background color
                              minimumSize:
                                  const Size(150, 50), // Width: 150, Height: 50
                            ),
                            child: const Text(
                              "BOOK NOW",
                              style: TextStyle(
                                color: Colors.white, // Text color
                                fontSize: 16, // Font size for text
                                fontWeight:
                                    FontWeight.bold, // Optional bold text
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        : Row(
            children: [
              // Left Image Section
              Flexible(
                flex: 50,
                child: SizedBox.expand(
                  child: Image.asset(
                    "assets/image3.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Right Content Section
              Flexible(
                flex: 50,
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: Container(
                      width: 500, // Fixed width for larger screens
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            "CLASSIC PARAGLIDING",
                            style: TextStyle(
                              fontSize: deviceType == DeviceScreenType.tablet
                                  ? 32
                                  : 45,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff2377af),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          AutoSizeText(
                            "IN BIR-BILLING",
                            style: TextStyle(
                              fontSize: deviceType == DeviceScreenType.tablet
                                  ? 20
                                  : 22,
                              color: const Color(0xff2377af),
                              letterSpacing: 3,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          AutoSizeText(
                            "If you want a taste of what paragliding can be, the Classic flight is your gateway. This 20-minute joy flight with an experienced pilot will take you from 2500m at billing top to 1400m at the landing site in Bir.",
                            style: TextStyle(
                              fontSize: deviceType == DeviceScreenType.tablet
                                  ? 16
                                  : 18,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: () {
                              // Your action here
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(
                                  0xffff700c), // Button background color
                              minimumSize:
                                  const Size(150, 50), // Width: 150, Height: 50
                            ),
                            child: const Text(
                              "BOOK NOW",
                              style: TextStyle(
                                color: Colors.white, // Text color
                                fontSize: 16, // Font size for text
                                fontWeight:
                                    FontWeight.bold, // Optional bold text
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
