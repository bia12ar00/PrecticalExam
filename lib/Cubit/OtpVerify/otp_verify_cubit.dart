import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:practical_exam/Models/otp_verify_model.dart';
import 'package:practical_exam/api/post_repository.dart';

part 'otp_verify_state.dart';

class OtpVerifyCubit extends Cubit<OtpVerifyState> {
  OtpVerifyCubit() : super(const OtpVerifyState());

  PostRepository postRepository = PostRepository();

  void sendOtpVerifyData(Map<String, String> data) async {
    emit(state.copyWith(status: OtpVerifyStatus.loading));
    try {
      OtpVerifyModel? otpVerifyModel =
          await postRepository.sendOtpVerifyData(data);
      if (otpVerifyModel != null) {
        if (otpVerifyModel.status ?? false) {
          emit(state.copyWith(
              status: OtpVerifyStatus.success, otpVerifyModel: otpVerifyModel));
        }
      } else {
        emit(state.copyWith(error: 'Error', status: OtpVerifyStatus.failure));
      }
    } on DioError catch (ex) {
      if (ex.type == DioErrorType.unknown) {
        emit(state.copyWith(
            error:
                "Can't fetch Classes Data, please check your internet connection!",
            status: OtpVerifyStatus.failure));
      } else {
        emit(
            state.copyWith(error: ex.message, status: OtpVerifyStatus.failure));
      }
    }
  }
}
