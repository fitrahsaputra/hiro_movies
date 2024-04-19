import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../core.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Hiro Movies"),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<HomeBloc>(context).add(GetData());
          },
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is DataLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is DataLoaded) {
                return ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 20),
                          child: const Text(
                            'UPCOMING',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: CarouselSlider(
                            items: state.movieUpcomingList
                                .map((dataMovieUpcoming) {
                              return Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        '${dotenv.env['IMAGE_PATH']}${dataMovieUpcoming.posterPath}'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }).toList(),
                            options: CarouselOptions(
                              height: 400,
                              enableInfiniteScroll: true,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              pauseAutoPlayOnTouch: true,
                              aspectRatio: 16 / 9,
                              viewportFraction: 0.8,
                            ),
                          ),
                        ),
                        Card(
                          color: HexColor('#222222'),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 20, left: 20),
                                child: Text(
                                  'NOW PLAYING',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Divider(
                                thickness: 3,
                                color: HexColor('#312F40'),
                              ),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.all(15),
                                itemCount: state.movieList.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 15,
                                  crossAxisSpacing: 15,
                                  childAspectRatio: 0.5,
                                ),
                                itemBuilder: (context, index) {
                                  final data = state.movieList[index];
                                  return MovieItemsWidget(data: data);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                );
              } else if (state is DataError) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return const Center(
                  child: Text('No Data!'),
                );
              }
            },
          ),
        ));
  }
}
