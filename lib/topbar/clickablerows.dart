import 'package:flutter/material.dart';

class ClickableRows extends StatefulWidget {
  @override
  _ClickableRowsState createState() => _ClickableRowsState();
}

class _ClickableRowsState extends State<ClickableRows> {
  int activeIndex = -1; // To track the currently active row (-1 means no row active)

  @override
  Widget build(BuildContext context) {
    // Screen size
    var screenWidth = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine the device type based on screen width
        bool isMobile = constraints.maxWidth < 600;
        bool isTablet = constraints.maxWidth >= 600 && constraints.maxWidth < 1024;
        // bool isDesktop = constraints.maxWidth >= 1024;

        // Responsive row spacing and icon size
        double iconSize = isMobile
            ? 40
            : isTablet
                ? 50
                : 60;

        double textSize = isMobile
            ? 8
            : isTablet
                ? 10
                : 12;

        double rowSpacing = isMobile
            ? 10
            : isTablet
                ? 15
                : 20;

        return Padding(
          padding: EdgeInsets.all(rowSpacing),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildRow(
                index: 0,
                icon: Icons.safety_check_outlined,
                label1: "Focus on",
                label2: "SAFETY",
                iconSize: iconSize,
                textSize: textSize,
              ),
              _buildRow(
                index: 1,
                icon: Icons.bookmark_add_outlined,
                label1: "Instant",
                label2: "BOOKING",
                iconSize: iconSize,
                textSize: textSize,
              ),
              _buildRow(
                index: 2,
                icon: Icons.restore_from_trash_rounded,
                label1: "Flexible",
                label2: "REFUNDS",
                iconSize: iconSize,
                textSize: textSize,
              ),
              _buildRow(
                index: 3,
                icon: Icons.phone_callback_rounded,
                label1: "Customer",
                label2: "SUPPORT",
                iconSize: iconSize,
                textSize: textSize,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRow({
    required int index,
    required IconData icon,
    required String label1,
    required String label2,
    required double iconSize,
    required double textSize,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          activeIndex = (activeIndex == index) ? -1 : index; // Toggle or reset active row
        });
      },
      child: Row(
        children: [
          Opacity(
            opacity: activeIndex == index ? 1 : 0.6, // Opacity based on active index
            child: Icon(
              icon,
              size: activeIndex == index ? iconSize + 10 : iconSize, // Size changes on click
              color: Colors.white,
            ),
          ),
          SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label1,
                style: TextStyle(
                  fontSize: textSize,
                  color: activeIndex == index
                      ? Colors.white
                      : Colors.white.withOpacity(0.6), // Opacity for text
                ),
              ),
              Text(
                label2,
                style: TextStyle(
                  fontSize: textSize * 2, // Make the second line text larger
                  color: activeIndex == index
                      ? Colors.white
                      : Colors.white.withOpacity(0.6), // Opacity for text
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}