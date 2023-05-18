import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:practical_exam/Models/welcome_data_model.dart';
import 'package:practical_exam/api/post_repository.dart';

part 'welcome_state.dart';

class WelcomeCubit extends Cubit<WelcomeState> {
  WelcomeCubit() : super(const WelcomeState());

  PostRepository postRepository = PostRepository();

  void sendWelcomeData(Map<String, String> data) async {
    emit(state.copyWith(status: WelcomeStatus.loading));
    try {
      WelcomeDataModel? welcomeDataModel =
          await postRepository.sendWelcomeData(data);
      if (welcomeDataModel != null) {
        if (welcomeDataModel.status ?? false) {
          emit(state.copyWith(
              status: WelcomeStatus.success,
              welcomeDataModel: welcomeDataModel));
        }
      } else {
        emit(state.copyWith(error: 'Error', status: WelcomeStatus.failure));
      }
    } on DioError catch (ex) {
      if (ex.type == DioErrorType.unknown) {
        emit(state.copyWith(
            error:
                "Can't fetch Classes Data, please check your internet connection!",
            status: WelcomeStatus.failure));
      } else {
        emit(state.copyWith(error: ex.message, status: WelcomeStatus.failure));
      }
    }
  }
}
