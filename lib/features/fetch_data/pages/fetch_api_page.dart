import 'package:assignment_app/core/models/photo.dart';
import 'package:assignment_app/core/utils/snack_bar.dart';
import 'package:assignment_app/core/widgets/custom_app_bar.dart';
import 'package:assignment_app/core/widgets/custom_out_button.dart';
import 'package:assignment_app/features/fetch_data/bloc/photo_bloc.dart';
import 'package:assignment_app/features/fetch_data/widgets/photo_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

// Improvements -   1. add caching   2. Retrying for unfetched photos after few times
class FetchApiPage extends StatefulWidget {
  const FetchApiPage({super.key});

  @override
  State<FetchApiPage> createState() => _FetchApiPageState();
}

class _FetchApiPageState extends State<FetchApiPage> {
  List<Photo> photos = [];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhotoBloc, PhotoState>(
      listener: (context, state) {
        if (state is PhotoStateError) {
          EasyLoading.dismiss();
          showSnackBar(
              context, "Some photos failed to load. Please try again.");
          //showSnackBar(context, state.error);
        }
        if (state is PhotoStateSuccess) {
          //  print(state.photos);
          photos = state.photos;
          //  print(state.photos);
          EasyLoading.dismiss();
        }
      },
      builder: (context, state) {
        if (state is PhotoStateLoading) {
          EasyLoading.show(
            indicator: Center(child: const CircularProgressIndicator()),
            maskType: EasyLoadingMaskType.clear,
            dismissOnTap: true,
          );
        }
        return Scaffold(
          appBar: customAppbar(text: "Api Page"),
          body: photos.isEmpty
              ? Center(
                  child: CustomOutBtn(
                    onTap: () {
                      context.read<PhotoBloc>().add(PhotoFetch(
                          url: 'https://jsonplaceholder.typicode.com/photos'));
                    },
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 60,
                    color: Colors.white,
                    color2: Colors.blueAccent,
                    text: "Fetch Data",
                  ),
                )
              : PhotosList(photos: photos),
        );
      },
    );
  }
}
