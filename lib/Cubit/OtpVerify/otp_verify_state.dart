part of 'otp_verify_cubit.dart';

enum OtpVerifyStatus { initial, loading, success, failure }

class OtpVerifyState extends Equatable {
  const OtpVerifyState({
    this.status = OtpVerifyStatus.initial,
    this.error,
    this.otpVerifyModel,
  });

  final OtpVerifyStatus status;
  final String? error;
  final OtpVerifyModel? otpVerifyModel;

  @override
  List<Object?> get props => [status, error];

  OtpVerifyState copyWith({
    OtpVerifyStatus? status,
    String? error,
    OtpVerifyModel? otpVerifyModel,
  }) {
    return OtpVerifyState(
      status: status ?? this.status,
      error: error ?? this.error,
      otpVerifyModel: otpVerifyModel ?? this.otpVerifyModel,
    );
  }
}
