import 'package:equatable/equatable.dart';
import '../../data/models/home_dashboard_model.dart';

enum HomeStatus { initial, loading, success, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final HomeDashboardModel? dashboard;
  final bool shouldShowNotificationPrompt;
  final String? errorMessage;

  const HomeState({
    this.status = HomeStatus.initial,
    this.dashboard,
    this.shouldShowNotificationPrompt = true,
    this.errorMessage,
  });

  HomeState copyWith({
    HomeStatus? status,
    HomeDashboardModel? dashboard,
    bool? shouldShowNotificationPrompt,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      dashboard: dashboard ?? this.dashboard,
      shouldShowNotificationPrompt:
          shouldShowNotificationPrompt ?? this.shouldShowNotificationPrompt,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        dashboard,
        shouldShowNotificationPrompt,
        errorMessage,
      ];
}
