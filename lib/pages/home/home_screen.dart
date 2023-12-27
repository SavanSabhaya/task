import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/api_service/mqtt_client.dart';
import 'package:task/common/constants/color_constants.dart';
import 'package:task/common/constants/font_constants.dart';
import 'package:task/pages/home/bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MyMqttClient mqttClientManager = MyMqttClient();
  Timer? timer;
  var macAddress = "";
  var isInsideCalled = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: Text(
                  'Home',
                  style: TextStyle(
                      fontSize: FontConstants.font_24,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.primaryColor),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Divider(
                      height: 1,
                      color: ColorConstants.primaryColor,
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFEDECF5),
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return detailCard();
                        },
                      ),
                    )
                  ],
                ),
              ));
        });
  }

  Widget detailCard() {
    return Container(
      // Wrap the Card in a Container with a fixed height
      height: 200, // Set a fixed height or adjust as needed
      child: Card(
        color: ColorConstants.secondaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('data'),
            Text('data'),
            Text('data'),
            Text('data'),
            Text('data'),
            Divider(
              height: 1,
              color: ColorConstants.primaryColor,
            ),
            SizedBox(height: 5),
            Expanded(
              child: Scrollbar(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(right: 5),
                      height: 100,
                      width: 100,
                      color: Colors.red,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
