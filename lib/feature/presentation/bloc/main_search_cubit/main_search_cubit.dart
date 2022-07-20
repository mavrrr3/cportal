import 'package:cportal_flutter/feature/domain/usecases/main_search_usecase.dart';
import 'package:cportal_flutter/feature/presentation/bloc/main_search_cubit/main_search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainSearchCubit extends Cubit<MainSearchState> {
  final MainSearchUseCase search;

  MainSearchCubit(this.search) : super(MainSearchEmpty());
}
