import 'package:flutter/material.dart';

import 'social_login.dart';
import '../widgets/components.dart';

class onboarding extends StatefulWidget {
  const onboarding({Key? key}) : super(key: key);

  @override
  _onboardingState createState() => _onboardingState();
}

List images = [
  "map.png",
  "socialplate.png",
  "route.png",
];
List Text1 = [
  "Realtime Travel Guide",
  "Upload Your Travels",
  "No Matter Where You Are",
];
List Text2 = [
  "Get directions, costs, and other travel related stuff in one place...",
  "Share and enjoy your moments with your friends around the world...",
  "Access to important information about your travel destination ,before and during your trip...",
];

class _onboardingState extends State<onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (_, index) {
            return Padding(
              padding:
                  const EdgeInsets.only(top: 50.0, left: 15.0, right: 15.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 220,
                        width: 300.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/" + images[index]),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(height: 100),
                      Text(
                        '' + Text1[index],
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Horizon',
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Divider(
                        thickness: 5,
                        indent: 100,
                        endIndent: 100,
                        color: ButtonAndIconsColor(),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              '' + Text2[index],
                              style: const TextStyle(
                                fontSize: 20,
                                fontFamily: 'Horizon',
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 50.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(3, (indexDots) {
                              return Container(
                                width: index == indexDots ? 15 : 10,
                                margin: const EdgeInsets.only(right: 2),
                                height: 10,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: index == indexDots
                                      ? ButtonAndIconsColor()
                                      : ButtonAndIconsColor().withOpacity(0.3),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 20.0),
                          Positioned(
                            bottom: 0.0,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: MaterialButton(
                                height: 50,
                                onPressed: () {
                                  navigateto(context, LoginScreen());
                                },
                                color: ButtonAndIconsColor(),
                                child: const Text(
                                  'Get Started',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Horizon',
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
