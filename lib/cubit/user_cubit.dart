import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_market/models/models.dart';
import 'package:food_market/services/services.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'user_state.dart';

class UserCubit extends HydratedCubit<UserState> {
  UserCubit() : super(UserInitial());

  Future<void> signIn(String email, String password) async {
    ApiReturnValue<User>? result = await UserService.signIn(email, password);

    if (result!.value != null) {
      emit(UserLoaded(user: result.value!));
    } else {
      emit(UserLoadingFailed(message: result.message!));
    }
  }

  Future<void> signUp(User user, String password, {File? pictureFile}) async {
    ApiReturnValue<User> result =
        await UserService.signUp(user, password, pictureFile: pictureFile);

    if (result.value != null) {
      emit(UserLoaded(user: result.value!));
    } else {
      emit(UserLoadingFailed(message: result.message!));
    }
  }

  Future<void> uploadProfilePicture(File? pictureFile) async {
    ApiReturnValue<String> result =
        await UserService.uploadProfilePicture(pictureFile!);

    if (result.value != null) {
      emit(
        UserLoaded(
          user: (state as UserLoaded).user.copyWith(
              picturePath:
                  "http://foodmarket-backend.buildwithangga.id/storage/" +
                      result.value!),
        ),
      );
    }
  }

  Future<void> logOut() async {
    ApiReturnValue<bool> result = await UserService.logOut();

    if (result.value != null) {
      emit(UserInitial());
    } else {
      emit(UserLoadingFailed(message: result.message!));
    }
  }

  @override
  UserState? fromJson(Map<String, dynamic> json) {
    User.token = json['access_token'];
    if (User.token != null) {
      User user = User.fromJson(json['user']);
      return UserLoaded(user: user);
    }
    return UserInitial();
  }

  @override
  Map<String, dynamic>? toJson(UserState state) {
    if (state is UserLoaded) {
      return <String, dynamic>{
        'user': state.user.toJson(),
        'access_token': User.token
      };
    }
    return <String, dynamic>{'user': null, 'access_token': null};
  }
}
