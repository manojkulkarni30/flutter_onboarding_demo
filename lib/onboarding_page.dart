import 'package:flutter/material.dart';
import 'package:flutter_onboarding_demo/home_page.dart';
import 'package:flutter_onboarding_demo/models/onboard_item.dart';
import 'package:flutter_onboarding_demo/services/preferences_service.dart';
import 'package:flutter_onboarding_demo/widgets/onboard_item_widget.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _currentPage = 0;
  final PageController _pageController = PageController();
  final List<OnboardItem> _pages = [
    const OnboardItem(
      title: 'Capture your tasks',
      subTitle: 'Quickly add tasks and organize your day with ease.',
      lottieUrl: 'assets/lottie/task-planning.json',
    ),
    const OnboardItem(
      title: 'Stay on top',
      subTitle: 'Prioritize, set deadlines and never miss an important task.',
      lottieUrl: 'assets/lottie/task-management.json',
    ),
    const OnboardItem(
      title: 'Get things done',
      subTitle: 'Mark tasks complete and feel the satisfaction of progress.',
      lottieUrl: 'assets/lottie/task-completed.json',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _next() async {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      await PreferencesService.instance.setBool('onboarding_done', true);
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
          spacing: 20,
          children: [
            Flexible(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (value) => setState(() {
                  _currentPage = value;
                }),
                itemBuilder: (context, index) {
                  return OnboardItemWidget(
                    item: _pages[index],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: .center,
              spacing: 10,
              children: List.generate(
                _pages.length,
                (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 8,
                    width: _currentPage == index ? 18 : 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.outline,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _next,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  textStyle: const TextStyle(fontWeight: .bold, fontSize: 16),
                ),
                child: Text(
                  _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
