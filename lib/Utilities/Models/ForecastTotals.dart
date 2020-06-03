class ForecastTotals {
  int cibaby; //checkin
  int cichd; //remove all chds
  int cipax;
  int ciroom;
  int cobaby;
  int cochd;
  int compbaby;
  int compchd;
  int comppax;
  int comproom;
  int copax;
  int coroom; //checkout
  int cxbaby;
  int cxchd;
  int cxpax;
  int cxroom;
  int hubaby;
  int huchd;
  int hupax;
  int huroom; //day use: checkin date = checkout date
  int nsbaby; //needs service?
  int nschd;
  int nspax;
  int nsroom;
  double occrate; //occupancy rate (rooms used / rooms total)
  double occratebed; //same as above but for beds
  int totalbaby;
  int totalcap;
  int totalcapbed;
  int totalchd;
  int totalempty;
  int totalemptybed;
  int totalocc;
  int totaloccbed;
  int totalpax;
  int totalroom;

  Map<String, dynamic> jsonMap;

  //Do not use this [constructor] to create the models; Use fromJson instead.
  ForecastTotals(
      {this.cibaby,
      this.cichd,
      this.cipax,
      this.ciroom,
      this.cobaby,
      this.cochd,
      this.compbaby,
      this.compchd,
      this.comppax,
      this.comproom,
      this.copax,
      this.coroom,
      this.cxbaby,
      this.cxchd,
      this.cxpax,
      this.cxroom,
      this.hubaby,
      this.huchd,
      this.hupax,
      this.huroom,
      this.nsbaby,
      this.nschd,
      this.nspax,
      this.nsroom,
      this.occrate,
      this.occratebed,
      this.totalbaby,
      this.totalcap,
      this.totalcapbed,
      this.totalchd,
      this.totalempty,
      this.totalemptybed,
      this.totalocc,
      this.totaloccbed,
      this.totalpax,
      this.totalroom,
      this.jsonMap});

  factory ForecastTotals.fromJson(Map<String, dynamic> json) => new ForecastTotals(
        cibaby: json['cibaby'],
        cichd: json['cichd'],
        cipax: json['cipax'],
        ciroom: json['ciroom'],
        cobaby: json['cobaby'],
        cochd: json['cochd'],
        compbaby: json['compbaby'],
        compchd: json['compchd'],
        comppax: json['comppax'],
        comproom: json['comproom'],
        copax: json['copax'],
        coroom: json['coroom'],
        cxbaby: json['cxbaby'],
        cxchd: json['cxchd'],
        cxpax: json['cxpax'],
        cxroom: json['cxroom'],
        hubaby: json['hubaby'],
        huchd: json['huchd'],
        hupax: json['hupax'],
        huroom: json['huroom'],
        nsbaby: json['nsbaby'],
        nschd: json['nschd'],
        nspax: json['nspax'],
        nsroom: json['nsroom'],
        occrate: json['occrate'],
        occratebed: json['occratebed'],
        totalbaby: json['totalbaby'],
        totalcap: json['totalcap'],
        totalcapbed: json['totalcapbed'],
        totalchd: json['totalchd'],
        totalempty: json['totalempty'],
        totalemptybed: json['totalemptybed'],
        totalocc: json['totalocc'],
        totaloccbed: json['totaloccbed'],
        totalpax: json['totalpax'],
        totalroom: json['totalroom'],
        jsonMap: json,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'cibaby': cibaby,
        'cichd': cichd,
        'cipax': cipax,
        'ciroom': ciroom,
        'cobaby': cobaby,
        'cochd': cochd,
        'compbaby': compbaby,
        'compchd': compchd,
        'comppax': comppax,
        'comproom': comproom,
        'copax': copax,
        'coroom': coroom,
        'cxbaby': cxbaby,
        'cxchd': cxchd,
        'cxpax': cxpax,
        'cxroom': cxroom,
        'hubaby': hubaby,
        'huchd': huchd,
        'hupax': hupax,
        'huroom': huroom,
        'nsbaby': nsbaby,
        'nschd': nschd,
        'nspax': nspax,
        'nsroom': nsroom,
        'occrate': occrate,
        'occratebed': occratebed,
        'totalbaby': totalbaby,
        'totalcap': totalcap,
        'totalcapbed': totalcapbed,
        'totalchd': totalchd,
        'totalempty': totalempty,
        'totalemptybed': totalemptybed,
        'totalocc': totalocc,
        'totaloccbed': totaloccbed,
        'totalpax': totalpax,
        'totalroom': totalroom,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForecastTotals &&
          runtimeType == other.runtimeType &&
          cibaby == other.cibaby &&
          cichd == other.cichd &&
          cipax == other.cipax &&
          ciroom == other.ciroom &&
          cobaby == other.cobaby &&
          cochd == other.cochd &&
          compbaby == other.compbaby &&
          compchd == other.compchd &&
          comppax == other.comppax &&
          comproom == other.comproom &&
          copax == other.copax &&
          coroom == other.coroom &&
          cxbaby == other.cxbaby &&
          cxchd == other.cxchd &&
          cxpax == other.cxpax &&
          cxroom == other.cxroom &&
          hubaby == other.hubaby &&
          huchd == other.huchd &&
          hupax == other.hupax &&
          huroom == other.huroom &&
          nsbaby == other.nsbaby &&
          nschd == other.nschd &&
          nspax == other.nspax &&
          nsroom == other.nsroom &&
          occrate == other.occrate &&
          occratebed == other.occratebed &&
          totalbaby == other.totalbaby &&
          totalcap == other.totalcap &&
          totalcapbed == other.totalcapbed &&
          totalchd == other.totalchd &&
          totalempty == other.totalempty &&
          totalemptybed == other.totalemptybed &&
          totalocc == other.totalocc &&
          totaloccbed == other.totaloccbed &&
          totalpax == other.totalpax &&
          totalroom == other.totalroom &&
          jsonMap == other.jsonMap;

  @override
  int get hashCode =>
      cibaby.hashCode ^
      cichd.hashCode ^
      cipax.hashCode ^
      ciroom.hashCode ^
      cobaby.hashCode ^
      cochd.hashCode ^
      compbaby.hashCode ^
      compchd.hashCode ^
      comppax.hashCode ^
      comproom.hashCode ^
      copax.hashCode ^
      coroom.hashCode ^
      cxbaby.hashCode ^
      cxchd.hashCode ^
      cxpax.hashCode ^
      cxroom.hashCode ^
      hubaby.hashCode ^
      huchd.hashCode ^
      hupax.hashCode ^
      huroom.hashCode ^
      nsbaby.hashCode ^
      nschd.hashCode ^
      nspax.hashCode ^
      nsroom.hashCode ^
      occrate.hashCode ^
      occratebed.hashCode ^
      totalbaby.hashCode ^
      totalcap.hashCode ^
      totalcapbed.hashCode ^
      totalchd.hashCode ^
      totalempty.hashCode ^
      totalemptybed.hashCode ^
      totalocc.hashCode ^
      totaloccbed.hashCode ^
      totalpax.hashCode ^
      totalroom.hashCode ^
      jsonMap.hashCode;

  @override
  String toString() {
    return 'ForecastTotals{cibaby: $cibaby, cichd: $cichd, cipax: $cipax, ciroom: $ciroom, cobaby: $cobaby, cochd: $cochd, compbaby: $compbaby, compchd: $compchd, comppax: $comppax, comproom: $comproom, copax: $copax, coroom: $coroom, cxbaby: $cxbaby, cxchd: $cxchd, cxpax: $cxpax, cxroom: $cxroom, hubaby: $hubaby, huchd: $huchd, hupax: $hupax, huroom: $huroom, nsbaby: $nsbaby, nschd: $nschd, nspax: $nspax, nsroom: $nsroom, occrate: $occrate, occratebed: $occratebed, totalbaby: $totalbaby, totalcap: $totalcap, totalcapbed: $totalcapbed, totalchd: $totalchd, totalempty: $totalempty, totalemptybed: $totalemptybed, totalocc: $totalocc, totaloccbed: $totaloccbed, totalpax: $totalpax, totalroom: $totalroom, jsonMap: $jsonMap}';
  }
}
