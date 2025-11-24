import '../models/units.dart';

class Conversions {
  static double convertLength(double value, String fromUnit, String toUnit) {
    if (fromUnit == toUnit) return value;
    double baseValue = value / Units.length[fromUnit]!;
    return baseValue * Units.length[toUnit]!;
  }

  static double convertWeight(double value, String fromUnit, String toUnit) {
    if (fromUnit == toUnit) return value;
    double baseValue = value / Units.weight[fromUnit]!;
    return baseValue * Units.weight[toUnit]!;
  }

  static double convertTemperature(
    double value,
    String fromUnit,
    String toUnit,
  ) {
    if (fromUnit == toUnit) return value;
    double celsius;
    if (fromUnit == 'Celsius') {
      celsius = value;
    } else if (fromUnit == 'Fahrenheit') {
      celsius = (value - 32) * 5 / 9;
    } else {
      // Kelvin
      celsius = value - 273.15;
    }

    if (toUnit == 'Celsius') {
      return celsius;
    } else if (toUnit == 'Fahrenheit') {
      return celsius * 9 / 5 + 32;
    } else {
      // Kelvin
      return celsius + 273.15;
    }
  }

  static double convertVolume(double value, String fromUnit, String toUnit) {
    if (fromUnit == toUnit) return value;
    double baseValue = value / Units.volume[fromUnit]!;
    return baseValue * Units.volume[toUnit]!;
  }

  static double convertArea(double value, String fromUnit, String toUnit) {
    if (fromUnit == toUnit) return value;
    double baseValue = value / Units.area[fromUnit]!;
    return baseValue * Units.area[toUnit]!;
  }

  static double convertTime(double value, String fromUnit, String toUnit) {
    if (fromUnit == toUnit) return value;
    double baseValue = value / Units.time[fromUnit]!;
    return baseValue * Units.time[toUnit]!;
  }

  static double convert(
    String category,
    double value,
    String fromUnit,
    String toUnit,
  ) {
    switch (category) {
      case 'Length':
        return convertLength(value, fromUnit, toUnit);
      case 'Weight':
        return convertWeight(value, fromUnit, toUnit);
      case 'Temperature':
        return convertTemperature(value, fromUnit, toUnit);
      case 'Volume':
        return convertVolume(value, fromUnit, toUnit);
      case 'Area':
        return convertArea(value, fromUnit, toUnit);
      case 'Time':
        return convertTime(value, fromUnit, toUnit);
      default:
        return value;
    }
  }
}
