import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';
import 'package:like_button/like_button.dart';

class HeartButton extends ConsumerStatefulWidget {
  final String id;
  final bool liked;
  const HeartButton({required this.id, required this.liked, super.key});

  @override
  ConsumerState<HeartButton> createState() => _HeartButtonState();
}

class _HeartButtonState extends ConsumerState<HeartButton> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    isLiked = widget.liked;

    return LikeButton(
      size: 35,
      isLiked: isLiked,
      likeBuilder: (isLiked) {
        if (isLiked) {
          return const Icon(
            Icons.favorite,
            size: 35,
            color: Color.fromARGB(255, 76, 178, 225),
          );
        } else {
          return const Icon(
            Icons.favorite_border,
            size: 35,
            color: Color.fromARGB(255, 76, 178, 225),
          );
        }
      },
      onTap: (isLiked) async {
        this.isLiked = !isLiked;
        await ref.watch(favoriteProvider.notifier).updateFavorite(widget.id);
        return !isLiked;
      },
    );
  }
}
