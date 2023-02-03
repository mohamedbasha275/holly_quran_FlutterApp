
import 'package:flutter/material.dart';
import 'package:holly_quran/features/home/data/models/book_model/book_model.dart';

class CustomBookImage extends StatelessWidget {
  final BookModel book;

  const CustomBookImage({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.6 / 4,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.black12,
        ),
        // child: ClipRRect(
        //   borderRadius: BorderRadius.circular(16),
        //   child: CachedNetworkImage(
        //     imageUrl: book.volumeInfo.imageLinks!.thumbnail,
        //     fit: BoxFit.fill,
        //     //progressIndicatorBuilder: (context, url, downloadProgress) => const CircularProgressIndicator(),
        //     errorWidget: (context, url, error) => const Icon(Icons.error),
        //   ),
        // ),
      ),
    );
  }
}
