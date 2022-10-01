import 'package:flutter/material.dart';

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    super.key,
    required this.thumbnail,
    required this.title,
    required this.subtitle,
    required this.author,
    required this.publishDate,
    required this.readDuration,
    required this.followerCount,
    required this.starPointCount,
    required this.profilePic,
  });

  final String thumbnail;
  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String readDuration;
  final String followerCount;
  final String starPointCount;
  final String profilePic;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            flex: 3,
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xff7c94b6),
                  image: DecorationImage(
                    image: NetworkImage(thumbnail),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              IconButton(
                onPressed: (() {}),
                icon: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 30,
                ),
              )
            ])),
        Expanded(
          flex: 5,
          child: _ArticleDescription(
            title: title,
            subtitle: subtitle,
            author: author,
            publishDate: publishDate,
            readDuration: readDuration,
            followerCount: followerCount,
            starPointCount: starPointCount,
            profilePic: profilePic,
          ),
        ),
      ],
    );
  }
}

class _ArticleDescription extends StatelessWidget {
  const _ArticleDescription({
    required this.title,
    required this.subtitle,
    required this.author,
    required this.publishDate,
    required this.readDuration,
    required this.followerCount,
    required this.starPointCount,
    required this.profilePic,
  });

  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String readDuration;
  final String followerCount;
  final String starPointCount;
  final String profilePic;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        const Padding(padding: EdgeInsets.only(bottom: 5.0)),
        Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 10.0)),
        Text(
          subtitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 10,
            color: Colors.black54,
          ),
        ),
        Text(
          author,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.black87,
          ),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 5)),
        Text(
          publishDate,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 10,
            color: Colors.blue,
          ),
        ),
        Text(
          readDuration,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.blue,
          ),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 5.0)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  followerCount,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  "Followers",
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0x726A6A6A),
                  ),
                ),
              ],
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(profilePic),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  starPointCount,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  "Star Points",
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0x726A6A6A),
                  ),
                )
              ],
            )
          ],
        ),
        Expanded(
          child: SizedBox(
            width: 200,
            height: 20,
            child: ElevatedButton(

                // style: ElevatedButton.styleFrom(backgroundColor: Colors.white,textStyle: TextStyle(fontSize: 15),),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: BorderSide(color: Colors.green)))),
                onPressed: () {},
                child: Text(
                  "Following",
                  style: TextStyle(color: Colors.green),
                )),
          ),
        )
      ],
    );
  }
}
