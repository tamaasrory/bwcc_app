import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/models/info.dart';
import 'package:bwcc_app/ui/pages/detail_info_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BannerInfoPromo extends StatefulWidget {
  final List<Info> items;
  const BannerInfoPromo({Key? key, required this.items}) : super(key: key);

  @override
  State<BannerInfoPromo> createState() => _BannerInfoPromoState();
}

class _BannerInfoPromoState extends State<BannerInfoPromo> {
  String itemsAlter = 'assets/images/banner-2.jpg';
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        // height: 150.0,
        aspectRatio: 2.45,
        viewportFraction: 0.85,
        autoPlay: true,
      ),
      items: widget.items.map((i) {
        logApp('RUNNN => ' + i.image.toString());
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailInfoPage(
                      id: i.id.toString(),
                    ),
                  ),
                );
              },
              child: Padding(
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
                    child: Image.network(
                      Urls.getIcon(i.image),
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                        itemsAlter,
                        fit: BoxFit.fill,
                      ),
                      fit: BoxFit.fill,
                    ),
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
