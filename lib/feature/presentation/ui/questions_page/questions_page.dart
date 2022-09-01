import 'package:cportal_flutter/feature/presentation/bloc/questions_bloc/fetch_questions_bloc.dart';
import 'package:cportal_flutter/feature/presentation/ui/questions_page/all_questions_list/all_questions_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/platform_progress_indicator.dart';
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
          return const Center(child: PlatformProgressIndicator());
        }

        return AllQuestionsPage(
          categories: (state as QuestionsLoaded).tabs,
        );
      },
    );
  }
}
