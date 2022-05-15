import 'package:bwcc_app/bloc/beranda_bloc.dart';
import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/models/artikel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BannerArtikel extends StatelessWidget {
  const BannerArtikel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BerandaBloc, BerandaState>(
      builder: (context, state) {
        List<Artikel> items = [];
        if (state is SlideArtikelState) {
          items = state.data;
        } else {
          items = [
            Artikel(
              id: '',
              judul: '',
              slug: '',
              image: null,
              deskripsi: '',
              author: '',
              editor: '',
            )
          ];
        }

        return CarouselSlider(
          options: CarouselOptions(
            // height: 150.0,
            aspectRatio: 3.0,
            viewportFraction: 1,
          ),
          items: items.map((i) {
            return Builder(
              builder: (BuildContext context) {
                var mQuery = MediaQuery.of(context).size;
                var acratio = mQuery.aspectRatio;

                String deskripsi = '';
                String judul = '';
                if (i.deskripsi != null) {
                  if (i.deskripsi!.length > ((mQuery.width * acratio) - 50)) {
                    deskripsi = i.deskripsi!.substring(0, ((mQuery.width * acratio) - 50).toInt()) + '...';
                  } else {
                    deskripsi = i.deskripsi!;
                  }
                }
                if (i.judul != null) {
                  if (i.judul!.length > 50) {
                    judul = i.judul!.substring(0, 50) + '...';
                  } else {
                    judul = i.judul!;
                  }
                }
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 23.0),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.grey.withOpacity(0.5),
                    //     offset: const Offset(0.0, 2.0),
                    //     blurRadius: 3,
                    //     spreadRadius: 0,
                    //   )
                    // ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                judul,
                                style: const TextStyle(fontWeight: FontWeight.w500),
                              ),
                              // const SizedBox(height: 2),
                              // Row(
                              //   children: const [
                              //     Icon(
                              //       Icons.star,
                              //       color: Colors.amber,
                              //       size: 15,
                              //     ),
                              //     Text(
                              //       i['rating'] as String,
                              //       style: const TextStyle(color: Colors.grey, fontSize: 12),
                              //     ),
                              //   ],
                              // ),
                              const SizedBox(height: 3),
                              Text(
                                deskripsi,
                                style: const TextStyle(fontSize: 12),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                      ),
                      IntrinsicWidth(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: i.image != null
                                  ? Image.network(
                                      Urls.getIcon(i.image!),
                                      fit: BoxFit.cover,
                                      width: 190 * acratio,
                                      height: 190 * acratio,
                                    )
                                  : Image.asset(
                                      'assets/images/banner-1.jpg',
                                      fit: BoxFit.cover,
                                      width: 80,
                                      height: 80,
                                    ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(0, 0),
                                ),
                                child: Text(
                                  'View More'.toUpperCase(),
                                  style:
                                      TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 12),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}
