import 'package:flutter/material.dart';
import 'topbar/topbarcontent.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Chooseflight extends StatefulWidget {
  const Chooseflight({super.key});

  @override
  State<Chooseflight> createState() => _ChooseflightState();
}

class _ChooseflightState extends State<Chooseflight> {
  @override
  Widget build(BuildContext context) {
    var Screensize = MediaQuery.of(context).size;
    var deviceType = getDeviceType(Screensize);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: AutoSizeText(
            "CHOOSE A FLIGHT",
            style: TextStyle(
              fontSize: deviceType == DeviceScreenType.mobile
                  ? 20
                  : (deviceType == DeviceScreenType.tablet ? 32 : 37),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Center(
          child: AutoSizeText(
            "and get ready for an experience of a lifetime…",
            style: TextStyle(
              fontSize: deviceType == DeviceScreenType.mobile
                  ? 17
                  : (deviceType == DeviceScreenType.tablet ? 22 : 27),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 17,
        ),
        Center(
          child: AutoSizeText(
            "We are a team of flying enthusiasts who care for the safety and security of anyone who comes to Himachal Pradesh for",
            style: TextStyle(
              fontSize: deviceType == DeviceScreenType.mobile
                  ? 15
                  : (deviceType == DeviceScreenType.tablet ? 20 : 22),
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Center(
          child: AutoSizeText(
            "paragliding and make your booking experience seamless.",
            style: TextStyle(
              fontSize: deviceType == DeviceScreenType.mobile
                  ? 15
                  : (deviceType == DeviceScreenType.tablet ? 20 : 22),
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        InkWell(
          onTap: (){
            print("object");
          },
          child: SizedBox(
            height: 100,
            width: 100,
            child: Center(
              child:Image.asset("assets/arrow.png"),
            ),
          ),
        )
      ],
    );
  }
}
