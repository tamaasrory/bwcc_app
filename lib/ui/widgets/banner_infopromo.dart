import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BannerInfoPromo extends StatelessWidget {
  const BannerInfoPromo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        // height: 150.0,
        aspectRatio: 2.45,
        viewportFraction: 0.85,
        autoPlay: true,
      ),
      items: [
        'assets/images/banner-1.jpg',
        'assets/images/banner-2.jpg',
        'assets/images/banner-3.jpg',
      ].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      offset: const Offset(0.0, 2.0),
                      blurRadius: 3,
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  child: Image.asset(
                    i,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
