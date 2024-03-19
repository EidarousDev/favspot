import 'dart:async';

import 'package:favspot/core/extensions/mediaquery_extension.dart';
import 'package:favspot/core/extensions/navigation_extension.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../core/config/app_colors.dart';
import '../../core/config/app_routes.dart';
import '../../core/config/firestore_config.dart';
import '../../core/config/maps_config.dart';
import '../../core/config/navigation_keys.dart';
import '../../providers/maps_provider.dart';
import '../widgets/spaces.dart';
import 'widgets/home_bottom_bar.dart';
import 'widgets/home_drawer.dart';
import 'widgets/search_widget.dart';
import 'widgets/sidebar_filter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Completer<GoogleMapController> _controller =
        Completer<GoogleMapController>();
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: context.appHeight,
            width: context.appWidth,
            child: Consumer<MapsProvider>(builder: (context, maps, child) {
              if (child != null) {
                return child;
              }
              return GoogleMap(
                markers: maps.markers,
                mapType: MapType.normal,
                initialCameraPosition: MapsConfig.initCameraPosition,
                padding: const EdgeInsets.only(top: 50),
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
                myLocationEnabled: false,
                myLocationButtonEnabled: false,
                onMapCreated: (GoogleMapController controller) {
                  if (maps.controller != null) {
                    return;
                  }
                  controller.setMapStyle(MapsConfig.style);
                  _controller.complete(controller);
                  Future.delayed(Duration(milliseconds: 900), () {
                    maps.getBeaches(onTap: (beach) {
                      context.push(AppRoutes.beachDetails, args: {
                        NavigationKeys.beachEntity: beach,
                      });
                    });
                    maps.setMapsController(controller);
                  });
                },
              );
            }),
          ),
          Positioned(
            top: 30,
            left: 10,
            right: 20,
            child: Builder(
              // Builder is important here to use the context of the Scaffold Widget
              builder: (context) => Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: InkWell(
                          onTap: () => Scaffold.of(context).openDrawer(),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.iconsBackground,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Icon(Icons.menu)),
                        ),
                      ),
                      SearchWidget(),
                    ],
                  ),
                  if (context
                      .watch<MapsProvider>()
                      .searchedBeaches
                      .isNotEmpty) ...[
                    Container(
                      width: context.appWidth * 0.7,
                      height: context.appHeight * 0.5,
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: context
                                .read<MapsProvider>()
                                .searchedBeaches
                                .length,
                            itemBuilder: (context, index) {
                              final beach = context
                                  .watch<MapsProvider>()
                                  .searchedBeaches[index];
                              return Container(
                                color: Colors.white.withOpacity(0.8),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () => context
                                        .push(AppRoutes.beachDetails, args: {
                                      NavigationKeys.beachEntity: beach
                                    }),
                                    child: Row(
                                      children: [
                                        kBeachesStatuses
                                            .firstWhere((element) =>
                                                element.status == beach.status)
                                            .icon,
                                        HorizontalSpace(8.0),
                                        Text(beach.place),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    )
                  ]
                ],
              ),
            ),
          ),
          Positioned(
            right: 8,
            top: context.appHeight * 0.3,
            child: SideBarFilter(),
          ),
          Positioned(
            bottom: 16,
            left: 15,
            right: 15,
            child: HomeBottomBar(),
          ),
        ],
      ),
      drawer: HomeDrawer(),
    );
  }
}
