// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_rate_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExchangeRateResponseModelAdapter
    extends TypeAdapter<ExchangeRateResponseModel> {
  @override
  final int typeId = 1;

  @override
  ExchangeRateResponseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExchangeRateResponseModel(
      result: fields[0] as String?,
      documentation: fields[1] as String?,
      termsOfUse: fields[2] as String?,
      timeLastUpdateUnix: fields[3] as num?,
      timeLastUpdateUtc: fields[4] as String?,
      timeNextUpdateUnix: fields[5] as num?,
      timeNextUpdateUtc: fields[6] as String?,
      baseCode: fields[7] as String?,
      conversionRates: (fields[8] as Map).cast<String, num>(),
      expiration: fields[9] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ExchangeRateResponseModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.result)
      ..writeByte(1)
      ..write(obj.documentation)
      ..writeByte(2)
      ..write(obj.termsOfUse)
      ..writeByte(3)
      ..write(obj.timeLastUpdateUnix)
      ..writeByte(4)
      ..write(obj.timeLastUpdateUtc)
      ..writeByte(5)
      ..write(obj.timeNextUpdateUnix)
      ..writeByte(6)
      ..write(obj.timeNextUpdateUtc)
      ..writeByte(7)
      ..write(obj.baseCode)
      ..writeByte(8)
      ..write(obj.conversionRates)
      ..writeByte(9)
      ..write(obj.expiration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExchangeRateResponseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
