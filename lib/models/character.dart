import 'dart:collection';

class Character {
  Map info;
  double difficulty;
  String series;
  Map tilts;
  Map smashes;
  Map specials;
  Map ultimateSmash;

  Character(this.info, this.difficulty, this.series, this.tilts, this.smashes,
      this.specials, this.ultimateSmash);

  factory Character.fromJson(dynamic json) {
    return Character(
        json['info'] as Map,
        json['difficulty'] as double,
        json['series'] as String,
        json['tilts'] as Map,
        json['smashes'] as Map,
        json['specials'] as Map,
        json['ultimateSmash'] as Map);
  }
}
