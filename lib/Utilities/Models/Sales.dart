class Sales {
  int cxbn; //customer experience bed night (cx = number of times customer asked for help)
  int cxday;
  int cxpax; //pax = guest
  int cxrev;
  int cxrn; //room night
  int cxroom;
  int salesbn;
  int salesday;
  int salespax;
  double salesrev; //revenue from sales
  int salesrn;
  int salesroom;

  Sales({
    this.cxbn,
    this.cxday,
    this.cxpax,
    this.cxrev,
    this.cxrn,
    this.cxroom,
    this.salesbn,
    this.salesday,
    this.salespax,
    this.salesrev,
    this.salesrn,
    this.salesroom,
  });

  factory Sales.fromJson(Map<String, dynamic> json) => Sales(
        cxbn: json['cxbn'],
        cxday: json['cxday'],
        cxpax: json['cxpax'],
        cxrev: json['cxrev'],
        cxrn: json['cxrn'],
        cxroom: json['cxroom'],
        salesbn: json['salesbn'],
        salesday: json['salesday'],
        salespax: json['salespax'],
        salesrev: json['salesrev'],
        salesrn: json['salesrn'],
        salesroom: json['salesroom'],
      );

  Map<String, dynamic> toJson() => {
        'cxbn': cxbn,
        'cxday': cxday,
        'cxpax': cxpax,
        'cxrev': cxrev,
        'cxrn': cxrn,
        'cxroom': cxroom,
        'salesbn': salesbn,
        'salesday': salesday,
        'salespax': salespax,
        'salesrev': salesrev,
        'salesrn': salesrn,
        'salesroom': salesroom,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Sales &&
          runtimeType == other.runtimeType &&
          cxbn == other.cxbn &&
          cxday == other.cxday &&
          cxpax == other.cxpax &&
          cxrev == other.cxrev &&
          cxrn == other.cxrn &&
          cxroom == other.cxroom &&
          salesbn == other.salesbn &&
          salesday == other.salesday &&
          salespax == other.salespax &&
          salesrev == other.salesrev &&
          salesrn == other.salesrn &&
          salesroom == other.salesroom;

  @override
  int get hashCode =>
      cxbn.hashCode ^
      cxday.hashCode ^
      cxpax.hashCode ^
      cxrev.hashCode ^
      cxrn.hashCode ^
      cxroom.hashCode ^
      salesbn.hashCode ^
      salesday.hashCode ^
      salespax.hashCode ^
      salesrev.hashCode ^
      salesrn.hashCode ^
      salesroom.hashCode;

  @override
  String toString() {
    return 'Sales{cxbn: $cxbn, cxday: $cxday, cxpax: $cxpax, cxrev: $cxrev, cxrn: $cxrn, cxroom: $cxroom, salesbn: $salesbn, salesday: $salesday, salespax: $salespax, salesrev: $salesrev, salesrn: $salesrn, salesroom: $salesroom}';
  }
}
