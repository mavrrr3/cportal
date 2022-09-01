import 'package:cportal_flutter/feature/presentation/bloc/questions_bloc/fetch_questions_bloc.dart';
import 'package:cportal_flutter/feature/presentation/ui/questions_page/all_questions_list/all_questions_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionsPage extends StatelessWidget {
  const QuestionsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchQuestionsBloc, FetchQuestionsState>(
      builder: (context, state) {
        if (state is QuestionsLoading) {
          return AllQuestionsPage(
            categories: state.tabs,
          );
        }
        if (state is QuestionsLoaded) {
          return AllQuestionsPage(
            categories: state.tabs,
          );
        }

        return const Loader();
      },
    );
  }
}
