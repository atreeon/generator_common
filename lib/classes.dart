// ignore: import_of_legacy_library_into_null_safe

class Interface {
  final String type;
  final List<String> typeArgsTypes;
  final List<String> typeParamsNames;

  Interface(this.type, this.typeArgsTypes, this.typeParamsNames) {
    assert(this.typeArgsTypes.length == this.typeParamsNames.length, "typeArgs must have same length as typeParams");
  }

  toString() => "${this.type}|${this.typeArgsTypes}|${this.typeParamsNames}";
}

class NameType {
  final String type;
  final String name;

  NameType(this.name, this.type);

  toString() => "${this.name}:${this.type}";
}

class InterfaceWithComment extends Interface {
  final String? comment;

  InterfaceWithComment(
    String type,
    List<String> typeArgsTypes,
    List<String> typeParamsNames, {
    this.comment,
  }) : super(type, typeArgsTypes, typeParamsNames);
}

class NameTypeWithComment extends NameType {
  final String? comment;

  NameTypeWithComment(
    String name,
    String type, {
    this.comment,
  }) : super(name, type);
}

class MethodDetails {
  final String? methodComment;
  final String methodName;
  final List<NameTypeWithComment> paramsPositional;
  final List<NameTypeWithComment> paramsNamed;
  final List<NameType> generics;
  final String returnType;

  MethodDetails(
    this.methodComment,
    this.methodName,
    this.paramsPositional,
    this.paramsNamed,
    this.generics,
    this.returnType,
  );
}
