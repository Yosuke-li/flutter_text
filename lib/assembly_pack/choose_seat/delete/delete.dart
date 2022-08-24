//废弃代码
//Widget _table() {
//     return Table(
//       columnWidths: <int, TableColumnWidth>{
//         for (int i = 0; i < _column; i++) i: const FlexColumnWidth(1),
//       },
//       children: <TableRow>[
//         for (int row = 0; row < _row; row += 1)
//           TableRow(
//             children: <Widget>[
//               for (int column = 0; column < _column; column += 1)
//                 Container(
//                   margin: EdgeInsets.all(2),
//                   height: 50,
//                   width: 100,
//                   alignment: Alignment.center,
//                   color: Colors.blueAccent,
//                   child: Text(
//                     '($row,$column)',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                 ),
//             ],
//           ),
//       ],
//     );
//   }