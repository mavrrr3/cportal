import 'dart:async';

abstract class IFilterBloc {
  FutureOr<void> onFetch();
}
