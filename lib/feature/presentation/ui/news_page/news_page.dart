import 'package:cportal_flutter/common/util/is_larger_then.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/all_news_list/news_page_mobile.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/all_news_list/news_page_web_tablet.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchNewsBloc, FetchNewsState>(
      builder: (context, state) {
        if (state is NewsLoading) {
          return isMobile(context) ? NewsPageMobile(categories: state.tabs) : NewsPageWebTablet(categories: state.tabs);
        }
        if (state is NewsLoaded) {
          return isMobile(context) ? NewsPageMobile(categories: state.tabs) : NewsPageWebTablet(categories: state.tabs);
        }

        return const Loader();
      },
    );
  }
}
