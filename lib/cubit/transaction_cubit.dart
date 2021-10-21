import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_market/models/models.dart';
import 'package:food_market/services/services.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit() : super(TransactionInitial());

  Future<void> getTransaction() async {
    ApiReturnValue<List<Transaction>>? result =
        await TransactionServices.getTransaction();

    if (result != null) {
      emit(TransactionLoaded(transaction: result.value));
    } else {
      emit(TransactionLoadingFailed(message: result!.message!));
    }
  }

  Future<bool> submitTransaction(Transaction transaction) async {
    ApiReturnValue<Transaction>? result =
        await TransactionServices.submitTransaction(transaction);

    if (result != null) {
      emit(
        TransactionLoaded(
          transaction:
              (state as TransactionLoaded).transaction + [result.value],
        ),
      );
      print("DISINI - ${result.value}");
      return true;
    } else {
      return false;
    }
  }
}
