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

class GenericsNameType {
  final String name;
  final String? type;

  GenericsNameType(
    this.name,
    this.type,
  );

  toString() => "${this.name}:${this.type}";
}

class NameType {
  final String name;
  final String type;

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

class NameTypeWithComment<TMeta1> extends NameType {
  final String? comment;
  final TMeta1? meta1;

  NameTypeWithComment(
    String name,
    String type, {
    this.comment,
    this.meta1,
  }) : super(name, type);
}

class MethodDetails<TMeta1> {
  final String? methodComment;
  final String methodName;
  final List<NameTypeWithComment<TMeta1>> paramsPositional;
  final List<NameTypeWithComment<TMeta1>> paramsNamed;
  final List<GenericsNameType> generics;
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
