class LanguageModel {
  String name;
  String code;
  bool selected;
  LanguageModel({
    required this.name,
    required this.code,
    required this.selected,
  });

  LanguageModel copyWith({String? name, String? code, bool? selected}) {
    return LanguageModel(
      name: name ?? this.name,
      code: code ?? this.code,
      selected: selected ?? this.selected,
    );
  }
}
