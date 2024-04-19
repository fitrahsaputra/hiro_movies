import 'package:flutter/material.dart';

import '../../../../core.dart';

class InfoMovieItemWidget extends StatelessWidget {
  const InfoMovieItemWidget({
    super.key,
    required this.data,
  });

  final DetailMovieModel data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.amber,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'IMDB ${data.voteAverage}',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Icon(
                Icons.star_rate_rounded,
                color: Colors.amber,
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                '${data.voteAverage}/10',
                style: const TextStyle(color: Colors.amber),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              data.title,
              style:
                  const TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: data.genres.map((genre) {
                return Padding(
                  padding:
                      const EdgeInsets.only(top: 10, bottom: 10, right: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.grey.withOpacity(0.1)),
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Text(genre.name),
                        )),
                  ),
                );
              }).toList(),
            ),
          ),
          Text(data.overview),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
