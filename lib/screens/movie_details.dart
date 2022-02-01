// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_ticket_app/API/request_response.dart';
import 'package:movie_ticket_app/components/seat_component.dart';
import 'package:movie_ticket_app/components/movie_app_bar.dart';
import 'package:movie_ticket_app/const.dart';
import 'package:movie_ticket_app/screens/buy_ticket.dart';
import 'package:movie_ticket_app/screens/buy_ticket_2.dart';
import 'package:movie_ticket_app/Models/movie_model.dart';
import 'package:movie_ticket_app/screens/movie_edit.dart';
import 'package:movie_ticket_app/Provider/provider.dart';

class MovieDetails extends StatefulWidget {
  final int id;
  int isUser;

  MovieDetails({required this.id, required this.isUser});

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  Widget build(BuildContext context) {
    final String imageURL = Provider.movies[widget.id].imageURL;
    final int id = Provider.movies[widget.id].id;
    final String title = Provider.movies[widget.id].title;
    final DateTime startTime = Provider.movies[widget.id].startTime;
    final DateTime endTime = Provider.movies[widget.id].endTime;
    final String year = Provider.movies[widget.id].startTime.year.toString();
    final String screenRoom = Provider.movies[widget.id].screenRoom.toString();

    final Color background = Color(0xff302b35);
    final Color fill = Color(0xff252129);
    final List<Color> gradient = [
      background,
      background,
      fill,
      fill,
    ];
    final double fillPercent = 30; // fills 56.23% for container from bottom
    final double fillStop = (100 - fillPercent) / 100;
    final List<double> stops = [0.0, fillStop, fillStop, 1.0];
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    final String descip =
        'With Spider-Man\'s identity now revealed, Peter asks Doctor Strange for help. When a spell goes wrong, dangerous foes from other worlds start to appear, forcing Peter to discover what it truly means to be Spider-Man.';

    return Scaffold(
      appBar: AppBar(actions: [
        Visibility(
          visible: Provider.currentUser!.role == 'manager',
          child: IconButton(
              onPressed: () {
                setState(() {
                  Provider.currentMovieId = widget.id;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieEditPage(
                      id: widget.id,
                    ), //should take movies[widget.index].id
                  ),
                );
              },
              icon: Icon(
                Icons.edit,
                color: kPimaryColor,
              )),
        ),
      ]),
      body: Container(
        color: fill,
        height: deviceHeight,
        child: SingleChildScrollView(
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //     colors: gradient,
          //     stops: stops,
          //     end: Alignment.bottomCenter,
          //     begin: Alignment.topCenter,
          //   ),
          // ),
          child: Center(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  color: background,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 40.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 10),
                        height: deviceHeight / 2,
                        width: deviceWidth / 2,
                        child: Image.network(imageURL,
                            // scale: 2,
                            fit: BoxFit.fill),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: fill,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Release year: ',
                        style: TextStyle(
                          fontSize: 40.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        year,
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: 100.0,
                              child: Text(
                                "",
                                style: TextStyle(
                                  fontFamily: 'Arial',
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                                child: Text(
                                  "Start Time:  '${startTime.hour}:${startTime.minute} ",
                                  style: TextStyle(
                                    fontFamily: 'Arial',
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                  // textAlign: TextAlign.left,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                                child: Text(
                                  "End Time: ${endTime.hour}:${endTime.minute}",
                                  style: TextStyle(
                                    fontFamily: 'Arial',
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                  // textAlign: TextAlign.left,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                                child: Text(
                                  "Screen Room: #$screenRoom",
                                  style: TextStyle(
                                    fontFamily: 'Arial',
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                  // textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Visibility(
                                visible:
                                    Provider.currentUser!.role == 'manager' ||
                                        Provider.currentUser!.role == 'user' ||
                                        Provider.currentUser!.role == 'guest',
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 4,
                                  height: 50,
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: ElevatedButton(
                                    // style: ElevatedButton.styleFrom(
                                    //   primary: Colors.transparent, // background
                                    // ),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Color(0xFFD3A13B))),
                                    child: RichText(
                                      text: TextSpan(
                                        //   style: Theme.of(context).textTheme.body1,
                                        children: [
                                          WidgetSpan(
                                            child: Icon(
                                              Icons.airplane_ticket,
                                              size: 25,
                                              color: Colors.white,
                                            ),
                                          ),
                                          TextSpan(
                                            text: Provider.currentUser!.role ==
                                                        'manager' ||
                                                    Provider.currentUser!
                                                            .role ==
                                                        'guest'
                                                ? 'View Reserved'
                                                : ' Buy Ticket ',
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
                                      Provider.seats = await RequestAndResponses
                                          .getAllReservedSeats(id);
                                      for (var i = 0; i < seats.length; i++) {
                                        if (Provider.seats
                                            .contains(seats[i].id)) {
                                          seats[i].isReserved = true;
                                        } else {
                                          seats[i].isReserved = false;
                                          seats[i].isSelected = false;
                                        }
                                      }

                                      for (var i = 0; i < seats2.length; i++) {
                                        if (Provider.seats
                                            .contains(seats2[i].id)) {
                                          seats2[i].isReserved = true;
                                        } else {
                                          seats2[i].isReserved = false;
                                          seats2[i].isSelected = false;
                                        }
                                      }

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              int.parse(screenRoom) == 1
                                                  ? BuyTicket(widget.id)
                                                  : BuyTicket2(widget.id),
                                          //should take movies[widget.index].id
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
