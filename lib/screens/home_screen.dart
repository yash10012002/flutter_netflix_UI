import 'package:flutter/material.dart';
import 'package:flutter_netflix/cubits/app_bar/app_bar_cubit.dart';
import 'package:flutter_netflix/data/data.dart';
import 'package:flutter_netflix/widgets/content_list.dart';
import '../widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({required Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    final appBarCubit =
        context.read<AppBarCubit>(); // Access the cubit using context.read
    appBarCubit.setOffset(_scrollController.offset);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[850],
        child: const Icon(Icons.cast),
        onPressed: () => print("Cast"),
      ),
      appBar: PreferredSize(
          preferredSize: Size(screenSize.width, 50.0),
          child: BlocBuilder<AppBarCubit, double>(
            builder: (context, scrollOffset) {
              return CustomeAppBar(scrollOffset: scrollOffset);
            },
          )),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: 500,
              child: CustomHeader(featuredContent: sintelContent),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(top: 0.0),
            sliver: SliverToBoxAdapter(
              child: Previews(
                  key: PageStorageKey('previews'),
                  title: "Previews",
                  contentList: previews),
            ),
          ),
          SliverToBoxAdapter(
            child: ContentList(
              key: PageStorageKey('myList'),
              title: "My List",
              contentList: myList,
            ),
          ),
          SliverToBoxAdapter(
            child: ContentList(
              key: PageStorageKey('originals'),
              title: "Netflix Originals",
              contentList: originals,
              isOriginals: true,
            ),
          ),
          SliverToBoxAdapter(
            child: ContentList(
              key: PageStorageKey('trending'),
              title: "Trending",
              contentList: trending,
            ),
          ),
        ],
      ),
    );
  }
}
