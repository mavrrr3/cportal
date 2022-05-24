import 'dart:async';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;

class FilterBloc extends Bloc<FilterEvent, FilterStateImpl> {
  FilterBloc() : super(const FilterStateImpl()) {
    _setupEvents();
  }

  void _setupEvents() {
    on<FilterInitEvent>(
      _onInit,
      transformer: bloc_concurrency.sequential(),
    );
    on<FilterExpandSectionEvent>(
      _onExpandSection,
      transformer: bloc_concurrency.sequential(),
    );
    on<FilterSelectItemEvent>(
      _onSelect,
      transformer: bloc_concurrency.sequential(),
    );
  }

  // Инициализация фильтра
  FutureOr<void> _onInit(
    FilterInitEvent event,
    Emitter emit,
  ) async {
    //: TODO запрос получения фильтров
    final List<FilterModel> mock = [
      FilterModel(
        headline: 'Компания',
        items: [
          FilterItemModel(name: 'АЭМ3'),
          FilterItemModel(name: 'Новосталь-М'),
          FilterItemModel(name: 'Демедия'),
        ],
      ),
      FilterModel(
        headline: 'Отдел',
        items: [
          FilterItemModel(name: 'Информационные технологии'),
          FilterItemModel(name: 'Отдел кадров'),
          FilterItemModel(name: 'Служба безопасности'),
          FilterItemModel(name: 'Менеджеры по документообороту'),
          FilterItemModel(name: 'Отдел мобильной разработки'),
          FilterItemModel(name: 'Отдел продаж'),
          FilterItemModel(name: 'Производственный отдел'),
          FilterItemModel(name: 'Отдел сбыта'),
          FilterItemModel(name: 'Администрация'),
        ],
      ),
    ];

    emit(FilterStateImpl(filters: mock));

    debugPrint('Отработал эвент: ' + event.toString());
  }

  // Обработка раскрытия раздела в фильтре
  void _onExpandSection(
    FilterExpandSectionEvent event,
    Emitter emit,
  ) {
    List<FilterModel> _filters = state.filters ?? [];
    _filters[event.index].isActive = !_filters[event.index].isActive;

    emit(FilterStateImpl(filters: _filters));

    debugPrint('Отработал эвент: ' + event.toString());
  }

  // Обработка выбора пункта в фильтре
  void _onSelect(
    FilterSelectItemEvent event,
    Emitter emit,
  ) {
    List<FilterModel> _filters = state.filters ?? [];
    _filters[event.filterIndex].items[event.itemIndex].isActive =
        !_filters[event.filterIndex].items[event.itemIndex].isActive;

    emit(FilterStateImpl(filters: _filters));

    debugPrint('Отработал эвент: ' + event.toString());
  }
}
