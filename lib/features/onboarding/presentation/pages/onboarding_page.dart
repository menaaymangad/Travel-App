import 'package:flutter/material.dart';
import 'package:travelapp/features/auth/presentation/pages/login_page.dart';
import 'package:travelapp/widgets/components.dart';
import 'package:travelapp/widgets/custom_button.dart';

/// Onboarding page displayed to new users
class OnboardingPage extends StatefulWidget {
  /// Route name for navigation
  static const String routeName = '/onboarding';

  /// Creates a new [OnboardingPage] instance
  const OnboardingPage({super.key});

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

/// List of onboarding image assets
final List<String> images = [
  "map.png",
  "socialplate.png",
  "route.png",
];

/// List of onboarding primary text
final List<String> primaryText = [
  "Realtime Travel Guide",
  "Upload Your Travels",
  "No Matter Where You Are",
];

/// List of onboarding secondary text
final List<String> secondaryText = [
  "Get directions, costs, and other travel related stuff in one place...",
  "Share and enjoy your moments with your friends around the world...",
  "Access to important information about your travel destination, before and during your trip...",
];

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 220,
                        width: 300.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          image: DecorationImage(
                            image: AssetImage("assets/images/${images[index]}"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(height: 60),
                      Text(
                        primaryText[index],
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(height: 15.0),
                      Divider(
                        thickness: 4,
                        indent: 100,
                        endIndent: 100,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              secondaryText[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.7),
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 40.0),
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
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.3),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 20.0),
                          CustomButton(
                            function: () {
                              navigateTo(context, const LoginPage());
                            },
                            buttonName: 'Get Started',
                          ),
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
