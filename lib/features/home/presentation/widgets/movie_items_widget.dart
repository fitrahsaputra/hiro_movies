import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../../core.dart';

class MovieItemsWidget extends StatelessWidget {
  const MovieItemsWidget({
    super.key,
    required this.data,
  });

  final Result data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, RoutesName.detailMovie,
                arguments: data.id),
            child: Hero(
              tag: data.id,
              child: Image.network(
                dotenv.env['IMAGE_PATH'].toString() + data.posterPath,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            data.originalTitle,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
