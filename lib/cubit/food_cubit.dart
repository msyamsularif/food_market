import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_market/models/models.dart';
import 'package:food_market/services/services.dart';

part 'food_state.dart';

class FoodCubit extends Cubit<FoodState> {
  FoodCubit() : super(FoodInitial());

  Future<void> getFoods() async {
    ApiReturnValue<List<Food>>? result = await FoodService.getFoods();

    if (result != null) {
      emit(FoodLoaded(foods: result.value));
    } else {
      emit(FoodLoadingFailed(message: result!.message!));
    }
  }
}
