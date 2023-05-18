part of 'otp_send_cubit.dart';

enum OtpSendStatus { initial, loading, success, failure }

class OtpSendState extends Equatable {
  const OtpSendState({
    this.status = OtpSendStatus.initial,
    this.error,
    this.otpDataModel,
  });

  final OtpSendStatus status;
  final String? error;
  final OtpDataModel? otpDataModel;

  @override
  List<Object?> get props => [status, error];

  OtpSendState copyWith({
    OtpSendStatus? status,
    String? error,
    OtpDataModel? otpDataModel,
  }) {
    return OtpSendState(
      status: status ?? this.status,
      error: error ?? this.error,
      otpDataModel: otpDataModel ?? this.otpDataModel,
    );
  }
}
