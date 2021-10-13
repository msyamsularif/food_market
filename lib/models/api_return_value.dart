part of 'models.dart';

class ApiReturnValue<T> {
  final T value;
  final String? message;

  ApiReturnValue({
    required this.value,
    this.message,
  });
}
