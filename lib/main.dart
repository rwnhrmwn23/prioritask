import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/di/injection.dart';
import 'core/services/notification_service.dart';
import 'core/styles/app_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/reminder/presentation/bloc/reminder_bloc.dart';
import 'features/reminder/presentation/pages/todo_page.dart';
import 'features/onboarding/presentation/pages/onboarding_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize DI
  await configureDependencies();

  // Initialize Notifications
  final notificationService = getIt<NotificationService>();
  await notificationService.init();
  await notificationService.requestPermissions();

  // Check Onboarding Status
  final prefs = await SharedPreferences.getInstance();
  final bool showOnboarding = !(prefs.getBool('onboarding_completed') ?? false);

  runApp(MyApp(showOnboarding: showOnboarding));
}

class MyApp extends StatelessWidget {
  final bool showOnboarding;

  const MyApp({super.key, required this.showOnboarding});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ReminderBloc>(),
      child: MaterialApp(
        title: 'Prioritask',
        theme: AppStyle.lightTheme,
        home: showOnboarding ? const OnboardingPage() : const ToDoPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
