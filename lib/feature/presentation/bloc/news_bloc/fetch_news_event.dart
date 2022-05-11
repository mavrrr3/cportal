import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';
import 'package:equatable/equatable.dart';

abstract class FetchNewsEvent extends Equatable {
  const FetchNewsEvent();

  @override
  List<Object> get props => [];
}

class FetchNewsEventImpl extends FetchNewsEvent {
  final NewsCodeEnum newsCodeEnum;
  const FetchNewsEventImpl({required this.newsCodeEnum});
}
