import 'package:flutter/material.dart';

class HaloBottomBar extends StatefulWidget {
  const HaloBottomBar({Key? key}) : super(key: key);

  @override
  State<HaloBottomBar> createState() => _HaloBottomBarState();
}

class _HaloBottomBarState extends State<HaloBottomBar> {
  var currentSelected = 0;
  @override
  void initState() {
    super.initState();
  }

  List<IconData> bottomItem = [
    Icons.home,
    Icons.search,
    Icons.call,
    Icons.settings
  ];

  void bottomBarClick(int index) {
    currentSelected = index;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Theme.of(context).colorScheme.primary.withAlpha(60),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.1),
                offset: const Offset(0, 0),
                blurRadius: 5,
                spreadRadius: 5,
              )
            ],
          ),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: false,
              itemExtent: (MediaQuery.of(context).size.width-40)/4,
              itemCount: bottomItem.length,
              itemBuilder: (context, index) {
                return BottomBarIcon(bottomItem[index], index == currentSelected, index);
              })
          ),
    );
  }

  Widget BottomBarIcon(IconData iconData, bool selected, int index) {
    List<Color> colors = [Theme.of(context).colorScheme.secondary, Colors.transparent];
    return Container(
      decoration: selected == true ? BoxDecoration(
        gradient: RadialGradient(
          colors: colors
        ),) : null,
      child: IconButton(
          onPressed: () {
            setState(() {
              bottomBarClick(
                index
              );
            });
          },
          icon: Icon(iconData,
              size: 35,
              color: selected == true
                  ? Theme.of(context).colorScheme.primary
                  : null)),
    );
  }
}
