import 'package:flutter/material.dart';
import 'package:holly_quran/features/home/data/models/book_model/book_model.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/book_action.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/book_rating.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/custom_book_details_appbar.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/custom_book_image.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/similar_books_listview.dart';

class BookDetailsViewBody extends StatelessWidget {
  final BookModel book;

  const BookDetailsViewBody({required this.book, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              children: [
                const CustomBookDetailsAppBar(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.2),
                  child: CustomBookImage(book: book),
                ),
                const SizedBox(height: 43),
                Text(
                  book.volumeInfo.title!,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Opacity(
                  opacity: 0.7,
                  child: Text(book.volumeInfo.authors!.first,
                    style: Theme.of(context).textTheme.titleMedium,),
                ),
                const SizedBox(height: 16),
                BookRating(
                    mainAxisAlignment: MainAxisAlignment.center,
                    count: book.volumeInfo.ratingsCount ?? 0,
                    rate: book.volumeInfo.averageRating ?? 0),
                const SizedBox(height: 30),
                const BookAction(),
                const Expanded(child: SizedBox(height: 30)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'You Can Also Like',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 10),
                const SimilarBooksListView(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
