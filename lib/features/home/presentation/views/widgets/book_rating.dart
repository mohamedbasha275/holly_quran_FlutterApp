import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class BookRating extends StatelessWidget {
  final MainAxisAlignment mainAxisAlignment;
  final num rate;
  final int count;
  const BookRating({required this.rate,required this.count,super.key, this.mainAxisAlignment = MainAxisAlignment.start});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        const Icon(
          FontAwesomeIcons.solidStar,
          color: Color(0xffFFDD4F),
          size: 14,
        ),
        const SizedBox(width: 6.3),
        Text(
          '$rate',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(width: 5),
        Opacity(
          opacity: 0.55,
          child: Text(
            '($count)',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}
