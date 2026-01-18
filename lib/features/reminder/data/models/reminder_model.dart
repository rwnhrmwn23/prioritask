import 'package:isar/isar.dart';
import '../../domain/entities/reminder.dart';
import '../../domain/entities/priority.dart';

part 'reminder_model.g.dart';

@collection
class ReminderModel {
  Id id = Isar.autoIncrement;

  late String title;

  late DateTime reminderTime;

  bool isCompleted = false;

  @Enumerated(EnumType.name)
  late Priority priority;

  Reminder toEntity() {
    return Reminder(
      id: id,
      title: title,
      reminderTime: reminderTime,
      isCompleted: isCompleted,
      priority: priority,
    );
  }

  static ReminderModel fromEntity(Reminder reminder) {
    final model = ReminderModel()
      ..title = reminder.title
      ..reminderTime = reminder.reminderTime
      ..isCompleted = reminder.isCompleted
      ..priority = reminder.priority;

    if (reminder.id != null) {
      model.id = reminder.id!;
    }
    return model;
  }
}
