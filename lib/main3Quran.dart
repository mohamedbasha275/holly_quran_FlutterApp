// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:quran/quran.dart' as quran;
//
// void main() {
//   runApp(const MaterialApp(home: QuranExample()));
// }
//
// class QuranExample extends StatefulWidget {
//   const QuranExample({super.key});
//
//   @override
//   State<QuranExample> createState() => _QuranExampleState();
// }
//
// class _QuranExampleState extends State<QuranExample> {
//   @override
//   Widget build(BuildContext context) {
//     print(quran.getAudioURLBySurah(1));
//     print(quran.getAudioURLByVerse(2,122));
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Quran Demo"),
//         ),
//         body: SingleChildScrollView(
//           child: Align(
//             alignment: Alignment.centerRight,
//             child: Padding(
//               padding: const EdgeInsets.all(5.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("\nSurah Name: \n${quran.getSurahNameArabic(96)}"),
//                   const Text("\nBasmala: \n${quran.basmala}"),
//                   const Text("\nBasmala: \n${quran.sajdah}"),
//                   const Text("\totalPagesCount: \n${quran.totalVerseCount}"),
//                   Text("\nTotal Verses: \n${quran.getVerseCount(96)}"),
//                   Text("\ngetVerseTranslation: ""\n${quran.getVerseTranslation(96,1)}"),
//                   Text("\getPageData: ""\n${quran.getPageData(96)}"),
//                   Text("\getSurahCountByPage: ""\n${quran.getSurahCountByPage(96)}"),
//                   Text("\getSurahCountByPage: ""\n${quran.getSurahPages(96)}"),
//                   Text("\getVersesTextByPage: """
//                       "\n${quran.getVersesTextByPage(1)}"),
//                   Text("\getVersesTextByPage: """
//                       "\n${quran.getAudioURLBySurah(1)}"),
//                   // Row(
//                   //   children: [
//                   //     for (int i = 1; i <= quran.getVerseCount(96); i++)
//                   //     Text(" ${quran.getVerse(96, i)} "
//                   //         "${quran.getVerseEndSymbol(i)} ",
//                   //     ),
//                   //   ],
//                   // ),
//                   RichText(
//                       text: TextSpan(children: [
//                         for (int i = 1; i <= quran.getVerseCount(96); i++)
//                           TextSpan(
//                             style: TextStyle(color: Colors.black,fontSize: 25),
//                             text:
//                             " ${quran.getVerse(96, i)} "
//                                 "${quran.getVerseEndSymbol(i)} ",
//                             // recognizer: TapGestureRecognizer()..onTap = (){
//                             //   print('i:$i');
//                             // },
//                           ),
//                       ])),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
