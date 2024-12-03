import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class HoverAndLoginModal extends StatefulWidget {
  @override
  _HoverAndLoginModalState createState() => _HoverAndLoginModalState();
}

class _HoverAndLoginModalState extends State<HoverAndLoginModal> {
  String hoveredText = "";

  // Function to determine if the device is a tablet based on screen width
  bool isTablet(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width >= 600 && width < 1024; // Define a range for tablet screens
  }

  // Function to show the login modal
  void _showLoginModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => _LoginModalDialog(), // Use the new StatefulWidget
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (_) {
        setState(() {
          hoveredText = "LOGIN";
        });
      },
      onExit: (_) {
        setState(() {
          hoveredText = "";
        });
      },
      child: GestureDetector(
        onTap: () {
          _showLoginModal(context); // Open login modal on tap
        },
        child: Text(
          "LOGIN",
          style: TextStyle(
            fontSize: 16,
            fontWeight:
                hoveredText == "LOGIN" ? FontWeight.bold : FontWeight.w400,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}

// Separate StatefulWidget for the dialog
class _LoginModalDialog extends StatefulWidget {
  @override
  __LoginModalDialogState createState() => __LoginModalDialogState();
}

class __LoginModalDialogState extends State<_LoginModalDialog> {
  bool agreeToTerms = false;
  String hoveredText = "";

  // Function to determine if the device is a tablet
  bool isTablet(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width >= 600 && width < 1024;
  }

  @override
  Widget build(BuildContext context) {
    bool tablet = isTablet(context); // Check if the device is a tablet
    bool mobile = !tablet && MediaQuery.of(context).size.width < 600;

    // For mobile, return only a simple container
    if (mobile) {
      return Container();
    }

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: tablet
            ? SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildLoginContent(context),
                    const SizedBox(height: 20),
                    _buildRegisterContent(context),
                  ],
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(flex: 1, child: _buildLoginContent(context)),
                  Flexible(flex: 1, child: _buildRegisterContent(context)),
                ],
              ),
      ),
    );
  }

  Widget _buildLoginContent(BuildContext context) {
    bool tablet = isTablet(context);

    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: Colors.black12),
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      width: tablet
          ? MediaQuery.of(context).size.width * 0.8
          : 500, // Dynamic width
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            "LOGIN",
            style: TextStyle(
              fontSize: tablet ? 20 : 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xff2377af),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            "Username or email address *",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: tablet ? 18 : 22,
            ),
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              labelText: "Username",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Password *",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: tablet ? 18 : 22,
            ),
          ),
          SizedBox(height: 10),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Checkbox(
                value: agreeToTerms,
                onChanged: (bool? value) {
                  setState(() {
                    agreeToTerms = value ?? false;
                  });
                },
              ),
              Text(
                "Remember me",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: tablet ? 18 : 22,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Perform login action
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff2377af),
              minimumSize: const Size(150, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
            child: const Text(
              "LOG IN",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          MouseRegion(
            onEnter: (_) {
              setState(() {
                hoveredText = "Lost your password?";
              });
            },
            onExit: (_) {
              setState(() {
                hoveredText = "";
              });
            },
            child: GestureDetector(
              onTap: () {
                print("Text clicked");
              },
              child: Text(
                "Lost your password?",
                style: TextStyle(
                  fontSize: 16,
                  color: hoveredText == "Lost your password?"
                      ? Colors.black
                      : Color(0xff2377af),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterContent(BuildContext context) {
    bool tablet = isTablet(context);

    return Container(
      padding: const EdgeInsets.all(16.0),
      width: tablet
          ? MediaQuery.of(context).size.width * 0.8
          : 500, // Dynamic width
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            "REGISTER",
            style: TextStyle(
              fontSize: tablet ? 20 : 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xff2377af),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            "Email address *",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: tablet ? 18 : 22,
            ),
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          AutoSizeText(
            "A link to set a new password will be sent to your email address.",
            style: TextStyle(
              fontSize: tablet ? 16 : 20,
              color: Colors.black45,
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Checkbox(
                value: agreeToTerms,
                onChanged: (bool? value) {
                  setState(() {
                    agreeToTerms = value ?? false;
                  });
                },
              ),
              Text(
                "Subscribe to updates",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: tablet ? 18 : 22,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Perform register action
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff2377af),
              minimumSize: const Size(150, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
            child: const Text(
              "REGISTER",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
