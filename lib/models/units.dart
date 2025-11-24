class Units {
  static const Map<String, double> length = {
    'Meter': 1.0,
    'Kilometer': 0.001,
    'Centimeter': 100.0,
    'Millimeter': 1000.0,
    'Mile': 0.000621371,
    'Yard': 1.09361,
    'Foot': 3.28084,
    'Inch': 39.3701,
  };

  static const Map<String, double> weight = {
    'Gram': 1.0,
    'Kilogram': 0.001,
    'Milligram': 1000.0,
    'Metric Ton': 0.000001,
    'Pound': 0.00220462,
    'Ounce': 0.035274,
    'Ton': 0.0000011023,
  };

  static const List<String> temperature = ['Celsius', 'Fahrenheit', 'Kelvin'];

  static const Map<String, double> volume = {
    'Liter': 1.0,
    'Milliliter': 1000.0,
    'Cubic Meter': 0.001,
    'Gallon': 0.264172,
    'Quart': 1.05669,
    'Pint': 2.11338,
    'Cup': 4.22675,
    'Fluid Ounce': 33.814,
  };

  static const Map<String, double> area = {
    'Square Meter': 1.0,
    'Square Kilometer': 0.000001,
    'Square Centimeter': 10000.0,
    'Hectare': 0.0001,
    'Square Mile': 3.861e-7,
    'Square Yard': 1.19599,
    'Square Foot': 10.7639,
    'Acre': 0.000247105,
  };

  static const Map<String, double> time = {
    'Second': 1.0,
    'Millisecond': 1000.0,
    'Minute': 0.0166667,
    'Hour': 0.000277778,
    'Day': 0.0000115741,
    'Week': 0.00000165344,
    'Month': 3.8052e-7,
    'Year': 3.171e-8,
  };
}
