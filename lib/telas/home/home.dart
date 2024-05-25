import 'package:canaltech/service/service_rss.dart';
import 'package:canaltech/telas/post/post_page.dart';
import 'package:canaltech/widgets/build_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importe para formatação de data
import 'package:webfeed_revised/domain/rss_feed.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RssFeed? _feed;

  @override
  void initState() {
    super.initState();
    _loadFeed();
  }

  Future<void> _loadFeed() async {
    String rssUrl =
        'https://canaltech.com.br/rss/'; // Substitua pela URL do seu feed RSS
    var feed = await RSSService.loadFeed(rssUrl);
    if (feed != null) {
      setState(() {
        _feed = feed;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Canaltech'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_feed == null) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    } else {
      return ListView.builder(
        itemCount: _feed!.items!.length,
        itemBuilder: (BuildContext context, int index) {
          var item = _feed!.items![index];
          return Card(
            clipBehavior: Clip.hardEdge,
            child: ListTile(
              title: Text(item.title ?? ''),
              subtitle: Text(_formatDate(item.pubDate) ?? ''),
              leading: buildImage(item),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostPage(item: item),
                  ),
                );
              },
            ),
          );
        },
      );
    }
  }

  String? _formatDate(DateTime? date) {
    if (date != null) {
      return DateFormat('dd/MM/yyyy - HH:mm').format(date);
    } else {
      return null;
    }
  }
}
