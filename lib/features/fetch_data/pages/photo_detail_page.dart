import 'package:assignment_app/core/models/photo.dart';
import 'package:assignment_app/core/utils/snack_bar.dart';
import 'package:assignment_app/core/widgets/custom_app_bar.dart';
import 'package:assignment_app/features/fetch_data/bloc/photo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class PhotoDetailPage extends StatefulWidget {
  const PhotoDetailPage({super.key});

  @override
  State<PhotoDetailPage> createState() => _PhotoDetailPageState();
}

class _PhotoDetailPageState extends State<PhotoDetailPage> {
  Map<dynamic, dynamic>? args;
  Photo? photo;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = ModalRoute.of(context)!.settings.arguments as Map;
    _fetchSinglePhot(args?["id"], context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhotoBloc, PhotoState>(
      listener: (context, state) {
        if (state is SinglePhotoStateError) {
          EasyLoading.dismiss();
          showSnackBar(context, "Unable to load. Please try again.");
        }
        if (state is SinglePhotoSuccessState) {
          EasyLoading.dismiss();
          photo = state.photos[0];
        }
      },
      builder: (context, state) {
        if (state is SinglePhotoLoadingState) {
          EasyLoading.instance
            ..backgroundColor =
                Colors.transparent // Set the background to transparent
            ..indicatorColor =
                Colors.blue // Customize indicator color if needed
            ..maskColor = Colors.black
                .withValues(alpha: 0.5); // Optional: Dim the background
          EasyLoading.show(
            indicator: Center(
                child: const CircularProgressIndicator(
              //backgroundColor: Colors.red,
              color: Colors.blue,
              strokeWidth: 4,
            )),
            maskType: EasyLoadingMaskType.clear,
            dismissOnTap: true,
          );
        }
        return photo == null
            ? const Center(child: CircularProgressIndicator())
            : Scaffold(
                //TODO - apply DRY
                appBar: customAppbar(text: "Photo Detail"),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12)),
                      child: Image.network(
                          photo?.thumbnailUrl ??
                              'https://via.placeholder.com/150',
                          errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.broken_image,
                            size: 50, color: Colors.grey);
                      }),
                    ),
                    Center(
                      child: Text(
                        "Photo Id - ${photo!.id.toString()}",
                      ),
                    ),
                    Center(
                      child: Text(
                        "Photo Title\n - ${photo!.title}",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}

_fetchSinglePhot(int id, BuildContext context) {
  if (context.mounted) {
    context.read<PhotoBloc>().add(SinglePhotoFetch(
        url: 'https://jsonplaceholder.typicode.com/photos?id=$id'));
  }
}
