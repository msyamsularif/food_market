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
      emit(TransactionLoaded(transaction: result.value!));
    } else {
      emit(TransactionLoadingFailed(message: result!.message!));
    }
  }

  Future<String?> submitTransaction(Transaction transaction) async {
    ApiReturnValue<Transaction>? result =
        await TransactionServices.submitTransaction(transaction);

    if (result!.value != null) {
      emit(
        TransactionLoaded(
          transaction:
              (state as TransactionLoaded).transaction + [result.value!],
        ),
      );
      return result.value!.paymentUrl!;
    } else {
      return "No Data";
    }
  }
}
