import 'package:flutter/material.dart';
import 'package:rickandmorty/models/location_model.dart';

class LocationsListview extends StatefulWidget {
  final LocationModel locationModel;
  final VoidCallback? onLoadMore;
  final bool moreLoad;
  const LocationsListview(
      {super.key,
      required this.locationModel,
      this.onLoadMore,
      required this.moreLoad});

  @override
  State<LocationsListview> createState() => _LocationsListviewState();
}

class _LocationsListviewState extends State<LocationsListview> {
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
      itemCount: widget.locationModel.locations.length,
      itemBuilder: (context, index) {
        final LocationItem locationModelItem =
            widget.locationModel.locations[index];
        return Column(
          children: [
            ListTile(
              leading: const Icon(
                Icons.location_on_sharp,
              ),
              title: Text(
                locationModelItem.name,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Column(
                children: [
                  _subtitleItem(text: "Tür: ", value: locationModelItem.type),
                  _subtitleItem(
                      text: "Kişi Sayısı: ",
                      value: locationModelItem.residents.length.toString()),
                ],
              ),
            ),
            if (widget.moreLoad &&
                index == widget.locationModel.locations.length - 1)
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Center(child: CircularProgressIndicator()),
              )
          ],
        );
      },
    );
  }

  Widget _subtitleItem({required String text, required String value}) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w300,
          ),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 10),
        )
      ],
    );
  }
}
