import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/router.dart';
import '../../models/episodes_model.dart';

class EpisodesListview extends StatefulWidget {
  final VoidCallback? onLoadMore;
  final List<EpisodesModel> episodes;
  final bool loadMore;
  const EpisodesListview(
      {super.key,
      required this.episodes,
      this.onLoadMore,
      required this.loadMore});

  @override
  State<EpisodesListview> createState() => _EpisodesListviewState();
}

class _EpisodesListviewState extends State<EpisodesListview> {
  final scroller = ScrollController();

  @override
  void initState() {
    dedectScrollBottom();
    super.initState();
  }

  void dedectScrollBottom() {
    if (widget.onLoadMore != null) {
      scroller.addListener(() {
        final maxScroll = scroller.position.maxScrollExtent;
        final currentScroll = scroller.position.pixels;
        if (maxScroll - currentScroll <= 200) {
          widget.onLoadMore!();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scroller,
      padding: EdgeInsets.zero,
      separatorBuilder: (context, index) => Divider(
          endIndent: 40,
          height: 0,
          indent: 40,
          color: Theme.of(context).colorScheme.tertiary),
      itemCount: widget.episodes.length,
      itemBuilder: (context, index) {
        final EpisodesModel model = widget.episodes[index];
        return ListTile(
          onTap: () => context.push(AppRoutes.sectionCharacter, extra: model),
          leading: Icon(
            Icons.face_retouching_natural,
            size: 35,
          ),
          title: Text(
            model.episode,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            model.name,
            style: TextStyle(fontSize: 12),
          ),
        );
      },
    );
  }
}
