import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:practical_exam/Models/otp_data_model.dart';
import 'package:practical_exam/api/post_repository.dart';

part 'otp_send_state.dart';

class OtpSendCubit extends Cubit<OtpSendState> {
  OtpSendCubit() : super( const OtpSendState());
  PostRepository postRepository = PostRepository();

  void sendOtpData(Map<String, String> data) async {
    emit(state.copyWith(status: OtpSendStatus.loading));
    try {
      OtpDataModel? otpDataModel =
          await postRepository.sendOtpData(data);
      if (otpDataModel != null) {
        if (otpDataModel.status ?? false) {
          emit(state.copyWith(
              status: OtpSendStatus.success,
              otpDataModel: otpDataModel));
        }
      } else {
        emit(state.copyWith(error: 'Error', status: OtpSendStatus.failure));
      }
    } on DioError catch (ex) {
      if (ex.type == DioErrorType.unknown) {
        emit(state.copyWith(
            error:
                "Can't fetch Classes Data, please check your internet connection!",
            status: OtpSendStatus.failure));
      } else {
        emit(state.copyWith(
            error: ex.message, status: OtpSendStatus.failure));
      }
    }
  }
}
