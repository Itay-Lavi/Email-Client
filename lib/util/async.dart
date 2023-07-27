// ignore: depend_on_referenced_packages
import 'package:async/async.dart';

CancelableOperation<void>? _operation;

Future<void> performAsyncOperation(Future<void> callBackFunc) async {
  _operation?.cancel();

  _operation = CancelableOperation.fromFuture(
    callBackFunc,
  );
  await _operation!.value;
}

void dispose() {
  _operation?.cancel();
}
