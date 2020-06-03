class ForecastDay {
  int aday;
  int amonth;
  int ayear;
  double boardrevenue; 
  double boardrevenuecurr;
  int cichd; //chd = child
  int cipax;
  int ciroom;
  int cochd;
  int compchd;
  int comppax; //complementary (free stuff)
  int comproom;
  int cxchd;
  int cxpax;
  int cxroom;
  int copax;
  int coroom;
  double extrarevenue;
  double extrarevenuecurr;
  int huchd;
  int hupax;
  int huroom;
  int nschd;
  int nspax;
  int nsroom;
  double roomingrevenue;
  double roomingrevenuecurr;
  double roomrevenue;
  double roomrevenuecurr;
  String rptcurr;
  int totalcapbed;
  int totalcaproom;
  int totalchd;
  int totalemptybed;
  int totalemptyroom;
  int totalpax;
  double totalrevenue;
  double totalrevenuecurr;
  int totalroom;
  int totalshortroom;
  int totalvirtualroom;
  String transdate;

  Map<String, dynamic> jsonMap;

  //Do not use this [constructor] to create the models; Use fromJson instead.
  ForecastDay({
    this.aday,
    this.amonth,
    this.ayear,
    this.boardrevenue,
    this.boardrevenuecurr,
    this.cichd,
    this.cipax,
    this.ciroom,
    this.cochd,
    this.compchd,
    this.comppax,
    this.comproom,
    this.copax,
    this.coroom,
    this.cxchd,
    this.cxpax,
    this.cxroom,
    this.extrarevenue,
    this.extrarevenuecurr,
    this.huchd,
    this.hupax,
    this.huroom,
    this.nschd,
    this.nspax,
    this.nsroom,
    this.roomingrevenue,
    this.roomingrevenuecurr,
    this.roomrevenue,
    this.roomrevenuecurr,
    this.rptcurr,
    this.totalcapbed,
    this.totalcaproom,
    this.totalchd,
    this.totalemptybed,
    this.totalemptyroom,
    this.totalpax,
    this.totalrevenue,
    this.totalrevenuecurr,
    this.totalroom,
    this.totalshortroom,
    this.totalvirtualroom,
    this.transdate,
    this.jsonMap,
  });

  factory ForecastDay.fromJson(Map<String, dynamic> json) => new ForecastDay(
        aday: json['aday'],
        amonth: json['amonth'],
        ayear: json['ayear'],
        boardrevenue: json['boardrevenue'],
        boardrevenuecurr: json['boardrevenuecurr'],
        cichd: json['cichd'],
        cipax: json['cipax'],
        ciroom: json['ciroom'],
        cochd: json['cochd'],
        compchd: json['compchd'],
        comppax: json['comppax'],
        comproom: json['comproom'],
        copax: json['copax'],
        coroom: json['coroom'],
        cxchd: json['cxchd'],
        cxpax: json['cxpax'],
        cxroom: json['cxroom'],
        extrarevenue: json['extrarevenue'],
        extrarevenuecurr: json['extrarevenuecurr'],
        huchd: json['huchd'],
        hupax: json['hupax'],
        huroom: json['huroom'],
        nschd: json['nschd'],
        nspax: json['nspax'],
        nsroom: json['nsroom'],
        roomingrevenue: json['roomingrevenue'],
        roomingrevenuecurr: json['roomingrevenuecurr'],
        roomrevenue: json['roomrevenue'],
        roomrevenuecurr: json['roomrevenuecurr'],
        rptcurr: json['rptcurr'],
        totalcapbed: json['totalcapbed'],
        totalcaproom: json['totalcaproom'],
        totalchd: json['totalchd'],
        totalemptybed: json['totalemptybed'],
        totalemptyroom: json['totalemptyroom'],
        totalpax: json['totalpax'],
        totalrevenue: json['totalrevenue'],
        totalrevenuecurr: json['totalrevenuecurr'],
        totalroom: json['totalroom'],
        totalshortroom: json['totalshortroom'],
        totalvirtualroom: json['totalvirtualroom'],
        transdate: json['transdate'],
        jsonMap: json,
      );

  Map<String, dynamic> toJson() => {
        'aday': aday,
        'amonth': amonth,
        'ayear': ayear,
        'boardrevenue': boardrevenue,
        'boardrevenuecurr': boardrevenuecurr,
        'cichd': cichd,
        'cipax': cipax,
        'ciroom': ciroom,
        'cochd': cochd,
        'compchd': compchd,
        'comppax': comppax,
        'comproom': comproom,
        'copax': copax,
        'coroom': coroom,
        'cxchd': cxchd,
        'cxpax': cxpax,
        'cxroom': cxroom,
        'extrarevenue': extrarevenue,
        'extrarevenuecurr': extrarevenuecurr,
        'huchd': huchd,
        'hupax': hupax,
        'huroom': huroom,
        'nschd': nschd,
        'nspax': nspax,
        'nsroom': nsroom,
        'roomingrevenue': roomingrevenue,
        'roomingrevenuecurr': roomingrevenuecurr,
        'roomrevenue': roomrevenue,
        'roomrevenuecurr': roomrevenuecurr,
        'rptcurr': rptcurr,
        'totalcapbed': totalcapbed,
        'totalcaproom': totalcaproom,
        'totalchd': totalchd,
        'totalemptybed': totalemptybed,
        'totalemptyroom': totalemptyroom,
        'totalpax': totalpax,
        'totalrevenue': totalrevenue,
        'totalrevenuecurr': totalrevenuecurr,
        'totalroom': totalroom,
        'totalshortroom': totalshortroom,
        'totalvirtualroom': totalvirtualroom,
        'transdate': transdate,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForecastDay &&
          runtimeType == other.runtimeType &&
          aday == other.aday &&
          amonth == other.amonth &&
          ayear == other.ayear &&
          boardrevenue == other.boardrevenue &&
          boardrevenuecurr == other.boardrevenuecurr &&
          cichd == other.cichd &&
          cipax == other.cipax &&
          ciroom == other.ciroom &&
          cochd == other.cochd &&
          compchd == other.compchd &&
          comppax == other.comppax &&
          comproom == other.comproom &&
          copax == other.copax &&
          coroom == other.coroom &&
          cxchd == other.cxchd &&
          cxpax == other.cxpax &&
          cxroom == other.cxroom &&
          extrarevenue == other.extrarevenue &&
          extrarevenuecurr == other.extrarevenuecurr &&
          huchd == other.huchd &&
          hupax == other.hupax &&
          huroom == other.huroom &&
          nschd == other.nschd &&
          nspax == other.nspax &&
          nsroom == other.nsroom &&
          roomingrevenue == other.roomingrevenue &&
          roomingrevenuecurr == other.roomingrevenuecurr &&
          roomrevenue == other.roomrevenue &&
          roomrevenuecurr == other.roomrevenuecurr &&
          rptcurr == other.rptcurr &&
          totalcapbed == other.totalcapbed &&
          totalcaproom == other.totalcaproom &&
          totalchd == other.totalchd &&
          totalemptybed == other.totalemptybed &&
          totalemptyroom == other.totalemptyroom &&
          totalpax == other.totalpax &&
          totalrevenue == other.totalrevenue &&
          totalrevenuecurr == other.totalrevenuecurr &&
          totalroom == other.totalroom &&
          totalshortroom == other.totalshortroom &&
          totalvirtualroom == other.totalvirtualroom &&
          transdate == other.transdate &&
          jsonMap == other.jsonMap;

  @override
  int get hashCode =>
      aday.hashCode ^
      amonth.hashCode ^
      ayear.hashCode ^
      boardrevenue.hashCode ^
      boardrevenuecurr.hashCode ^
      cichd.hashCode ^
      cipax.hashCode ^
      ciroom.hashCode ^
      cochd.hashCode ^
      compchd.hashCode ^
      comppax.hashCode ^
      comproom.hashCode ^
      copax.hashCode ^
      coroom.hashCode ^
      cxchd.hashCode ^
      cxpax.hashCode ^
      cxroom.hashCode ^
      extrarevenue.hashCode ^
      extrarevenuecurr.hashCode ^
      huchd.hashCode ^
      hupax.hashCode ^
      huroom.hashCode ^
      nschd.hashCode ^
      nspax.hashCode ^
      nsroom.hashCode ^
      roomingrevenue.hashCode ^
      roomingrevenuecurr.hashCode ^
      roomrevenue.hashCode ^
      roomrevenuecurr.hashCode ^
      rptcurr.hashCode ^
      totalcapbed.hashCode ^
      totalcaproom.hashCode ^
      totalchd.hashCode ^
      totalemptybed.hashCode ^
      totalemptyroom.hashCode ^
      totalpax.hashCode ^
      totalrevenue.hashCode ^
      totalrevenuecurr.hashCode ^
      totalroom.hashCode ^
      totalshortroom.hashCode ^
      totalvirtualroom.hashCode ^
      transdate.hashCode ^
      jsonMap.hashCode;

  @override
  String toString() {
    return 'ForecastDay{aday: $aday, amonth: $amonth, ayear: $ayear, boardrevenue: $boardrevenue, boardrevenuecurr: $boardrevenuecurr, cichd: $cichd, cipax: $cipax, ciroom: $ciroom, cochd: $cochd, compchd: $compchd, comppax: $comppax, comproom: $comproom, copax: $copax, coroom: $coroom, cxchd: $cxchd, cxpax: $cxpax, cxroom: $cxroom, extrarevenue: $extrarevenue, extrarevenuecurr: $extrarevenuecurr, huchd: $huchd, hupax: $hupax, huroom: $huroom, nschd: $nschd, nspax: $nspax, nsroom: $nsroom, roomingrevenue: $roomingrevenue, roomingrevenuecurr: $roomingrevenuecurr, roomrevenue: $roomrevenue, roomrevenuecurr: $roomrevenuecurr, rptcurr: $rptcurr, totalcapbed: $totalcapbed, totalcaproom: $totalcaproom, totalchd: $totalchd, totalemptybed: $totalemptybed, totalemptyroom: $totalemptyroom, totalpax: $totalpax, totalrevenue: $totalrevenue, totalrevenuecurr: $totalrevenuecurr, totalroom: $totalroom, totalshortroom: $totalshortroom, totalvirtualroom: $totalvirtualroom, transdate: $transdate, jsonMap: $jsonMap}';
  }
}
