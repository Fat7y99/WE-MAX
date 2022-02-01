// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:movie_ticket_app/API/request_response.dart';
import 'package:movie_ticket_app/Provider/provider.dart';
import 'package:movie_ticket_app/screens/home_screen.dart';
import 'package:movie_ticket_app/screens/movie_details.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../Models/movie_model.dart';
import 'package:movie_ticket_app/Provider/provider.dart';

import '../const.dart';

class MovieEditPage extends StatefulWidget {
  final int id;

  const MovieEditPage({required this.id});
  @override
  _MovieEditPageState createState() => _MovieEditPageState();
}

class _MovieEditPageState extends State<MovieEditPage> {
  final int id = Provider.movies[Provider.currentMovieId!].id;
  TextEditingController titleController = TextEditingController(
      text: Provider.movies[Provider.currentMovieId!].title);
  TextEditingController imageController = TextEditingController(
      text: Provider.movies[Provider.currentMovieId!].imageURL);
  TextEditingController startController = TextEditingController(
      text: DateFormat("yyyy-MM-dd HH:mm:ss").format(
          Provider.movies[Provider.currentMovieId!].startTime)); //TODO DATETIME
  TextEditingController endController = TextEditingController(
      text: DateFormat("yyyy-MM-dd HH:mm:ss")
          .format(Provider.movies[Provider.currentMovieId!].endTime));
  TextEditingController screenController = TextEditingController(
      text: Provider.movies[Provider.currentMovieId!].screenRoom.toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff302b35),
      appBar: AppBar(),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // TextFormField(initialValue: "I am smart"),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      // initialValue: title,
                      controller: titleController,
                      decoration: InputDecoration(
                          hintText: 'Movie Title',
                          hintStyle: TextStyle(
                            color: Colors.white70,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          prefixIcon:
                              Icon(Icons.movie, color: Color(0xFF94ADEA)),
                          // hintText: 'Email',
                          // hintStyle: TextStyle(
                          //   color: Colors.white70,
                          // ),
                          filled: true,
                          fillColor: Color(0xD000000)),
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.visiblePassword,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      // initialValue: imageURL,
                      controller: imageController,
                      decoration: InputDecoration(
                          hintText: 'Image URL',
                          hintStyle: TextStyle(
                            color: Colors.white70,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          prefixIcon:
                              Icon(Icons.image, color: Color(0xFF94ADEA)),
                          // hintText: 'Email',
                          // hintStyle: TextStyle(
                          //   color: Colors.white70,
                          // ),
                          filled: true,
                          fillColor: Color(0xD000000)),
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.visiblePassword,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          // initialValue: startTime,
                          controller: startController,
                          decoration: InputDecoration(
                              hintText: 'Start Time',
                              hintStyle: TextStyle(
                                color: Colors.white70,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              prefixIcon: Icon(Icons.timelapse,
                                  color: Color(0xFF94ADEA)),
                              // hintText: 'Email',
                              // hintStyle: TextStyle(
                              //   color: Colors.white70,
                              // ),
                              filled: true,
                              fillColor: Color(0xD000000)),
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.visiblePassword,
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            DatePicker.showDateTimePicker(context,
                                showTitleActions: true,
                                minTime: DateTime.now(),
                                maxTime: DateTime(2023, 6, 7),
                                onChanged: (date) {
                              startController.text =
                                  DateFormat("yyyy-MM-dd HH:mm:ss")
                                      .format(date)
                                      .toString();

                              print('change $date');
                            }, onConfirm: (date) {
                              print('confirm $date');
                              setState(() {
                                // startController.text =
                                //     DateFormat("yyyy-MM-dd HH:mm:ss")
                                //         .format(date)
                                //         .toString();

                                print(startController.value);
                              });
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                          },
                          child: RichText(
                            text: TextSpan(
                              children: const [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.date_range,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          // initialValue: endTime,
                          controller: endController,
                          decoration: InputDecoration(
                              hintText: 'End Time',
                              hintStyle: TextStyle(
                                color: Colors.white70,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              prefixIcon: Icon(Icons.timelapse,
                                  color: Color(0xFF94ADEA)),
                              // hintText: 'Email',
                              // hintStyle: TextStyle(
                              //   color: Colors.white70,
                              // ),
                              filled: true,
                              fillColor: Color(0xD000000)),
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.visiblePassword,
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            DatePicker.showDateTimePicker(context,
                                showTitleActions: true,
                                minTime: DateTime.now(),
                                maxTime: DateTime(2023, 6, 7),
                                onChanged: (date) {
                              endController.text =
                                  DateFormat("yyyy-MM-dd HH:mm:ss")
                                      .format(date)
                                      .toString();

                              print('change $date');
                            }, onConfirm: (date) {
                              print('confirm $date');
                              setState(() {
                                // startController.text =
                                //     DateFormat("yyyy-MM-dd HH:mm:ss")
                                //         .format(date)
                                //         .toString();

                                print(startController.value);
                              });
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                          },
                          child: RichText(
                            text: TextSpan(
                              children: const [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.date_range,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      // initialValue: screenRoom,
                      controller: screenController,
                      decoration: InputDecoration(
                          hintText: 'Screen Room',
                          hintStyle: TextStyle(
                            color: Colors.white70,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          prefixIcon:
                              Icon(Icons.monitor, color: Color(0xFF94ADEA)),
                          // hintText: 'Email',
                          // hintStyle: TextStyle(
                          //   color: Colors.white70,
                          // ),
                          filled: true,
                          fillColor: Color(0xD000000)),
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.visiblePassword,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xff252129))),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.arrow_circle_down,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: ' Submit ',
                              style: GoogleFonts.bioRhyme(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      // fontWeight: FontWeight.w500,
                                      fontSize: 20)),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () async {
                        MovieModel movie = MovieModel(
                            id: id,
                            title: titleController.text,
                            startTime: DateTime.parse(startController.text),
                            endTime: DateTime.parse(endController.text),
                            screenRoom: int.parse(screenController.text),
                            imageURL: imageController.text);
                        int statusCode =
                            await RequestAndResponses.editMovie(movie);
                        if (statusCode == 200) {
                          Alert(
                            context: context,
                            title: "Movie is updated successfully",
                            // desc: "Flutter is better with RFlutter Alert.",
                            image: Image.asset(
                              "assets/images/success.png",
                              scale: 10,
                            ),

                            buttons: [
                              DialogButton(
                                child: Text(
                                  "Ok",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () => Navigator.pop(context),
                                color: kBackgroundColor,
                                radius: BorderRadius.circular(0.0),
                              ),
                            ],
                          ).show();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyHomePage(isUser: 1),
                              //should take movies[widget.index].id
                            ),
                          );
                          Provider.movies =
                              await RequestAndResponses.getAllMovies();
                          print("updatedSuccessfully");
                          // Navigator.pop(context);

                        }

                        // await FlickrRequestsAndResponses.logIn(
                        //     titleController,
                        //     dateController,
                        //     startController,
                        //     endController,
                        //     screenController,
                        //     imageController);
                        // Navigator.push();
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
