import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holly_quran/features/home/data/models/book_model/book_model.dart';
import 'package:holly_quran/features/home/presentation/view_models/similar_books/similar_books_cubit.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/book_details_view_body.dart';

class BookDetailsView extends StatefulWidget {
  final BookModel book;
  const BookDetailsView({required this.book, Key? key}) : super(key: key);
  @override
  State<BookDetailsView> createState() => _BookDetailsViewState();
}

class _BookDetailsViewState extends State<BookDetailsView> {

  @override
  void initState() {
    BlocProvider.of<SimilarBooksCubit>(context).fetchSimilarBooks(category: widget.book.volumeInfo.categories![0]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea( // SafeArea to start after status bar
        child: BookDetailsViewBody(book: widget.book,),
      ),
    );
  }
}
