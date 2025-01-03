import 'package:assignment_app/core/models/photo.dart';
import 'package:assignment_app/core/routes/names.dart';
import 'package:flutter/material.dart';

class PhotosList extends StatelessWidget {
  const PhotosList({super.key, required this.photos});

  final List<Photo>? photos;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: photos!.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.PRODUCT_DETAIL_PAGE,
                arguments: <String, dynamic>{
                  "id": photos?[index].id,
                  "thubnailUrl": photos?[index].thumbnailUrl,
                  "title": photos?[index].title,
                });
          },
          child: Image.network(
            photos?[index].thumbnailUrl ?? 'https://via.placeholder.com/150',
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.broken_image,
                  size: 50, color: Colors.grey);
            },
          ),
        );
      },
    );
  }
}
