import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/styles/app_style.dart';
import '../../../reminder/presentation/pages/todo_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _constants = [
    {
      "title": "Seamless Offline Mode",
      "subtitle":
          "No internet? No problem. Access and manage your tasks anytime, anywhere. Your data is safe and stored locally.",
      "image": "lib/images/on_boarding_1.png",
    },
    {
      "title": "Smart Prioritization",
      "subtitle":
          "Focus on what truly matters. Categorize tasks by High, Medium, or Low urgency to keep your day effectively structured.",
      "image": "lib/images/on_boarding_2.png",
    },
    {
      "title": "Track Your Success",
      "subtitle":
          "Visualize your daily productivity. Stay motivated with progress rings and never miss a deadline with timely reminders.",
      "image": "lib/images/on_boarding_3.png",
    },
  ];

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);

    if (!mounted) return;
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const ToDoPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.surfaceColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _constants.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 300,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Image.asset(
                            _constants[index]['image']!,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 48),
                        Text(
                          _constants[index]['title']!,
                          textAlign: TextAlign.center,
                          style: AppStyle.headlineMedium.copyWith(
                            fontSize: 28,
                            color: AppStyle.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _constants[index]['subtitle']!,
                          textAlign: TextAlign.center,
                          style: AppStyle.bodyMedium.copyWith(
                            fontSize: 16,
                            color: AppStyle.textSecondary,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _constants.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: _currentPage == index ? 24 : 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? AppStyle.primaryColor
                              : AppStyle.grey300,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: _completeOnboarding,
                        child: Text(
                          "Skip",
                          style: AppStyle.bodyMedium.copyWith(
                            color: AppStyle.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      ElevatedButton(
                        onPressed: () {
                          if (_currentPage == _constants.length - 1) {
                            _completeOnboarding();
                          } else {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppStyle.primaryColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          _currentPage == _constants.length - 1
                              ? "Get Started"
                              : "Next",
                          style: AppStyle.priorityLabel.copyWith(
                            color: AppStyle.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
