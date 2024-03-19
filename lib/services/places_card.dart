// import 'package:favspot/views/beach_details_screen.dart';
// import 'package:flutter/material.dart';
//
// class PlacesCard extends StatelessWidget {
//   final Beaches _places;
//
//   const PlacesCard(this._places, {Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       contentPadding:
//           const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//       leading: Container(
//         padding: const EdgeInsets.only(right: 12.0),
//         decoration: const BoxDecoration(
//             border: Border(right: BorderSide(width: 1.0, color: Colors.blue))),
//         child: _status_icon(_places.status),
//       ),
//       title: Text(
//         _places.place,
//         style:
//             const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//       ),
//       // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
//       subtitle: Row(
//         children: <Widget>[
//           Text("City ${_places.city} | "),
//           Text(" ${_places.status}",
//               style: const TextStyle(color: Colors.black))
//         ],
//       ),
//       trailing: const Icon(Icons.keyboard_arrow_right,
//           color: Colors.white, size: 30.0),
//       onTap: () {
//         Navigator.of(context).push(MaterialPageRoute(
//             builder: (context) => BeachDetailScreen(
//                   beach: _places,
//                 )));
//       },
//     );
//   }
//
//   // ignore: non_constant_identifier_names
//   _status_icon(status) {
//     if (status == "Free") {
//       // ignore: prefer_const_constructors
//       return Icon(
//         Icons.location_on,
//         color: Colors.blue,
//       );
//     } else if (status == "Low") {
//       // ignore: prefer_const_constructors
//       return Icon(
//         Icons.location_on,
//         color: Colors.green,
//       );
//     } else if (status == "Moderate") {
//       // ignore: prefer_const_constructors
//       return Icon(
//         Icons.location_on,
//         color: Colors.yellow,
//       );
//     } else if (status == "Abundant") {
//       // ignore: prefer_const_constructors
//       return Icon(
//         Icons.location_on,
//         color: Colors.orange,
//       );
//     } else {
//       // ignore: prefer_const_constructors
//       return Icon(
//         Icons.location_on,
//         color: Colors.red,
//       );
//     }
//   }
// }
