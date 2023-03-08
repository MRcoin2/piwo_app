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
            brewery: 'Russian River Brewing Company',
            style: 'Double IPA',
            alcoholContent: 8.0,
            imageUrl: 'https://www.totalwine.com/dynamic/490x/media/sys_master/twmmedia/hd8/h68/8805931319326.png',
          ),
          BeerCard(
            name: 'Westvleteren 12',
            brewery: 'Sint-Sixtus Abbey',
            style: 'Quadrupel',
            alcoholContent: 10.2,
            imageUrl: 'https://example.com/westvleteren.jpg',
          ),
          // Add more BeerCard widgets here for other consumed beers
        ],
      ),
    );
  }
}
