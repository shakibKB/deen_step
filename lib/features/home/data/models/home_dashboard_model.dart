import 'package:equatable/equatable.dart';

class PrayerTimeModel extends Equatable {
  final String name;
  final String time;
  final String status; // completed, ongoing, upcoming, missed

  const PrayerTimeModel({
    required this.name,
    required this.time,
    required this.status,
  });

  @override
  List<Object?> get props => [name, time, status];
}

class HomeDashboardModel extends Equatable {
  final String hijriDate;
  final String location;
  final String nextPrayerName;
  final String nextPrayerTimeRemaining;
  final int streakDays;
  final int dailyGoalProgress;
  final String? dailyReflection;
  final List<PrayerTimeModel> prayers;

  const HomeDashboardModel({
    required this.hijriDate,
    required this.location,
    required this.nextPrayerName,
    required this.nextPrayerTimeRemaining,
    required this.streakDays,
    required this.dailyGoalProgress,
    this.dailyReflection,
    required this.prayers,
  });

  @override
  List<Object?> get props => [
        hijriDate,
        location,
        nextPrayerName,
        nextPrayerTimeRemaining,
        streakDays,
        dailyGoalProgress,
        dailyReflection,
        prayers,
      ];
}
