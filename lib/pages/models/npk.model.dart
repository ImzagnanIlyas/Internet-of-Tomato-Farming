class NPKModel {
  double n;
  double p;
  double k;
  int Date;


  NPKModel(this.n, this.p, this.k, this.Date);

  factory NPKModel.fromJson(Map<dynamic, dynamic> json) {
    final n = json['N'] as double;
    final p = json['P'] as double;
    final k = json['K'] as double;
    final Date = json['Date'] as int;
    return NPKModel(n.toDouble(), p.toDouble(), k.toDouble(), Date);
  }

  @override
  String toString() {
    return 'NPKModel{n: $n, p: $p, k: $k, Date: $Date}';
  }
}