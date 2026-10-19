import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/home_dashboard_model.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<HomeDashboardRequested>(_onDashboardRequested);
    on<HomeNotificationPermissionPromptDismissed>(_onPermissionPromptDismissed);
  }

  Future<void> _onDashboardRequested(
    HomeDashboardRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    await Future<void>.delayed(const Duration(milliseconds: 600));

    // Sample mock dashboard data strictly for Phase 1 UI presentation
    final mockDashboard = HomeDashboardModel(
      hijriDate: '15 Rabi al-Thani 1448',
      location: 'Dhaka, Bangladesh',
      nextPrayerName: 'Asr',
      nextPrayerTimeRemaining: '01:45:20',
      streakDays: 7,
      dailyGoalProgress: 3,
      dailyReflection:
          'Verily, in the remembrance of Allah do hearts find rest. (Surah Ar-Ra’d: 28)',
      prayers: const [
        PrayerTimeModel(name: 'Fajr', time: '04:45 AM', status: 'completed'),
        PrayerTimeModel(name: 'Dhuhr', time: '11:55 AM', status: 'completed'),
        PrayerTimeModel(name: 'Asr', time: '03:45 PM', status: 'ongoing'),
        PrayerTimeModel(name: 'Maghrib', time: '05:32 PM', status: 'upcoming'),
        PrayerTimeModel(name: 'Isha', time: '06:50 PM', status: 'upcoming'),
      ],
    );

    emit(state.copyWith(
      status: HomeStatus.success,
      dashboard: mockDashboard,
    ));
  }

  void _onPermissionPromptDismissed(
    HomeNotificationPermissionPromptDismissed event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(shouldShowNotificationPrompt: false));
  }
}
