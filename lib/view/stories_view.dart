import 'package:flutter/material.dart';
import 'package:tryproject/core/shared_manager.dart';
import 'package:tryproject/model/stories_model.dart';
import 'package:tryproject/services/login_service.dart';
import 'package:tryproject/view/event_bus_page.dart';
import 'package:tryproject/view/story_description.dart';
import 'package:tryproject/view/story_side_bar.dart';

class StoriesView extends StatefulWidget {
  const StoriesView({super.key});

  @override
  State<StoriesView> createState() => _StoriesViewState();
}

class _StoriesViewState extends State<StoriesView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late LoginService loginService;

  bool _isForYou = true;
  int pageIndex = 0;
  late PageController _pageController;
  bool? _boolNot;
  List<Data>? dataList = [];
  String? userProfPicture;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));

    getBusEvent();
    getData();
  }

  getBusEvent() {
    eventBus.on<BusPage>().listen((event) {
      if (mounted) {
        setState(() {
          _boolNot = event.isClick;
        });
      }
    });
  }

  getData() async {
    loginService = LoginService();
    var dataStory = await loginService.fetchUserGetLogin();

    var dataPicture =
        await SharedManager.instance.getStringValue(SharedKeys.PICTURE);
    if (mounted) {
      setState(() {
        userProfPicture = dataPicture;
        dataList = dataStory;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? style1 = Theme.of(context).textTheme.bodyText1!.copyWith(
        fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold);
    TextStyle? style2 = Theme.of(context)
        .textTheme
        .bodyText1!
        .copyWith(fontSize: 12, color: Colors.white54);
    TextStyle? style3 = Theme.of(context).textTheme.bodyText1!.copyWith(
        fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold);
    TextStyle? style4 = Theme.of(context).textTheme.bodyText1!.copyWith(
        fontSize: 1, color: Colors.white, fontWeight: FontWeight.bold);
    return Scaffold(
        extendBodyBehindAppBar: false,
        body: SafeArea(
            child: Stack(children: [
          PageView.builder(
              physics: BouncingScrollPhysics(),
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  pageIndex = page;
                });
              },
              scrollDirection: Axis.vertical,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Stack(alignment: Alignment.bottomCenter, children: [
                  Container(
                    color: Colors.amber,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                              flex: 3,
                              child: Container(
                                height: MediaQuery.of(context).size.height / 4,
                                child: StoryDesc(),
                              )),
                          Expanded(
                              flex: 1,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height / 2.2,
                                child: StorySideBar(
                                  controller: _controller,
                                  index: index,
                                  dataList: dataList,
                                ),
                              )),
                        ],
                      ),
                      _forYouContainer(),
                    ],
                  ),
                ]);
              }),
          (_boolNot ?? true)
              ? (dataList?.length ?? 0) > 0
                  ? _customAppBar(pageIndex, style1, style2, style3)
                  : SizedBox(
                      height: 0,
                    )
              : (dataList?.length ?? 0) > 0
                  ? _customAppBar2(pageIndex, style1, style2, style3)
                  : SizedBox(
                      height: 0,
                    ),
        ])));
  }

  Widget _customAppBar(
          int index, TextStyle style1, TextStyle style2, TextStyle style3) =>
      AnimatedBuilder(
          animation: _controller,
          builder: (context, child) => Positioned(
              bottom: MediaQuery.of(context).size.height - 200,
              top: 0,
              right: 0,
              left: 0,
              child: Transform.translate(
                offset: Offset(0, -_controller.value * 150),
                child: AppBar(
                  automaticallyImplyLeading: false,
                  centerTitle: false,
                  backgroundColor: Color.fromARGB(51, 0, 0, 0),
                  leadingWidth: 200,
                  toolbarHeight: 200,
                  elevation: 0,
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.black,
                              backgroundImage: NetworkImage((dataList!.length >
                                      0)
                                  ? dataList![index].user!.profilePic.toString()
                                  : ""),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              dataList?[index].user!.fullName ?? "",
                              style: style3,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Text(
                                    dataList?[index]
                                            .user!
                                            .followerCount
                                            .toString() ??
                                        "",
                                    style: style1,
                                  ),
                                  Text(
                                    dataList?[index]
                                            .user!
                                            .starPointCount
                                            .toString() ??
                                        "",
                                    style: style1,
                                  ),
                                ]),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Text(
                                    "Followers",
                                    style: style2,
                                  ),
                                  Text(
                                    "Starpoints",
                                    style: style2,
                                  ),
                                ]),
                          ],
                        ),
                      ]),
                ),
              )));

  Widget _customAppBar2(
          int index, TextStyle style1, TextStyle style2, TextStyle style3) =>
      AnimatedBuilder(
          animation: _controller,
          builder: (context, child) => Positioned(
                bottom: MediaQuery.of(context).size.height - 200,
                top: 0,
                right: 0,
                left: 0,
                child: Transform.translate(
                  offset: Offset(0, -_controller.value * 150),
                  child: AppBar(
                    automaticallyImplyLeading: false,
                    centerTitle: false,
                    backgroundColor: Color.fromARGB(51, 0, 0, 0),
                    leadingWidth: 200,
                    toolbarHeight: 200,
                    elevation: 0,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text("Superstars"),
                          ],
                        ),
                        Row(children: [
                          Icon(Icons.play_arrow, size: 20),
                          Text(
                            dataList?[index].viewCount.toString() ?? "",
                            style: style1,
                          ),
                        ]),
                      ],
                    ),
                  ),
                ),
              ));

  Widget _forYouContainer() {
    return Container(
      height: MediaQuery.of(context).size.height / 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isForYou = true;
              });
            },
            child: Column(
              children: [
                Text(
                  "For You",
                  style: _isForYou
                      ? Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)
                      : Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 16, color: Colors.white60),
                ),
                _isForYou
                    ? Container(
                        width: 50,
                        child: Divider(color: Colors.white, thickness: 3))
                    : SizedBox.shrink(),
              ],
            ),
          ),
          SizedBox(
            width: 12,
          ),
          GestureDetector(
            onTap: (() {
              setState(() {
                _isForYou = false;
              });
            }),
            child: Column(
              children: [
                Text(
                  "Newest",
                  style: !_isForYou
                      ? Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)
                      : Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 16, color: Colors.white60),
                ),
                !_isForYou
                    ? Container(
                        width: 50,
                        child: Divider(color: Colors.white, thickness: 3))
                    : SizedBox.shrink(),
              ],
            ),
          ),
          SizedBox(
            width: 15,
          )
        ],
      ),
    );
  }
}
