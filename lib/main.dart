import 'package:flutter/material.dart';
import 'core/di/injection.dart';
import 'core/services/notification_service.dart';
import 'core/styles/app_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/reminder/presentation/bloc/reminder_bloc.dart';
import 'features/reminder/presentation/pages/todo_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  final notificationService = getIt<NotificationService>();
  await notificationService.init();
  await notificationService.requestPermissions();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ReminderBloc>(),
      child: MaterialApp(
        title: 'Prioritask',
        theme: AppStyle.lightTheme,
        home: const ToDoPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
