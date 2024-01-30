import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woltmobile2024/widgets/heart_button.dart';
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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(8),
          ),
          height: height * 0.17,
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
                          const Tooltip(
                            message: "Distance to the venue",
                            child: Icon(
                              Icons.place_outlined,
                              size: 15,
                            ),
                          ),
                          Tooltip(
                            message: "Distance to the venue",
                            child: Text(
                              "${distance}m",
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w200, fontSize: 15),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          const Tooltip(
                            message: "Venue rating",
                            child: Icon(
                              Icons.stars_outlined,
                              size: 15,
                            ),
                          ),
                          Tooltip(
                            message: "Venue rating",
                            child: Text(
                              "$rating/10",
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w200, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(width * 0.08, 0, 30, 0),
                child: Tooltip(
                  message: "Add to favorites",
                  child: Container(
                    child: favoriteList.contains(id)
                        ? HeartButton(
                            id: id,
                            liked: true,
                          )
                        : HeartButton(
                            id: id,
                            liked: false,
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
        ),
      ],
    );
  }
}
