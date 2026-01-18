import 'package:equatable/equatable.dart';
import 'priority.dart';

class Reminder extends Equatable {
  final int? id;
  final String title;
  final DateTime reminderTime;
  final bool isCompleted;
  final Priority priority;

  const Reminder({
    this.id,
    required this.title,
    required this.reminderTime,
    this.isCompleted = false,
    this.priority = Priority.none,
  });

  @override
  List<Object?> get props => [id, title, reminderTime, isCompleted, priority];

  Reminder copyWith({
    int? id,
    String? title,
    DateTime? reminderTime,
    bool? isCompleted,
    Priority? priority,
  }) {
    return Reminder(
      id: id ?? this.id,
      title: title ?? this.title,
      reminderTime: reminderTime ?? this.reminderTime,
      isCompleted: isCompleted ?? this.isCompleted,
      priority: priority ?? this.priority,
    );
  }
}
