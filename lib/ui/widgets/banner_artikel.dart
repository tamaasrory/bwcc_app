import 'package:bwcc_app/bloc/beranda_bloc.dart';
import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/models/artikel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BannerArtikel extends StatefulWidget {
  final List<Artikel> items;
  const BannerArtikel({Key? key, required this.items}) : super(key: key);

  @override
  State<BannerArtikel> createState() => _BannerArtikelState();
}

class _BannerArtikelState extends State<BannerArtikel> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        // height: 150.0,
        aspectRatio: 3.5,
        viewportFraction: 1,
      ),
      items: widget.items.map((i) {
        return Builder(
          builder: (BuildContext context) {
            var mQuery = MediaQuery.of(context).size;
            var acratio = mQuery.aspectRatio;

            String deskripsi = '';
            String judul = '';
            if (i.deskripsi != null) {
              double strLength = (mQuery.width > 400 ? 100 : 150);
              var devWidth = mQuery.width * acratio;
              strLength = strLength > devWidth ? 1 : (devWidth - strLength);

              if (i.deskripsi!.length > strLength) {
                deskripsi = i.deskripsi!.substring(0, (strLength).toInt()) + '...';
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
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            judul,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            deskripsi,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black.withOpacity(0.7),
                            ),
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
                        Container(
                          width: 150 * acratio,
                          height: 150 * acratio,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                offset: const Offset(0.0, 2.0),
                                blurRadius: 5,
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: i.image != null
                                ? Image.network(
                                    Urls.getIcon(i.image!),
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/images/banner-1.jpg',
                                    fit: BoxFit.cover,
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
  }
}
