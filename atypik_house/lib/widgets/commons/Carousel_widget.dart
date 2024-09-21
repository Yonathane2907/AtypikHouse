import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

class CarouselWidget extends StatelessWidget implements PreferredSizeWidget {
  const CarouselWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List <Widget> carouselItems = [
      Image.network( 'lib/images/accueil1.jpg',fit: BoxFit.cover, width: double.infinity ),
      Image.network( 'lib/images/accueil2.jpg',fit: BoxFit.cover, width: double.infinity ),
      Image.network( 'lib/images/accueil3.jpg',fit: BoxFit.cover, width: double.infinity ),
    ];

        if (ResponsiveBreakpoints.of(context).largerThan(TABLET)) {
          return(

    CarouselSlider(
      options: CarouselOptions(
          height: 1000,
          aspectRatio: 16/9,
          viewportFraction: 1.0,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal
      ),
      items: carouselItems

        )

    );
  }
    else {
      return(
          CarouselSlider(
              options: CarouselOptions(
                  height: size.height * 0.5,
                  aspectRatio: 16/9,
                  viewportFraction: 1.0,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal
              ),
              items: carouselItems

          )

      );
    }
  }

  // Permet de définir la hauteur de la barre de navigation
  @override
  Size get preferredSize => const Size.fromHeight(55);
}