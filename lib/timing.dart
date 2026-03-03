class Timing{

  final String time;
  final String bus;



  const Timing({
    required this.time,
    required this.bus,
  });


  static Timing fromJson(json) => Timing(time: json['Time'], bus: json['Vno']);

}

class DropDownValueNew{
  final String dropdownvaluenew;

  DropDownValueNew(this.dropdownvaluenew);
}

