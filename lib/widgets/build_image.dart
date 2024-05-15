import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webfeed/domain/rss_item.dart';

Widget buildImage(RssItem item) {
  // Verifica se há conteúdo no item RSS
  if (item.content != null) {
    // Verifica se há uma tag <img> no conteúdo do item
    final RegExp regExp = RegExp(r'<img[^>]+src="([^"]+)"');
    final match = regExp.firstMatch(item.content!.value);
    if (match != null) {
      final imageUrl = match.group(1);
      if (kDebugMode) {
        print('URL da imagem: $imageUrl');
      }
      if (imageUrl != null) {
        // Tentativa de carregar a imagem
        return Image.network(
          imageUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              // Imagem carregada com sucesso
              return child;
            } else {
              // Imagem ainda está sendo carregada
              return const CircularProgressIndicator();
            }
          },
          errorBuilder:
              (BuildContext context, Object error, StackTrace? stackTrace) {
            // Ocorreu um erro ao carregar a imagem
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
      }
    }
  }
  // Se não houver conteúdo ou imagem, exibe um ícone padrão
  return Container(
    width: 50,
    height: 50,
    color: Colors.grey,
    child: const Icon(Icons.image),
  );
}
