import 'package:gpp_app/util/my_logger.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'pad_model.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(fieldRename: FieldRename.snake)
class PadModel {
  PadModel(
    // this.userId,
    this.id,
    this.lux,
    this.luy,
    this.ldx,
    this.ldy,
    this.rdx,
    this.rdy,
    this.rux,
    this.ruy,
  );

  PadModel.byList(List<double> posList) {
    if (posList.length != 8) {
      MyLogger.error('PadModel addList list param length is not 8');
      throw Exception('PadModel addList list param length is not 8');
    } else {
      lux = posList[0];
      luy = posList[1];
      ldx = posList[2];
      ldy = posList[3];
      rdx = posList[4];
      rdy = posList[5];
      rux = posList[6];
      ruy = posList[7];
      MyLogger.debug('PadModel byList: ${toString()}');
    }
  }

  // int userId;
  int id;
  double lux;
  double luy;
  double ldx;
  double ldy;
  double rdx;
  double rdy;
  double rux;
  double ruy;

  void addList(List<double> list) {
    if (list.length != 8) {
      MyLogger.debug('PadModel addList list param length is not 8');
    } else {
      lux = list[0];
      luy = list[1];
      ldx = list[2];
      ldy = list[3];
      rdx = list[4];
      rdy = list[5];
      rux = list[6];
      ruy = list[7];
      MyLogger.debug('PadModel addList: ${toString()}');
    }
  }

  @override
  String toString() {
    return 'JSON-PadModel: id: $id, [lux, luy, ldx, ldy, rdx, rdy, rux, ruy]: [$lux, $luy, $ldx, $ldy, $rdx, $rdy, $rux, $ruy]';
  }

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory PadModel.fromJson(Map<String, dynamic> json) =>
      _$PadModelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$PadModelToJson(this);
}
