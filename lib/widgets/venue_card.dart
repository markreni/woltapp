import 'package:flutter/material.dart';

class VenueCard extends StatelessWidget {
  final String name;
  final String description;
  final String imageURL;

  const VenueCard({
    required this.name,
    required this.description,
    required this.imageURL,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(8),
          ),
          height: 115,
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
                      padding: const EdgeInsets.only(bottom: 7),
                      child: Text(
                        name,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 16),
                      ),
                    ),
                    Text(
                      description,
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Icon(
                  Icons.favorite,
                  size: 35,
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
