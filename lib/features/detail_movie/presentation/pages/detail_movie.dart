import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hexcolor/hexcolor.dart';
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
                                  child: Hero(
                                    tag: id,
                                    child: Image.network(
                                      dotenv.env['IMAGE_PATH'].toString() +
                                          data.posterPath,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const CancelButtonWidget(),
                        ],
                      ),
                      InfoMovieItemWidget(data: data),
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
