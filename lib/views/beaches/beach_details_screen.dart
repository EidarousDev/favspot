import 'package:favspot/core/extensions/mediaquery_extension.dart';
import 'package:flutter/material.dart';

import '../../core/config/firestore_config.dart';
import '../../domain/entities/beach_entity.dart';
import '../widgets/custom_appbar.dart';

class BeachDetailsScreen extends StatelessWidget {
  final BeachEntity beach;
  const BeachDetailsScreen({Key? key, required this.beach}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: '${beach.place}',
      child: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Image.network(
              beach.imageUrl,
              fit: BoxFit.cover,
              height: 450,
              width: 450,
            ),
            Container(
              margin: EdgeInsets.only(top: context.appHeight * 0.45),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(50)),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      child: Container(
                        width: 150,
                        height: 7,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        kBeachesStatuses
                            .firstWhere(
                                (element) => element.status == beach.status)
                            .icon,
                        const SizedBox(
                          width: 30,
                        ),
                        Text(
                          beach.place,
                          style: const TextStyle(fontSize: 30, height: 1.5),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        const Text(
                          "4.5",
                          style: TextStyle(fontSize: 25, height: 1.5),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: const DecorationImage(
                                  image: AssetImage("imagens/star.png"),
                                  fit: BoxFit.cover)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              //borderRadius: BorderRadius.circular(10),
                              image: const DecorationImage(
                                  image: AssetImage("imagens/beach.png"),
                                  fit: BoxFit.cover)),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              //borderRadius: BorderRadius.circular(10),
                              image: const DecorationImage(
                                  image: AssetImage("imagens/swim.png"),
                                  fit: BoxFit.cover)),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              //borderRadius: BorderRadius.circular(10),
                              image: const DecorationImage(
                                  image: AssetImage("imagens/restaurant.png"),
                                  fit: BoxFit.cover)),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              //borderRadius: BorderRadius.circular(10),
                              image: const DecorationImage(
                                  image: AssetImage("imagens/hotel.png"),
                                  fit: BoxFit.cover)),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                    Text(beach.description,
                        style: const TextStyle(height: 1.6)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
