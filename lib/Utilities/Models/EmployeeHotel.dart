class EmployeeHotel {
  String hotelname;
  int hotelrefno;

  Map<String, dynamic> jsonMap;

  EmployeeHotel({this.hotelname, this.hotelrefno, this.jsonMap});

  factory EmployeeHotel.fromJson(Map<String, dynamic> json) {
    return EmployeeHotel(
        hotelname: json['hotelname'], hotelrefno: json['hotelrefno'], jsonMap: json);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'hotelname': hotelname, 'hotelrefno': hotelrefno};
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeHotel &&
          runtimeType == other.runtimeType &&
          hotelname == other.hotelname &&
          hotelrefno == other.hotelrefno &&
          jsonMap == other.jsonMap;

  @override
  int get hashCode => hotelname.hashCode ^ hotelrefno.hashCode ^ jsonMap.hashCode;

  @override
  String toString() {
    return 'EmployeeHotel{hotelname: $hotelname, hotelrefno: $hotelrefno, jsonMap: $jsonMap}';
  }
}
