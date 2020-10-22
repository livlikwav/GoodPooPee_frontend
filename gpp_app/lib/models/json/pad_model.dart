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
    this.ldx,
    this.ldy,
    this.lux,
    this.luy,
    this.rdx,
    this.rdy,
    this.rux,
    this.rdy,
  );

  // int userId;
  int id;
  int ldx;
  int ldy;
  int lux;
  int luy;
  int rdx;
  int rdy;
  int rux;
  int ruy;

  @override
  String toString() {
    return 'JSON-PadModel: id: $id, [ldx, ldy, lux, luy, rdx, rdy, rux, ruy]: [$ldx, $ldy, $lux, $luy, $rdx, $rdy, $rux, $ruy]';
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
