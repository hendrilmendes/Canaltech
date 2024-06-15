import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:webfeed_revised/domain/rss_item.dart';

class PostPage extends StatelessWidget {
  final RssItem item;

  const PostPage({super.key, required this.item});

  String? _formatDate(DateTime? date) {
    if (date != null) {
      return DateFormat('dd/MM/yyyy - HH:mm').format(date);
    } else {
      return null;
    }
  }

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
              if (item.enclosure?.url != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    item.enclosure!.url!,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 16.0),
              Text(
                item.title ?? 'Sem título',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.black87,
                    ),
              ),
              const SizedBox(height: 8.0),
              Text(
                item.pubDate != null
                    ? 'Publicado em ${_formatDate(item.pubDate)}'
                    : 'Data não disponível',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.grey[600]),
              ),
              const Divider(),
              Html(
                data: item.description ?? 'Sem descrição disponível.',
                style: {
                  'body': Style(
                    fontSize: FontSize.large,
                    lineHeight: const LineHeight(1.5),
                    color: Colors.black87,
                  ),
                },
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
