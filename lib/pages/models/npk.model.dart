class NPKModel {
  double n;
  double p;
  double k;
  int Date;


  NPKModel(this.n, this.p, this.k, this.Date);

  factory NPKModel.fromJson(Map<dynamic, dynamic> json) {
    final n = json['N'];
    final p = json['P'];
    final k = json['K'];
    final Date = json['Date'] as int;
    return NPKModel(n.toDouble(), p.toDouble(), k.toDouble(), Date);
  }

  @override
  String toString() {
    return 'NPKModel{n: $n, p: $p, k: $k, Date: $Date}';
  }
}