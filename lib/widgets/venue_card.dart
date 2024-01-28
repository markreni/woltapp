import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';

class VenueCard extends ConsumerWidget {
  final String name;
  final String description;
  final String imageURL;
  final String id;
  final int distance;
  final double rating;

  const VenueCard({
    required this.name,
    required this.description,
    required this.imageURL,
    required this.id,
    required this.distance,
    required this.rating,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteList = ref.watch(favoriteProvider);

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(8),
          ),
          height: 120,
          //margin: const EdgeInsets.all(8),
          //padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        alignment: FractionalOffset.center,
                        image: NetworkImage(
                          imageURL,
                        ),
                      )),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 7,
                        top: 23,
                      ),
                      child: Text(
                        name,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 16),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: SingleChildScrollView(
                          child: Text(
                            description,
                            textAlign: TextAlign.left,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 5,
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.place_outlined,
                            size: 15,
                          ),
                          Text(
                            "${distance}m",
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontWeight: FontWeight.w100, fontSize: 15),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          const Icon(
                            Icons.stars_outlined,
                            size: 15,
                          ),
                          Text(
                            "$rating/10",
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontWeight: FontWeight.w100, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: GestureDetector(
                  onTap: () => {
                    ref.watch(favoriteProvider.notifier).updateFavorite(id),
                  },
                  child: Container(
                    child: favoriteList.contains(id)
                        ? const Icon(
                            Icons.favorite,
                            size: 35,
                          )
                        : const Icon(
                            Icons.favorite_border,
                            size: 35,
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
        const Divider(
          thickness: 1,
          indent: 120,
          endIndent: 20,
          height: 0,
        )
      ],
    );
  }
}
