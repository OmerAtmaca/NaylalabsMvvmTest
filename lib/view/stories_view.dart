import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tryproject/core/shared_manager.dart';
import 'package:tryproject/model/stories_model.dart';
import 'package:tryproject/services/login_service.dart';

import 'package:tryproject/view/story_description.dart';

import 'package:tryproject/view/video_view.dart';

import '../model/story_comments_model.dart';

class StoriesView extends StatefulWidget {
  const StoriesView({super.key});

  @override
  State<StoriesView> createState() => _StoriesViewState();
}

class _StoriesViewState extends State<StoriesView>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController _controller;
  late LoginService loginService;
  final TextEditingController _controllerMessage = TextEditingController();
  bool _isForYou = true;
  int pageIndex = 0;
  late PageController _pageController;
  bool _boolNot = true;
  List<Data>? dataList = [];
  String? userProfPicture;
  final ScrollController _scroll = ScrollController();
  final bool _isLoading = false;
  List<CommentData>? dataComment = [];
  String? commentId;
  @override
  void initState() {
    super.initState();
    loginService = LoginService();
    _pageController = PageController();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    Future.microtask(() async {
      await getData();
      await getDataPic();

      await getCommentData(
          (dataList!.isNotEmpty) ? dataList![pageIndex].sId ?? "" : "");
      setState(() {});

      setState(() {});
    });
  }

  getDataPic() async {
    userProfPicture =
        await SharedManager.instance.getStringValue(SharedKeys.PICTURE);
  }

  getCommentData(String commentId) async {
    dataComment = await loginService.fetchGetStoriesComment(commentId);
    setState(() {});
  }

  _scrollTopTo() async {
    if (_scroll.hasClients) {
      await _scroll.animateTo(_scroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  getData() async {
    dataList = await loginService.fetchUserGetLogin();

    userProfPicture =
        await SharedManager.instance.getStringValue(SharedKeys.PICTURE);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style =
        Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white);
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
    // getBusEvent();

    return Scaffold(
        extendBodyBehindAppBar: false,
        body: SafeArea(
            child: Stack(children: [
          PageView.builder(
              physics: const BouncingScrollPhysics(),
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  pageIndex = page;
                  WidgetsBinding.instance.addPostFrameCallback((_) async {
                    await getCommentData((dataList!.isNotEmpty)
                        ? dataList![pageIndex].sId ?? ""
                        : "");
                    setState(() {});
                  });
                });
              },
              scrollDirection: Axis.vertical,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Stack(alignment: Alignment.bottomCenter, children: [
                  VideoPage(
                      thumbnail: (dataList!.isNotEmpty)
                          ? dataList![index].videoUrl.toString()
                          : "",
                      currentIndex: index,
                      pageIndex: pageIndex,
                      videoURL: (dataList!.isNotEmpty)
                          ? dataList![index].videoUrl.toString()
                          : ""),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                              flex: 3,
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height / 4,
                                child: StoryDesc(
                                  caption: (dataList!.isNotEmpty)
                                      ? dataList![index].caption
                                      : "",
                                  title: (dataList!.isNotEmpty)
                                      ? dataList![index].title
                                      : "",
                                ),
                              )),
                          Expanded(
                              flex: 1,
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 2.2,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        height: 50,
                                        width: 50,
                                        child: const Text(
                                          "...",
                                          style: TextStyle(
                                              fontSize: 50,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    _profilImageButton(index),
                                    _sideBarItem(
                                        text: (dataList!.isNotEmpty)
                                            ? dataList![index]
                                                .likeCount
                                                .toString()
                                            : "",
                                        onPressed: () {},
                                        style: style,
                                        icon: const FaIcon(
                                          FontAwesomeIcons.solidHeart,
                                          color: Colors.white,
                                          size: 50,
                                        )),
                                    _sideBarItem(
                                        text: (dataList!.isNotEmpty)
                                            ? dataList![index]
                                                .commentCount
                                                .toString()
                                            : "",
                                        onPressed: () {
                                          bottomSheetDialog(
                                              dataList, index, dataComment);
                                          WidgetsBinding.instance
                                              .addPostFrameCallback((_) async {
                                            _scrollTopTo();
                                            setState(() {});
                                          });
                                          setState(() {});
                                        },
                                        style: style,
                                        icon: const FaIcon(
                                          FontAwesomeIcons.solidCommentDots,
                                          color: Colors.white,
                                          size: 50,
                                        )),
                                  ],
                                ),
                              )),
                        ],
                      ),
                      _forYouContainer(),
                    ],
                  ),
                ]);
              }),
          (_boolNot)
              ? (dataList?.length ?? 0) > 0
                  ? _customAppBar(pageIndex, style1, style2, style3)
                  : const SizedBox(
                      height: 0,
                    )
              : (dataList?.length ?? 0) > 0
                  ? _customAppBar2(pageIndex, style1, style2, style3)
                  : const SizedBox(
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
                  backgroundColor: const Color.fromARGB(51, 0, 0, 0),
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
                              backgroundImage: NetworkImage((dataList!
                                      .isNotEmpty)
                                  ? dataList![index].user!.profilePic.toString()
                                  : "https://www.technice.com.tw/wp-content/plugins/buddyboss-platform/bp-core/images/profile-avatar-buddyboss.png"),
                            ),
                            const SizedBox(
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
                                  const SizedBox(
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
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const SizedBox(
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
                    backgroundColor: const Color.fromARGB(51, 0, 0, 0),
                    leadingWidth: 200,
                    toolbarHeight: 200,
                    elevation: 0,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            SizedBox(
                              width: 10,
                            ),
                            Text("Superstars"),
                          ],
                        ),
                        Row(children: [
                          const Icon(Icons.play_arrow, size: 20),
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
    return SizedBox(
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
                    ? SizedBox(
                        width: 50,
                        child: const Divider(color: Colors.white, thickness: 3))
                    : const SizedBox.shrink(),
              ],
            ),
          ),
          const SizedBox(
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
                    ? SizedBox(
                        width: 50,
                        child: const Divider(color: Colors.white, thickness: 3))
                    : const SizedBox.shrink(),
              ],
            ),
          ),
          const SizedBox(
            width: 15,
          )
        ],
      ),
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

  Widget _profilImageButton(int index) {
    return GestureDetector(
      onTap: () {
        _controller.forward().then((value) {
          _boolNot = !_boolNot;
          setState(() {});
        }).then((value) => _controller.reverse());
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
                    image: NetworkImage((dataList!.isNotEmpty)
                        ? dataList![index].user!.profilePic.toString()
                        : "https://www.technice.com.tw/wp-content/plugins/buddyboss-platform/bp-core/images/profile-avatar-buddyboss.png"),
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
                  child: const Icon(Icons.add),
                )),
          ]),
    );
  }

  bottomSheetDialog(
      List<Data>? dataList, int index, List<CommentData>? dataComment) {
    Future.delayed(Duration.zero, () {
      showModalBottomSheet(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          enableDrag: true,
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (BuildContext context, setState) {
                WidgetsBinding.instance
                    .addPostFrameCallback((_) => _scrollTopTo());

                return _bottomSheetBar(context, setState, index, dataComment);
              },
            );
          });
    });
  }

  Widget _bottomSheetBar(BuildContext context, Function setState, int index,
      List<CommentData>? dataComment) {
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
                  Text((dataList!.isNotEmpty) &&
                          dataList![index].commentCount! > 1
                      ? "${dataList![index].commentCount} Comments"
                      : (dataList!.isNotEmpty) &&
                              dataList![index].commentCount! > 0
                          ? "${dataList![index].commentCount} Comment"
                          : ""),
                  IconButton(
                      onPressed: (() {
                        Navigator.pop(context);
                      }),
                      icon: const Icon(Icons.close)),
                ],
              ),
              const Divider(
                color: Colors.black12,
                thickness: 1,
              ),
            ],
          ),
          Expanded(
            child: SizedBox(
              height: 300,
              child: ListView.builder(
                  controller: _scroll,
                  addAutomaticKeepAlives: true,
                  reverse: true,
                  scrollDirection: Axis.vertical,
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: dataComment!.length,
                  itemBuilder: ((context, index) {
                    return Column(
                      children: [
                        ListTile(
                            title: Row(
                          children: [
                            CircleAvatar(
                                backgroundImage: NetworkImage((dataComment
                                        .isNotEmpty)
                                    ? dataComment[index]
                                        .user!
                                        .profilePic
                                        .toString()
                                    : "https://www.technice.com.tw/wp-content/plugins/buddyboss-platform/bp-core/images/profile-avatar-buddyboss.png")),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text((dataComment.isNotEmpty)
                                  ? dataComment[index].content ?? ""
                                  : "https://www.technice.com.tw/wp-content/plugins/buddyboss-platform/bp-core/images/profile-avatar-buddyboss.png"),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: (dataComment.isNotEmpty)
                                        ? dataComment[index].likeCount! > 0
                                            ? const FaIcon(
                                                FontAwesomeIcons.solidHeart,
                                                color: Colors.red,
                                                size: 25,
                                              )
                                            : const FaIcon(
                                                FontAwesomeIcons.heart,
                                                color: Colors.grey,
                                                size: 25,
                                              )
                                        : const SizedBox()),
                                Text((dataComment.isNotEmpty)
                                    ? dataComment[index].likeCount.toString()
                                    : "")
                              ],
                            )
                          ],
                        )),
                      ],
                    );
                  })),
            ),
          ),
          Column(
            children: [
              const Divider(
                color: Colors.black12,
                thickness: 1,
              ),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(userProfPicture ??
                        "https://www.technice.com.tw/wp-content/plugins/buddyboss-platform/bp-core/images/profile-avatar-buddyboss.png"),
                    radius: 20,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: TextFormField(
                      controller: _controllerMessage,
                      style: const TextStyle(
                        color: Colors.blueAccent,
                      ),
                      decoration: InputDecoration(
                        hintText: "Add Comment",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffix: GestureDetector(
                            onTap: () {
                              setState(() {
                                List.from(dataComment).reversed.toList();

                                _controllerMessage.clear();
                              });
                            },
                            child: const Text(
                              "Post",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        suffixStyle: const TextStyle(color: Colors.blueAccent),
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
