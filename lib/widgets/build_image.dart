import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webfeed_revised/webfeed_revised.dart';

Widget buildImage(RssItem item) {
  final RegExp regExp = RegExp(r'<img[^>]+src="([^"]+)"');
  String? imageUrl;

  // extrair a imagem do conteúdo
  if (item.content != null) {
    final match = regExp.firstMatch(item.content!.value);
    if (match != null) {
      imageUrl = match.group(1);
    }
  }

  // se não encontrar imagem no conteúdo, tentar na descrição
  if (imageUrl == null && item.description != null) {
    final match = regExp.firstMatch(item.description!);
    if (match != null) {
      imageUrl = match.group(1);
    }
  }

  if (kDebugMode) {
    print('URL da imagem: $imageUrl');
  }

  if (imageUrl != null) {
    return Image.network(
      imageUrl,
      width: 50,
      height: 50,
      fit: BoxFit.cover,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        } else {
          return const CircularProgressIndicator.adaptive();
        }
      },
      errorBuilder:
          (BuildContext context, Object error, StackTrace? stackTrace) {
        if (kDebugMode) {
          print('Erro ao carregar a imagem: $error');
        }
        return Container(
          width: 50,
          height: 50,
          color: Colors.grey,
          child: const Icon(Icons.error),
        );
      },
    );
  } else {
    return Container(
      width: 50,
      height: 50,
      color: Colors.grey,
      child: const Icon(Icons.image),
    );
  }
}
