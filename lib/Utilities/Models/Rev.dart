class Rev {
  double balance; //liquid cash
  double bankcoll; //amount collected by bank transfer
  double cashcoll; //amount collected as cash
  double correction; // money spent or recieved as a result of past mistakes
  double crcardcoll; //creditcard payment
  double credit; //not sure
  double debit; //not sure of this either
  double discount; //uhhhh wat
  double extraadr;
  double extraapp;
  double extracorrection;
  double extrapab;
  double extrapar;
  double extrarev;
  double invagency; //investment agency
  double invbaldiff; //investment from people if and only if they are bald...
  double invclient;
  double invfo; //investment
  double invsupp;
  double invtotal;
  double invwaiting; //investments that are waiting
  double lastbalance; //remove this
  double netcorrection;
  double nettotal;
  double paidout;
  int paxcap; //max number of ppl u can house
  double payment;
  double revadr; //adr = average daily rate
  double revapp;
  double revenue; //net revenue
  double revenuex; 
  double revinv;
  double revpab; //revpar for beds
  double revpar; //https://en.wikipedia.org/wiki/RevPAR
  int roomcap;
  double roomcorrection;
  double roomrev;
  double taxtotal;
  double totalcoll;
  double totalcredit;
  int totalday;
  int totalpax;
  int totalpaxcap;
  int totalroom;
  int totalroomcap;

  Rev({
    this.balance,
    this.bankcoll,
    this.cashcoll,
    this.correction,
    this.crcardcoll,
    this.credit,
    this.debit,
    this.discount,
    this.extraadr,
    this.extraapp,
    this.extracorrection,
    this.extrapab,
    this.extrapar,
    this.extrarev,
    this.invagency,
    this.invbaldiff,
    this.invclient,
    this.invfo,
    this.invsupp,
    this.invtotal,
    this.invwaiting,
    this.lastbalance,
    this.netcorrection,
    this.nettotal,
    this.paidout,
    this.paxcap,
    this.payment,
    this.revadr,
    this.revapp,
    this.revenue,
    this.revenuex,
    this.revinv,
    this.revpab,
    this.revpar,
    this.roomcap,
    this.roomcorrection,
    this.roomrev,
    this.taxtotal,
    this.totalcoll,
    this.totalcredit,
    this.totalday,
    this.totalpax,
    this.totalpaxcap,
    this.totalroom,
    this.totalroomcap,
  });

  factory Rev.fromJson(Map<String, dynamic> json) => Rev(
        balance: json['balance'],
        bankcoll: json['bankcoll'],
        cashcoll: json['cashcoll'],
        correction: json['correction'],
        crcardcoll: json['crcardcoll'],
        credit: json['credit'],
        debit: json['debit'],
        discount: json['discount'],
        extraadr: json['extraadr'],
        extraapp: json['extraapp'],
        extracorrection: json['extracorrection'],
        extrapab: json['extrapab'],
        extrapar: json['extrapar'],
        extrarev: json['extrarev'],
        invagency: json['invagency'],
        invbaldiff: json['invbaldiff'],
        invclient: json['invclient'],
        invfo: json['invfo'],
        invsupp: json['invsupp'],
        invtotal: json['invtotal'],
        invwaiting: json['invwaiting'],
        lastbalance: json['lastbalance'],
        netcorrection: json['netcorrection'],
        nettotal: json['nettotal'],
        paidout: json['paidout'],
        paxcap: json['paxcap'],
        payment: json['payment'],
        revadr: json['revadr'],
        revapp: json['revapp'],
        revenue: json['revenue'],
        revenuex: json['revenuex'],
        revinv: json['revinv'],
        revpab: json['revpab'],
        revpar: json['revpar'],
        roomcap: json['roomcap'],
        roomcorrection: json['roomcorrection'],
        roomrev: json['roomrev'],
        taxtotal: json['taxtotal'],
        totalcoll: json['totalcoll'],
        totalcredit: json['totalcredit'],
        totalday: json['totalday'],
        totalpax: json['totalpax'],
        totalpaxcap: json['totalpaxcap'],
        totalroom: json['totalroom'],
        totalroomcap: json['totalroomcap'],
      );

  Map<String, dynamic> toJson() => {
        'balance': balance,
        'bankcoll': bankcoll,
        'cashcoll': cashcoll,
        'correction': correction,
        'crcardcoll': crcardcoll,
        'credit': credit,
        'debit': debit,
        'discount': discount,
        'extraadr': extraadr,
        'extraapp': extraapp,
        'extracorrection': extracorrection,
        'extrapab': extrapab,
        'extrapar': extrapar,
        'extrarev': extrarev,
        'invagency': invagency,
        'invbaldiff': invbaldiff,
        'invclient': invclient,
        'invfo': invfo,
        'invsupp': invsupp,
        'invtotal': invtotal,
        'invwaiting': invwaiting,
        'lastbalance': lastbalance,
        'netcorrection': netcorrection,
        'nettotal': nettotal,
        'paidout': paidout,
        'paxcap': paxcap,
        'payment': payment,
        'revadr': revadr,
        'revapp': revapp,
        'revenue': revenue,
        'revenuex': revenuex,
        'revinv': revinv,
        'revpab': revpab,
        'revpar': revpar,
        'roomcap': roomcap,
        'roomcorrection': roomcorrection,
        'roomrev': roomrev,
        'taxtotal': taxtotal,
        'totalcoll': totalcoll,
        'totalcredit': totalcredit,
        'totalday': totalday,
        'totalpax': totalpax,
        'totalpaxcap': totalpaxcap,
        'totalroom': totalroom,
        'totalroomcap': totalroomcap,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Rev &&
          runtimeType == other.runtimeType &&
          balance == other.balance &&
          bankcoll == other.bankcoll &&
          cashcoll == other.cashcoll &&
          correction == other.correction &&
          crcardcoll == other.crcardcoll &&
          credit == other.credit &&
          debit == other.debit &&
          discount == other.discount &&
          extraadr == other.extraadr &&
          extraapp == other.extraapp &&
          extracorrection == other.extracorrection &&
          extrapab == other.extrapab &&
          extrapar == other.extrapar &&
          extrarev == other.extrarev &&
          invagency == other.invagency &&
          invbaldiff == other.invbaldiff &&
          invclient == other.invclient &&
          invfo == other.invfo &&
          invsupp == other.invsupp &&
          invtotal == other.invtotal &&
          invwaiting == other.invwaiting &&
          lastbalance == other.lastbalance &&
          netcorrection == other.netcorrection &&
          nettotal == other.nettotal &&
          paidout == other.paidout &&
          paxcap == other.paxcap &&
          payment == other.payment &&
          revadr == other.revadr &&
          revapp == other.revapp &&
          revenue == other.revenue &&
          revenuex == other.revenuex &&
          revinv == other.revinv &&
          revpab == other.revpab &&
          revpar == other.revpar &&
          roomcap == other.roomcap &&
          roomcorrection == other.roomcorrection &&
          roomrev == other.roomrev &&
          taxtotal == other.taxtotal &&
          totalcoll == other.totalcoll &&
          totalcredit == other.totalcredit &&
          totalday == other.totalday &&
          totalpax == other.totalpax &&
          totalpaxcap == other.totalpaxcap &&
          totalroom == other.totalroom &&
          totalroomcap == other.totalroomcap;

  @override
  int get hashCode =>
      balance.hashCode ^
      bankcoll.hashCode ^
      cashcoll.hashCode ^
      correction.hashCode ^
      crcardcoll.hashCode ^
      credit.hashCode ^
      debit.hashCode ^
      discount.hashCode ^
      extraadr.hashCode ^
      extraapp.hashCode ^
      extracorrection.hashCode ^
      extrapab.hashCode ^
      extrapar.hashCode ^
      extrarev.hashCode ^
      invagency.hashCode ^
      invbaldiff.hashCode ^
      invclient.hashCode ^
      invfo.hashCode ^
      invsupp.hashCode ^
      invtotal.hashCode ^
      invwaiting.hashCode ^
      lastbalance.hashCode ^
      netcorrection.hashCode ^
      nettotal.hashCode ^
      paidout.hashCode ^
      paxcap.hashCode ^
      payment.hashCode ^
      revadr.hashCode ^
      revapp.hashCode ^
      revenue.hashCode ^
      revenuex.hashCode ^
      revinv.hashCode ^
      revpab.hashCode ^
      revpar.hashCode ^
      roomcap.hashCode ^
      roomcorrection.hashCode ^
      roomrev.hashCode ^
      taxtotal.hashCode ^
      totalcoll.hashCode ^
      totalcredit.hashCode ^
      totalday.hashCode ^
      totalpax.hashCode ^
      totalpaxcap.hashCode ^
      totalroom.hashCode ^
      totalroomcap.hashCode;

  @override
  String toString() {
    return 'Rev{balance: $balance, bankcoll: $bankcoll, cashcoll: $cashcoll, correction: $correction, crcardcoll: $crcardcoll, credit: $credit, debit: $debit, discount: $discount, extraadr: $extraadr, extraapp: $extraapp, extracorrection: $extracorrection, extrapab: $extrapab, extrapar: $extrapar, extrarev: $extrarev, invagency: $invagency, invbaldiff: $invbaldiff, invclient: $invclient, invfo: $invfo, invsupp: $invsupp, invtotal: $invtotal, invwaiting: $invwaiting, lastbalance: $lastbalance, netcorrection: $netcorrection, nettotal: $nettotal, paidout: $paidout, paxcap: $paxcap, payment: $payment, revadr: $revadr, revapp: $revapp, revenue: $revenue, revenuex: $revenuex, revinv: $revinv, revpab: $revpab, revpar: $revpar, roomcap: $roomcap, roomcorrection: $roomcorrection, roomrev: $roomrev, taxtotal: $taxtotal, totalcoll: $totalcoll, totalcredit: $totalcredit, totalday: $totalday, totalpax: $totalpax, totalpaxcap: $totalpaxcap, totalroom: $totalroom, totalroomcap: $totalroomcap}';
  }
}
