// ignore_for_file: camel_case_types

part of 'convert_cubit.dart';

@immutable
sealed class ConvertState {}

final class ConvertInitial extends ConvertState {}
class pdbsucsess extends ConvertState {}
class pdpfailed extends ConvertState {}
class sdfsucsses extends ConvertState {}
class sdffailed extends ConvertState {}
class pdbsucsesssave extends ConvertState {}
class pdpfailedsave extends ConvertState {}
class sdfsucssessave extends ConvertState {}
class sdffailedsave extends ConvertState {}
class sdfsmilesucssess extends ConvertState {}
class sdffailedsmile extends ConvertState {}