import 'package:gpp_app/models/json/pet_model.dart';
import 'package:gpp_app/models/json/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'user_auth.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(fieldRename: FieldRename.snake)
class UserAuth {
  UserAuth(
    this.accessToken,
    this.user,
    this.pet,
  );
  String accessToken;
  UserModel user;
  PetModel pet;

  @override
  String toString() {
    return 'JSON-UserAuth: $accessToken, $user, $pet';
  }

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory UserAuth.fromJson(Map<String, dynamic> json) =>
      _$UserAuthFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$UserAuthToJson(this);
}
