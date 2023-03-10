import 'package:flutter/material.dart';

class BeerCard extends StatelessWidget {
  final String name;
  final String brewery;
  final String style;
  final double alcoholContent;
  final String? imageUrl;

  const BeerCard({
    Key? key,
    required this.name,
    required this.brewery,
    required this.style,
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
                        Text(brewery,
                          style: Theme.of(context).textTheme.bodySmall,),
                        const SizedBox(height: 4),
                        Text(style,
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