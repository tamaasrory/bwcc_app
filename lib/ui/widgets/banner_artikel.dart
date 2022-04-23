import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BannerArtikel extends StatelessWidget {
  const BannerArtikel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        // height: 150.0,
        aspectRatio: 3.0,
        viewportFraction: 1,
      ),
      items: [
        {
          'judul': '5 Potensi Manfaat Borage oil untuk Kesehatan',
          'rating': '5.0 (2)',
          'description':
              'Borage oil adalah minyak yang diekstrak dari bunga borage (Borago officinalis). Minyak ini dipercaya memiliki sejumlah manfaat untuk kesehatan, mulai dari meredakan artritis reumatoid, eksim, hingga mendukung pertumbuhan bayi prematur.',
          'image': 'assets/images/artikel1.png',
        }
      ].map((i) {
        return Builder(
          builder: (BuildContext context) {
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
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            i['judul'] as String,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 15,
                              ),
                              Text(
                                i['rating'] as String,
                                style: const TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            (i['description'] as String).substring(0, 90) + '...',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: IntrinsicWidth(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              i['image'] as String,
                              fit: BoxFit.cover,
                              width: 80,
                              height: 80,
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(0, 0),
                              ),
                              child: Text(
                                'View More',
                                style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 12),
                              ),
                            ),
                          )
                        ],
                      ),
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
