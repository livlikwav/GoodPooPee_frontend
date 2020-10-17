import 'package:gpp_app/models/provider/pet_profile.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'pet_model.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(fieldRename: FieldRename.snake)
class PetModel {
  PetModel(
    this.id,
    this.userId,
    this.name,
    this.breed,
    this.gender,
    this.birth,
    this.adoption,
  );

  int id;
  int userId;
  String name;
  String breed;
  Gender gender;
  DateTime birth;
  DateTime adoption;

  String get genderStr => gender.toString().split('.')[1];

  PetModel.petProfile(PetProfile petProfile) {
    id = petProfile.id;
    userId = petProfile.userId;
    name = petProfile.name;
    breed = petProfile.breed;
    gender = petProfile.gender;
    birth = petProfile.birth;
    adoption = petProfile.adoption;
  }

  @override
  String toString() {
    return 'JSON-PetModel: pet: $id, user: $userId, $name, $breed, $gender, $birth, $adoption';
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
