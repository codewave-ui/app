abstract class Serializable {
  Map<String, dynamic> toJson();

  void fromJson(Map<String, dynamic> json);
}
