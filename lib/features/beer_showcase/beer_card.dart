import 'package:flutter/material.dart';

// widget for displaying a recent beer
class BeerCard extends StatelessWidget {
  final String name;
  final String brand;
  final double alcoholContent;
  final String? imageUrl;

  const BeerCard({
    Key? key,
    required this.name,
    required this.brand,
    required this.alcoholContent,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (imageUrl != null)
            Flexible(
               child: FractionallySizedBox(
                widthFactor: 0.4,
                child: AspectRatio(
                  aspectRatio: 9 / 16,
                  child: Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(brand,
                          style: Theme.of(context).textTheme.bodySmall,),
                        const SizedBox(height: 4),
                        Text('${alcoholContent.toStringAsFixed(1)}% ABV',
                          style: Theme.of(context).textTheme.bodySmall,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}