import 'package:cportal_flutter/common/util/is_larger_then.dart';
import 'package:cportal_flutter/feature/presentation/bloc/questions_bloc/fetch_questions_bloc.dart';
import 'package:cportal_flutter/feature/presentation/ui/questions_page/all_questions_list/questions_page_mobile.dart';
import 'package:cportal_flutter/feature/presentation/ui/questions_page/all_questions_list/questions_page_web_tablet.dart';
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
          return isMobile(context)
              ? QuestionsPageMobile(categories: state.tabs)
              : QuestionsPageWebTablet(categories: state.tabs);
        }
        if (state is QuestionsLoaded) {
          return isMobile(context)
              ? QuestionsPageMobile(categories: state.tabs)
              : QuestionsPageWebTablet(categories: state.tabs);
        }

        return const Loader();
      },
    );
  }
}
