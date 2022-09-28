import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tryproject/core/shared_manager.dart';
import 'package:tryproject/view/event_bus_page.dart';

import '../model/stories_model.dart';

EventBus eventBus = EventBus();

class StorySideBar extends StatefulWidget {
  StorySideBar(
      {super.key,
      required this.isClick,
      required this.controller,
      required this.index,
      required this.dataList});
  final AnimationController controller;
  final int index;
  final List<Data>? dataList;
  final bool isClick;

  @override
  State<StorySideBar> createState() => _StorySideBarState();
}

class _StorySideBarState extends State<StorySideBar> {
  ScrollController _scroll = ScrollController();

  TextEditingController _controllerMessage = TextEditingController();

  List<String> dataMessage = [];
  String? userProfPicture;
  bool? boolNot;
  int _pageIndex = 0;
  bool _isScroll = true;

  @override
  void initState() {
    super.initState();

    boolNot = widget.isClick;
    getData();
  }

  getData() async {
    var dataPicture =
        await SharedManager.instance.getStringValue(SharedKeys.PICTURE);
    if (mounted) {
      setState(() {
        userProfPicture = dataPicture;
      });
    }
  }

  _scrollTopTo() async {
    if (_scroll.hasClients) {
      await _scroll.animateTo(_scroll.position.maxScrollExtent,
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style =
        Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.only(left: 10),
            height: 50,
            width: 50,
            child: Text(
              "...",
              style: TextStyle(fontSize: 50, color: Colors.white),
            ),
          ),
        ),
        _profilImageButton(widget.dataList, widget.index),
        _sideBarItem(
            text: (widget.dataList!.length > 0)
                ? widget.dataList![widget.index].likeCount.toString()
                : "",
            onPressed: () {},
            style: style,
            icon: FaIcon(
              FontAwesomeIcons.solidHeart,
              color: Colors.white,
              size: 50,
            )),
        _sideBarItem(
            text: (widget.dataList!.length > 0)
                ? widget.dataList![widget.index].commentCount.toString()
                : "",
            onPressed: () {
              bottomSheetDialog(widget.dataList, widget.index);

              WidgetsBinding.instance
                  .addPostFrameCallback((_) => _scrollTopTo());
            },
            style: style,
            icon: FaIcon(
              FontAwesomeIcons.solidCommentDots,
              color: Colors.white,
              size: 50,
            )),
      ],
    );
  }

  _sideBarItem(
      {required TextStyle style,
      required FaIcon icon,
      required VoidCallback onPressed,
      required String text}) {
    return Column(
      children: [
        IconButton(
          iconSize: 45,
          onPressed: onPressed,
          icon: icon,
        ),
        Text(text, style: style)
      ],
    );
  }

  Widget _profilImageButton(List<Data>? dataList, int index) {
    return GestureDetector(
      onTap: () {
        widget.controller.forward().then((value) {
          boolNot = !boolNot!;

          eventBus.fire(BusPage(isClick: boolNot ?? true));
        }).then((value) => widget.controller.reverse());
      },
      child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(25),
                  image: DecorationImage(
                    image: NetworkImage((dataList!.length > 0)
                        ? dataList[index].user!.profilePic.toString()
                        : ""),
                  )),
            ),
            Positioned(
                bottom: -5,
                right: -5,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.green,
                  ),
                  child: Icon(Icons.add),
                )),
          ]),
    );
  }

  bottomSheetDialog(List<Data>? dataList, int index) {
    Future.delayed(Duration.zero, () {
      showModalBottomSheet(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          enableDrag: true,
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (BuildContext context, setState) {
                WidgetsBinding.instance
                    .addPostFrameCallback((_) => _scrollTopTo());

                return _bottomSheetBar(context, setState);
              },
            );
          });
    });
  }

  Widget _bottomSheetBar(BuildContext context, Function setState) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(DateFormat(' dd MMM').format(DateTime.now()).toString()),
                  Text((widget.dataList!.length > 0) &&
                          widget.dataList![widget.index].commentCount! > 1
                      ? widget.dataList![widget.index].commentCount.toString() +
                          " Comments"
                      : (widget.dataList!.length > 0) &&
                              widget.dataList![widget.index].commentCount! > 0
                          ? widget.dataList![widget.index].commentCount
                                  .toString() +
                              " Comment"
                          : ""),
                  IconButton(
                      onPressed: (() {
                        Navigator.pop(context);
                      }),
                      icon: Icon(Icons.close)),
                ],
              ),
              Divider(
                color: Colors.black12,
                thickness: 1,
              ),
            ],
          ),
          Expanded(
            child: Container(
              height: 300,
              child: ListView.builder(
                  controller: _scroll,
                  addAutomaticKeepAlives: true,
                  reverse: true,
                  scrollDirection: Axis.vertical,
                  physics: AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: dataMessage.length,
                  itemBuilder: ((context, index) {
                    return ListTile(
                        title: Row(
                      children: [
                        CircleAvatar(
                            backgroundImage:
                                NetworkImage(userProfPicture ?? "")),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text((dataMessage.length > 0
                              ? dataMessage[index]
                              : "")),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: FaIcon(
                                  FontAwesomeIcons.heart,
                                  color: Colors.grey,
                                  size: 25,
                                )),
                            Text("1")
                          ],
                        )
                      ],
                    ));
                  })),
            ),
          ),
          Column(
            children: [
              Divider(
                color: Colors.black12,
                thickness: 1,
              ),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(userProfPicture ?? ""),
                    radius: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: TextFormField(
                      controller: _controllerMessage,
                      style: TextStyle(
                        color: Colors.blueAccent,
                      ),
                      decoration: InputDecoration(
                        hintText: "Add Comment",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffix: GestureDetector(
                            onTap: () {
                              setState(() {
                                dataMessage.add(_controllerMessage.text);
                                List.from(dataMessage).reversed.toList();

                                _controllerMessage.clear();
                              });
                            },
                            child: Text(
                              "Post",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        suffixStyle: TextStyle(color: Colors.blueAccent),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40)),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
