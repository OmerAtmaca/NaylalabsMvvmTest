import 'package:flutter/material.dart';
import '../services/login_service.dart';
import 'custom_list_tile.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin {
  late final LoginService loginService;
  String token = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginService = LoginService();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _appBar,
        _futureBuilder,
      ],
    );
  }

  Widget get _futureBuilder => FutureBuilder(
      future: loginService.fetchUserGetLogin(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());

          default:
            if (snapshot.hasData) {
              return _listViewBuilder(snapshot);
            } else {
              return const Text("error");
            }
        }
      });

  Widget _listViewBuilder(AsyncSnapshot snapshot) => Expanded(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: snapshot.data!.length, //snapshot.data!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  elevation: 1,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  color: const Color.fromARGB(157, 225, 224, 224),
                  child: SizedBox(
                      height: 150,
                      child: _customListItem(context, snapshot, index)),
                ),
              );
            }),
      );

  Widget _customListItem(
          BuildContext contex, AsyncSnapshot snapshot, int index) =>
      CustomListItem(
        title: "${snapshot.data![index].user!.fullName}",
        subtitle: "${snapshot.data![index].user!.title}",
        author: "${snapshot.data![index].user!.company}",
        publishDate: "${snapshot.data![index].user!.professionalCategory}",
        readDuration: "${snapshot.data![index].user!.location}",
        thumbnail: "${snapshot.data![index].thumbnail}",
        followerCount: "${snapshot.data![index].user!.followerCount}",
        starPointCount: "${snapshot.data![index].user!.starPointCount}",
        profilePic: "${snapshot.data![index].user!.profilePic}",
      );

  @override
  bool get wantKeepAlive => false;

  Widget get _appBar => Container(
        height: 150,
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      );
}
