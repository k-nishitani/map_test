import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:maplibre_gl/maplibre_gl.dart';

class HomePage extends HookConsumerWidget {
   HomePage({Key? key}) : super(key: key);
  
   MaplibreMapController? mapController;
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return  Scaffold(
      appBar: AppBar(title: const Text('Maplibre Demo')),
      //メニュー
      drawer: buildDrawer(context, ref),
      body: Stack(
        children: [
          //MapLibreで地図表示
          MaplibreMap(
            onMapCreated: _onMapCreated,
            onStyleLoadedCallback: _onStyleLoadedCallback,
            initialCameraPosition: const CameraPosition(
              // target: LatLng(34.7024, 135.4959),
              target:LatLng(43, -75),
              zoom: 11.0,
            ),
            styleString: "assets/osm_style.json",
          ),
        ],
      ),
    );
  }

 void _onMapCreated(MaplibreMapController controller) {
    mapController = controller;
  }

  void _onStyleLoadedCallback() async{
    debugPrint('onStyleLoadedCallback');
  }

  Drawer buildDrawer(BuildContext context,WidgetRef ref) {
    return Drawer(
      child: ListView(
        children:  <Widget>[
          const DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 14),
                Text(
                  'MapLibre Demo',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ListTile(
                title: Text("GeoJson読み込み"),
                onTap: ()async {
                  print("aaaa");
                  await mapController!.addSource(
        "earthquakes",
        const GeojsonSourceProperties(
            data:
                'https://docs.mapbox.com/mapbox-gl-js/assets/earthquakes.geojson',
            cluster: true,
            clusterMaxZoom: 14, // Max zoom to cluster points on
            clusterRadius:
                50 // Radius of each cluster when clustering points (defaults to 50)
            ));
    await mapController!.addLayer(
        "earthquakes",
        "earthquakes-circles",
        const CircleLayerProperties(circleColor: [
          Expressions.step,
          [Expressions.get, 'point_count'],
          '#51bbd6',
          100,
          '#f1f075',
          750,
          '#f28cb1'
        ], circleRadius: [
          Expressions.step,
          [Expressions.get, 'point_count'],
          20,
          100,
          30,
          750,
          40
        ]));
                  // addGeojsonCluster;
                
                  
                },
              ),
        ],
      ),
    );
  }

  Future<void> addGeojsonCluster() async {
    // await controller.addSource(
    //     "osaka",
    //     const GeojsonSourceProperties(
    //         data:
    //             "assets/osaka.geojson",
    //         cluster: true,
    //         clusterMaxZoom: 14, // Max zoom to cluster points on
    //         ));
    // await controller.addFillLayer(
    //   "osaka",
    //   "fills",
    //   const FillLayerProperties(fillColor: [
    //     Expressions.interpolate,
    //     ['exponential', 0.5],
    //     [Expressions.zoom],
    //     11,
    //     'red',
    //     18,
    //     'green'
    //   ], fillOpacity: 0.4),
      
    // );
    print("bbb");
    //  await mapController!.addSource(
    //     "earthquakes",
    //     const GeojsonSourceProperties(
    //         data:
    //             'https://docs.mapbox.com/mapbox-gl-js/assets/earthquakes.geojson',
    //         cluster: true,
    //         clusterMaxZoom: 14, // Max zoom to cluster points on
    //         clusterRadius:
    //             50 // Radius of each cluster when clustering points (defaults to 50)
    //         ));
    // await mapController!.addLayer(
    //     "earthquakes",
    //     "earthquakes-circles",
    //     const CircleLayerProperties(circleColor: [
    //       Expressions.step,
    //       [Expressions.get, 'point_count'],
    //       '#51bbd6',
    //       100,
    //       '#f1f075',
    //       750,
    //       '#f28cb1'
    //     ], circleRadius: [
    //       Expressions.step,
    //       [Expressions.get, 'point_count'],
    //       20,
    //       100,
    //       30,
    //       750,
    //       40
    //     ]));

  }

}
