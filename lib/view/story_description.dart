import 'package:flutter/material.dart';

class StoryDesc extends StatefulWidget {
  const StoryDesc({super.key, required this.title, required this.caption});
  final String? title;
  final String? caption;
  @override
  State<StoryDesc> createState() => _StoryDescState();
}

class _StoryDescState extends State<StoryDesc> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            widget.title ?? "",
            maxLines: 4,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Text(
                widget.caption ?? "",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
