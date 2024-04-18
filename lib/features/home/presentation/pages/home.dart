import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                        items: [
                          // List of your carousel items here
                          Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://via.placeholder.com/600x200'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: const Center(
                              child: Text('Slide 1'),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://via.placeholder.com/600x200'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: const Center(
                              child: Text('Slide 2'),
                            ),
                          ),
                          // Add more carousel items as needed
                        ],
                        options: CarouselOptions(
                          height: 200,
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
