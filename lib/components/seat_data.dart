import 'package:flutter/material.dart';
import 'package:movie_ticket_app/components/seat_component.dart';

class SeatData {
  bool isReserved;
  int id;
  bool isSelected;

  SeatData({
    required this.id,
    this.isSelected = false,
    this.isReserved = false,
  });
}

class Seats extends StatefulWidget {
  List<SeatData> seats;
  List<int> seatsIndex;
  Function reserveCallBack;
  Seats({
    Key? key,
    required this.seats,
    required this.seatsIndex,
    required this.reserveCallBack,
  }) : super(key: key);

  @override
  _SeatsState createState() => _SeatsState();
}

class _SeatsState extends State<Seats> {
  @override
  Widget build(BuildContext context) {
    int seatsNo = widget.seats.length;
    List<Widget> mySeats = [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 10,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return SeatComponent(
                  id: widget.seats[index].id,
                  isReserved: widget.seats[index].isReserved,
                  isSelected: widget.seats[index].isSelected,
                  reserve: widget.reserveCallBack,
                );
              },
            ),
          ),
          SizedBox(
            width: (MediaQuery.of(context).size.width / 20) * 2,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 10,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return SeatComponent(
                  id: widget.seats[index + 5].id,
                  isReserved: widget.seats[index + 5].isReserved,
                  isSelected: widget.seats[index + 5].isSelected,
                  reserve: widget.reserveCallBack,
                );
              },
            ),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 10,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return SeatComponent(
                  id: widget.seats[index + 10].id,
                  isReserved: widget.seats[index + 10].isReserved,
                  isSelected: widget.seats[index + 10].isSelected,
                  reserve: widget.reserveCallBack,
                );
              },
            ),
          ),
          SizedBox(
            width: (MediaQuery.of(context).size.width / 20) * 2,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 10,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return SeatComponent(
                  id: widget.seats[index + 15].id,
                  isReserved: widget.seats[index + 15].isReserved,
                  isSelected: widget.seats[index + 15].isSelected,
                  reserve: widget.reserveCallBack,
                );
              },
            ),
          ),
        ],
      ),
    ];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: mySeats,
      ),
    );
  }
}
