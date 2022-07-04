import 'dart:async';

import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class IFilterBLoc {
  FutureOr<void> onFetch(FetchFiltersEvent event, Emitter emit);
  FutureOr<void> onExpandSection(FilterExpandSectionEvent event, Emitter emit);
  FutureOr<void> onSelect(FilterSelectItemEvent event, Emitter emit);
  FutureOr<void> onRemove(FilterRemoveItemEvent event, Emitter emit);
  FutureOr<void> onRemoveAll(FilterRemoveAllEvent event, Emitter emit);
}
