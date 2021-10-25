import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_market/models/models.dart';
import 'package:food_market/services/services.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Future<void> signIn(String email, String password) async {
    ApiReturnValue<User>? result = await UserService.signIn(email, password);

    if (result != null) {
      emit(UserLoaded(user: result.value!));
    } else {
      emit(UserLoadingFailed(message: result!.message!));
    }
  }
}
