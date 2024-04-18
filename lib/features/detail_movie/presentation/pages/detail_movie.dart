import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:movies/core.dart';

class DetailMovie extends StatelessWidget {
  const DetailMovie({super.key});

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as int;
    BlocProvider.of<DetailMovieBloc>(context).add(GetDataMovieById(id: id));

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: BlocBuilder<DetailMovieBloc, DetailMovieState>(
            builder: (context, state) {
              if (state is DetailMovieLoading) {
                return const CircularProgressIndicator();
              } else if (state is DetailMovieLoaded) {
                final data = state.listMovieDetail;
                DateTime releaseDate = data.releaseDate;
                return Card(
                  color: HexColor('#222222'),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  child: Image.network(
                                    dotenv.env['IMAGE_PATH'].toString() +
                                        data.posterPath,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 20,
                            left: 10,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.4),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: () =>
                                    Navigator.pop(context, RoutesName.home),
                                icon: const Icon(
                                  Icons.cancel,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
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
                                        style: const TextStyle(
                                            color: Colors.black),
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
                                style: const TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: data.genres.map((genre) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10, right: 10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              color:
                                                  Colors.grey.withOpacity(0.1)),
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
                            Text(
                              'Released: ${DateFormat('dd-MM-yyyy').format(releaseDate)}',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is DetailMovieError) {
                return Text(state.message);
              } else {
                return const Text('No Data!');
              }
            },
          ),
        ),
      ),
    );
  }
}
