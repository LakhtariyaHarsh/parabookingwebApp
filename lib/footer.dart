import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var deviceType = getDeviceType(screenSize);

    // Decide whether to use Row or Column
    bool isMobile = deviceType == DeviceScreenType.mobile;
    bool isTablet = deviceType == DeviceScreenType.tablet;

    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: isMobile
          ? SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildContent(deviceType),
                  ),
                  const SizedBox(height: 20), // Add spacing between sections
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: From_Blog(deviceType),
                  ),
                  const SizedBox(height: 20), // Add spacing between sections
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: Customer_Support(deviceType),
                  ),
                ],
              ),
            )
          : Row(
              children: [
                Flexible(
                  flex: 33,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildContent(deviceType),
                  ),
                ),
                Flexible(
                  flex: 33,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: From_Blog(deviceType),
                  ),
                ),
                Flexible(
                  flex: 33,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: Customer_Support(deviceType),
                  ),
                ),
              ],
            ),
    );
  }

  List<Widget> _buildContent(DeviceScreenType deviceType) {
    return [
      Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              "ABOUT",
              style: TextStyle(
                fontSize: deviceType == DeviceScreenType.mobile
                    ? 15
                    : (deviceType == DeviceScreenType.tablet ? 20 : 22),
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              height: 3, // Divider height
              width: 40, // Fixed width
              color: Colors.white38, // Divider color
              margin: const EdgeInsets.symmetric(vertical: 20), // Add spacing
            ),
            AutoSizeText(
              "We're a team of adventure enthusiasts with a technology background on a mission to bring a safe and sustainable tandem paragliding experience.",
              style: TextStyle(
                fontSize: deviceType == DeviceScreenType.mobile
                    ? 12
                    : (deviceType == DeviceScreenType.tablet ? 16 : 20),
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            AutoSizeText(
              "LOCATIONS",
              style: TextStyle(
                fontSize: deviceType == DeviceScreenType.mobile
                    ? 15
                    : (deviceType == DeviceScreenType.tablet ? 20 : 22),
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              height: 3, // Divider height
              width: 40, // Fixed width
              color: Colors.white38, // Divider color
              margin: const EdgeInsets.symmetric(vertical: 20), // Add spacing
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 20, // Horizontal spacing between buttons
              runSpacing: 10, // Vertical spacing for wrapped rows
              children: [
                CustomHoverButton(
                  text: "KULLU MANALI",
                  onPressed: () {
                    // Define button action here
                  },
                ),
                CustomHoverButton(
                  text: "BIR BILLING",
                  onPressed: () {
                    // Define button action here
                  },
                ),
                CustomHoverButton(
                  text: "SHIMLA",
                  onPressed: () {
                    // Define button action here
                  },
                ),
                CustomHoverButton(
                  text: "DHARAMSHALA",
                  onPressed: () {
                    // Define button action here
                  },
                ),
              ],
            ),
          ],
        ),
      )
    ];
  }

  List<Widget> From_Blog(DeviceScreenType deviceType) {
    return [
      Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              "FROM THE BLOG",
              style: TextStyle(
                fontSize: deviceType == DeviceScreenType.mobile
                    ? 15
                    : (deviceType == DeviceScreenType.tablet ? 20 : 22),
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              height: 3, // Divider height
              width: 40, // Fixed width
              color: Colors.white38, // Divider color
              margin: const EdgeInsets.symmetric(vertical: 20), // Add spacing
            ),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                bool isMobile = constraints.maxWidth < 600;
                bool isTablet =
                    constraints.maxWidth >= 600 && constraints.maxWidth < 1024;
                // bool isDesktop = constraints.maxWidth >= 1024;

                double textSize = isMobile
                    ? 8
                    : isTablet
                        ? 10
                        : 12;

                double columnSpacing = isMobile
                    ? 10
                    : isTablet
                        ? 15
                        : 20;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildColumn(
                      num: "10",
                      columnSpacing: columnSpacing,
                      textSize: textSize,
                      month: "Mar",
                      label1:
                          '“Maska” Star Prit Kamani takes off to the skies and flies like a bird!',
                      label2: "Comments Off",
                    ),
                    Container(
                      height: 0.5, // Divider height
                      width: 450, // Fixed width
                      color: Colors.white38, // Divider color
                      margin: const EdgeInsets.symmetric(
                          vertical: 5), // Add spacing
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    _buildColumn(
                      num: "02",
                      columnSpacing: columnSpacing,
                      textSize: textSize,
                      month: "Mar",
                      label1:
                          'How ParaBooking helped Vipin Sahu overcome his fear of Paragliding?',
                      label2: "Comments Off",
                    ),
                    Container(
                      height: 0.5, // Divider height
                      width: 450, // Fixed width
                      color: Colors.white38, // Divider color
                      margin: const EdgeInsets.symmetric(
                          vertical: 5), // Add spacing
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    _buildColumn(
                      num: "13",
                      columnSpacing: columnSpacing,
                      textSize: textSize,
                      month: "Jan",
                      label1:
                          'Meet the Solo Women Paragliders Soaring the Sky in Bir Billing',
                      label2: "Comments Off",
                    ),
                    Container(
                      height: 0.5, // Divider height
                      width: 450, // Fixed width
                      color: Colors.white38, // Divider color
                      margin: const EdgeInsets.symmetric(
                          vertical: 5), // Add spacing
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    _buildColumn(
                      num: "24",
                      columnSpacing: columnSpacing,
                      textSize: textSize,
                      month: "Oct",
                      label1:
                          '[Bir Travel Guide] Interesting things to do and see in Bir-Billing',
                      label2: "2 Comments",
                    ),
                  ],
                );
              },
            )
          ],
        ),
      )
    ];
  }

  List<Widget> Customer_Support(DeviceScreenType deviceType) {
    return [
      Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              "CUSTOMER SUPPORT",
              style: TextStyle(
                fontSize: deviceType == DeviceScreenType.mobile
                    ? 15
                    : (deviceType == DeviceScreenType.tablet ? 20 : 22),
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              height: 3, // Divider height
              width: 40, // Fixed width
              color: Colors.white38, // Divider color
              margin: const EdgeInsets.symmetric(vertical: 20), // Add spacing
            ),
            Row(
              children: [
                Icon(
                  Icons.mail_outline_outlined,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                AutoSizeText(
                  "contact@parabooking.com",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: deviceType == DeviceScreenType.mobile
                        ? 15
                        : (deviceType == DeviceScreenType.tablet ? 20 : 22),
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.phone,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        AutoSizeText(
                          "80911 49832 ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: deviceType == DeviceScreenType.mobile
                                ? 15
                                : (deviceType == DeviceScreenType.tablet
                                    ? 17
                                    : 22),
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        AutoSizeText(
                          "(Bir Billing),",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: deviceType == DeviceScreenType.mobile
                                ? 15
                                : (deviceType == DeviceScreenType.tablet
                                    ? 17
                                    : 22),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        AutoSizeText(
                          "91030 69487 ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: deviceType == DeviceScreenType.mobile
                                ? 15
                                : (deviceType == DeviceScreenType.tablet
                                    ? 17
                                    : 22),
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        AutoSizeText(
                          "(Kullu Manali).",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: deviceType == DeviceScreenType.mobile
                                ? 15
                                : (deviceType == DeviceScreenType.tablet
                                    ? 17
                                    : 22),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.phone_callback_rounded,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        AutoSizeText(
                          "80911 49832 ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: deviceType == DeviceScreenType.mobile
                                ? 15
                                : (deviceType == DeviceScreenType.tablet
                                    ? 17
                                    : 22),
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Icon(
                          Icons.keyboard_double_arrow_up_sharp,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  // Use Expanded to handle overflow
                  child: AutoSizeText(
                    "The HANGAR, VPO Bir, Opposite Garden Cafe, Near Chowgan Chowk, Bir, Himachal Pradesh - 176077.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: deviceType == DeviceScreenType.mobile
                          ? 15
                          : (deviceType == DeviceScreenType.tablet ? 20 : 22),
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 3, // Limit lines to avoid overflow
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    ];
  }

  Widget _buildColumn({
    required String num,
    required double columnSpacing,
    required double textSize,
    required String month,
    required String label1,
    required String label2,
  }) {
    return GestureDetector(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                color: Colors.white,
                width: 2,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero, // Removes rounded corners
              ),
              minimumSize: const Size(10, 50),
            ),
            onPressed: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  num,
                  style: TextStyle(
                      color: Colors.white, // Change text color
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                Text(
                  month,
                  style: TextStyle(
                      color: Colors.white, // Change text color
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  label1,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: textSize * 2,
                  ),
                  maxLines: 2, // Limit to 2 lines
                ),
                AutoSizeText(
                  label2,
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomHoverButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomHoverButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  _CustomHoverButtonState createState() => _CustomHoverButtonState();
}

class _CustomHoverButtonState extends State<CustomHoverButton> {
  bool isHovered = false;

  void _updateHoverState(bool hoverState) async {
    await Future.delayed(const Duration(milliseconds: 200)); // Add delay
    if (mounted) {
      setState(() {
        isHovered = hoverState;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        onEnter: (_) => _updateHoverState(true), // Trigger with delay
        onExit: (_) => _updateHoverState(false), // Reset with delay
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150), // Smooth transition
          decoration: BoxDecoration(
            color: isHovered
                ? Colors.white
                : Colors.transparent, // Background color
            border: Border.all(color: Colors.white, width: 2), // White border
          ),
          child: TextButton(
            onPressed: widget.onPressed,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 10), // Adjust padding
            ),
            child: Text(
              widget.text,
              style: TextStyle(
                color: isHovered ? Colors.black54 : Colors.white, // Text color
                fontWeight: FontWeight.bold,
                fontSize: 16, // Optional font size
              ),
            ),
          ),
        ));
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
