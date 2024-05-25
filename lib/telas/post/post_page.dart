import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:webfeed_revised/domain/rss_item.dart';

class PostPage extends StatelessWidget {
  final RssItem item;

  const PostPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Canaltech"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title ?? '',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(item.pubDate?.toString() ?? ''),
              const Divider(),
               Html(
                data: item.description ?? '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
