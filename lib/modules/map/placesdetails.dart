import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_launcher/map_launcher.dart';

import '../../widgets/components.dart';
import 'destinationstosearch.dart';

class PlacesDetails extends StatefulWidget {
  late List<Destination> destinationlist;
  PlacesDetails({required this.destinationlist, Key? key}) : super(key: key);

  @override
  _PlacesDetailsState createState() => _PlacesDetailsState();
}

class _PlacesDetailsState extends State<PlacesDetails> {
  late Position _currentPosition;
  late List<Destination> destinationlist;
  int currentindex = 0;

  @override
  void initState() {
    destinationlist = widget.destinationlist;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              child: destinationlist.isNotEmpty
                  ? PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    decoration:
                                        destinationlist[index].decoration,
                                    height: 250,
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Expanded(
                                                child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      height: 40,
                                                      width: 40,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            ButtonAndIconsColor(),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Container(
                                                        height: 40,
                                                        width: 40,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              ButtonAndIconsColor(),
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: IconButton(
                                                          icon: const Icon(
                                                            Icons.arrow_back,
                                                            color: Colors.black,
                                                          ),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    IconButton(
                                                        onPressed: () {},
                                                        icon: const Icon(
                                                          Icons.favorite_border,
                                                          color: Colors.white,
                                                          size: 35,
                                                        )),
                                                  ],
                                                )
                                              ],
                                            )),
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                color: ButtonAndIconsColor(),
                                                size: 30.0,
                                              ),
                                              Container(
                                                width: 70,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[300]
                                                      ?.withOpacity(1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                child: Text(
                                                  destinationlist[index]
                                                      .distanceText
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20.0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      destinationlist[index].name,
                                      style: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                      ),
                                      child: Text(
                                        destinationlist[index].description,
                                        style: const TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),

                                    ///phone number
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.access_time,
                                            size: 30,
                                            color: ButtonAndIconsColor()),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "opens at ${destinationlist[index]
                                                  .timeopens} am",
                                          style: const TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "closes at ${destinationlist[index]
                                                  .timecloses} pm",
                                          style: const TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.directions_car_outlined,
                                            size: 30,
                                            color: ButtonAndIconsColor()),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          destinationlist[index]
                                              .distanceText
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.directions,
                                            size: 30,
                                            color: ButtonAndIconsColor()),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        MaterialButton(
                                          onPressed: () {
                                            _launchURL(index);
                                          },
                                          color: ButtonAndIconsColor(),
                                          child: const Text(
                                            'Get Direction',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      'Photos : ',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: 200,
                                height: 200,
                                child: destinationlist[index].InkWell,
                              ),
                              Center(
                                child: Positioned(
                                    child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: ButtonAndIconsColor(),
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.arrow_forward,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {},
                                  ),
                                )),
                              ),
                            ],
                          ),
                        );
                      })
                  : Center(
                      child: CircularProgressIndicator(
                        backgroundColor: ButtonAndIconsColor(),
                        color: Colors.white,
                      ),
                    )),
        ],
      ),
    );
  }

  void openAswanGallery() {
    navigateto(
        context,
        GalleryWidget(
          urlImages: AswanUrlImages,
          index: 0,
        ));
  }

  Future<void> _launchURL(index) async {
    final availableMaps = await MapLauncher.installedMaps;
    print(availableMaps);
    if (availableMaps.isNotEmpty) {
      await availableMaps.first.showMarker(
        coords: Coords(destinationlist[index].lat, destinationlist[index].lng),
        title: destinationlist[index].name,
      );
    } else {
      throw 'No available maps';
    }
  }
}
