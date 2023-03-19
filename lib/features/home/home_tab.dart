import 'package:flutter/material.dart';

import '../beer_showcase/beer_card.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          BeerCard(
            name: 'Pliny the Elder',
            brand: 'Russian River Brewing Company',
            alcoholContent: 8.0,
            imageUrl: 'https://www.totalwine.com/dynamic/490x/media/sys_master/twmmedia/hd8/h68/8805931319326.png',
          ),
          BeerCard(
            name: 'Westvleteren 12',
            brand: 'Sint-Sixtus Abbey',
            alcoholContent: 10.2,
            imageUrl: 'https://example.com/westvleteren.jpg',
          ),
          // Add more BeerCard widgets here for other consumed beers
        ],
      ),
    );
  }
}
