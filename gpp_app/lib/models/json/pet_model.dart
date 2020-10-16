import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'pet_model.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class PetModel {
  PetModel(
    this.id,
    this.name,
    this.breed,
    this.gender,
    this.birth,
    this.adoption,
  );

  int id;
  String name;
  String breed;
  String gender;
  DateTime birth;
  DateTime adoption;

  @override
  String toString() {
    return 'JSON-PetModel: $id, $name, $breed, $gender, $birth, $adoption';
  }

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory PetModel.fromJson(Map<String, dynamic> json) =>
      _$PetModelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$PetModelToJson(this);
}
