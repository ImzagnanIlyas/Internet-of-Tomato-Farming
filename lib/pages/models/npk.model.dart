class NPKModel {
  int n;
  int p;
  int k;
  int Date;


  NPKModel(this.n, this.p, this.k, this.Date);

  factory NPKModel.fromJson(Map<dynamic, dynamic> json) {
    final n = json['N'] as int;
    final p = json['P'] as int;
    final k = json['K'] as int;
    final Date = json['Date'] as int;
    return NPKModel(n, p, k, Date);
  }

  @override
  String toString() {
    return 'NPKModel{n: $n, p: $p, k: $k, Date: $Date}';
  }
}