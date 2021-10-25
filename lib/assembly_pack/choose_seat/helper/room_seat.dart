import 'package:flutter_text/assembly_pack/choose_seat/helper/seat_model.dart';

class RoomSeatModel {
  int row;
  int column;
  List<SeatModel> seats;

  RoomSeatModel({this.column, this.row, this.seats});


}