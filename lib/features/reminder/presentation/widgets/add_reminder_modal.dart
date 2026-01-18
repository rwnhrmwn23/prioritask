import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/styles/app_style.dart';
import '../../domain/entities/priority.dart';
import '../../domain/entities/reminder.dart';
import '../bloc/reminder_bloc.dart';

class AddReminderModal extends StatefulWidget {
  final Priority? initialPriority;
  final DateTime? initialDate;
  final Reminder? reminder;

  const AddReminderModal({
    super.key,
    this.initialPriority,
    this.initialDate,
    this.reminder,
  });

  @override
  State<AddReminderModal> createState() => _AddReminderModalState();
}

class _AddReminderModalState extends State<AddReminderModal> {
  final TextEditingController _titleController = TextEditingController();
  late Priority _selectedPriority;
  late DateTime _selectedDate;
  TimeOfDay _selectedTime = TimeOfDay.now();

  final List<String> _hints = [
    "What's next?",
    "Just one thing",
    "Stay on track",
  ];
  int _currentHintIndex = 0;
  Timer? _hintTimer;

  bool get _isEditing => widget.reminder != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      _titleController.text = widget.reminder!.title;
      _selectedPriority = widget.reminder!.priority;
      _selectedDate = widget.reminder!.reminderTime;
      _selectedTime = TimeOfDay.fromDateTime(widget.reminder!.reminderTime);
    } else {
      _selectedPriority = widget.initialPriority ?? Priority.none;
      _selectedDate = widget.initialDate ?? DateTime.now();
    }
    _startHintAnimation();
  }

  void _startHintAnimation() {
    _hintTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) {
        setState(() {
          _currentHintIndex = (_currentHintIndex + 1) % _hints.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _hintTimer?.cancel();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppStyle.grey300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPriorityBadge(),
              if (_isEditing)
                Expanded(
                  child: IconButton(
                    icon: const Icon(
                      Icons.delete_outline,
                      color: AppStyle.primaryColor,
                    ),
                    onPressed: () {
                      context.read<ReminderBloc>().add(
                        DeleteReminderEvent(widget.reminder!.id!),
                      );
                      Navigator.pop(context);
                    },
                  ),
                ),
            ],
          ),

          const SizedBox(height: 16),

          TextField(
            controller: _titleController,
            autofocus: true,
            style: AppStyle.headlineMedium,
            decoration: InputDecoration(
              hintText: _isEditing ? null : _hints[_currentHintIndex],
              hintStyle: AppStyle.headlineMedium.copyWith(
                color: AppStyle.textHint,
              ),
              border: InputBorder.none,
            ),
          ),
          const SizedBox(height: 20),

          Row(
            children: [
              GestureDetector(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime.now().subtract(
                      const Duration(days: 365),
                    ),
                    lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
                  );
                  if (date != null) {
                    setState(() => _selectedDate = date);
                  }
                },
                child: Chip(
                  label: Text(DateFormat('d MMM').format(_selectedDate)),
                  avatar: const Icon(Icons.calendar_today, size: 16),
                  backgroundColor: AppStyle.white,
                  side: BorderSide(color: AppStyle.grey300),
                ),
              ),
              const SizedBox(width: 8),

              GestureDetector(
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: _selectedTime,
                  );
                  if (time != null) {
                    setState(() => _selectedTime = time);
                  }
                },
                child: Chip(
                  label: Text(_selectedTime.format(context)),
                  avatar: const Icon(Icons.access_time, size: 16),
                  backgroundColor: AppStyle.white,
                  side: BorderSide(color: AppStyle.grey300),
                ),
              ),

              Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: _saveReminder,
                  icon: Icon(_isEditing ? Icons.save : Icons.send, size: 16),
                  label: Text(_isEditing ? 'Edit Task' : 'Add Task'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppStyle.primaryColor,
                    foregroundColor: AppStyle.secondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildPriorityBadge() {
    if (!_isEditing) {
      Color color;
      String label;
      switch (_selectedPriority) {
        case Priority.high:
          color = AppStyle.priorityHighBg;
          label = 'HIGH';
          break;
        case Priority.medium:
          color = AppStyle.priorityMediumBg;
          label = 'MEDIUM';
          break;
        case Priority.low:
          color = AppStyle.priorityLowBg;
          label = 'LOW';
          break;
        default:
          color = AppStyle.priorityTodoBg;
          label = 'TO-DO';
      }

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(label, style: AppStyle.priorityLabel),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: Priority.values.map((priority) {
          final isSelected = _selectedPriority == priority;
          Color color;
          String label;

          switch (priority) {
            case Priority.high:
              color = isSelected
                  ? AppStyle.priorityHighBg
                  : AppStyle.transparent;
              label = 'High';
              break;
            case Priority.medium:
              color = isSelected
                  ? AppStyle.priorityMediumBg
                  : AppStyle.transparent;
              label = 'Medium';
              break;
            case Priority.low:
              color = isSelected
                  ? AppStyle.priorityLowBg
                  : AppStyle.transparent;
              label = 'Low';
              break;
            case Priority.none:
              color = isSelected
                  ? AppStyle.priorityTodoBg
                  : AppStyle.transparent;
              label = 'To-Do';
              break;
          }

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedPriority = priority;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? AppStyle.transparent : AppStyle.grey300,
                  width: 1,
                ),
              ),
              child: Text(
                label,
                style: AppStyle.priorityLabel.copyWith(
                  color: isSelected ? AppStyle.black : AppStyle.grey600,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _saveReminder() {
    if (_titleController.text.isEmpty) return;

    final reminderTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );

    final finalTime = reminderTime;

    final reminder = Reminder(
      id: widget.reminder?.id,
      title: _titleController.text,
      reminderTime: finalTime,
      priority: _selectedPriority,
      isCompleted: widget.reminder?.isCompleted ?? false,
    );

    context.read<ReminderBloc>().add(AddReminderEvent(reminder));
    Navigator.pop(context);
  }
}
