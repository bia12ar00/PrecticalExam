part of 'welcome_cubit.dart';

enum WelcomeStatus { initial, loading, success, failure }

class WelcomeState extends Equatable {
  const WelcomeState({
    this.status = WelcomeStatus.initial,
    this.error,
    this.welcomeDataModel,
  });

  final WelcomeStatus status;
  final String? error;
  final WelcomeDataModel? welcomeDataModel;

  @override
  List<Object?> get props => [status, error];

  WelcomeState copyWith({
    WelcomeStatus? status,
    String? error,
    WelcomeDataModel? welcomeDataModel,
  }) {
    return WelcomeState(
      status: status ?? this.status,
      error: error ?? this.error,
      welcomeDataModel: welcomeDataModel ?? this.welcomeDataModel,
    );
  }
}
