import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'monthly_report.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class MonthlyReport {
  MonthlyReport(
    this.date,
    this.pet_id,
    this.user_id,
    this.count,
    this.success,
    this.ratio,
    this.created_date,
    this.last_modified_date,
  );

  String date;
  int pet_id;
  int user_id;
  int count;
  int success;
  double ratio;
  String created_date;
  String last_modified_date;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory MonthlyReport.fromJson(Map<String, dynamic> json) =>
      _$MonthlyReportFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$MonthlyReportToJson(this);
}
