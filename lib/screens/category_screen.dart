import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/units.dart';
import '../utils/conversions.dart';

class CategoryScreen extends StatefulWidget {
  final String categoryName;
  final Color color;

  const CategoryScreen({
    super.key,
    required this.categoryName,
    required this.color,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();

  late List<String> _units;
  late String _fromUnit;
  late String _toUnit;

  bool _isFromFieldActive = true;

  @override
  void initState() {
    super.initState();
    _initializeUnits();
    _fromController.text = '1';
    _updateConversion(true);
  }

  void _initializeUnits() {
    switch (widget.categoryName) {
      case 'Length':
        _units = Units.length.keys.toList();
        break;
      case 'Weight':
        _units = Units.weight.keys.toList();
        break;
      case 'Temperature':
        _units = Units.temperature;
        break;
      case 'Volume':
        _units = Units.volume.keys.toList();
        break;
      case 'Area':
        _units = Units.area.keys.toList();
        break;
      case 'Time':
        _units = Units.time.keys.toList();
        break;
      default:
        _units = [];
    }
    _fromUnit = _units.first;
    _toUnit = _units.length > 1 ? _units[1] : _units.first;
  }

  void _updateConversion(bool fromInput) {
    setState(() {
      _isFromFieldActive = fromInput;

      if (fromInput) {
        final value = double.tryParse(_fromController.text);
        if (value != null) {
          final result = Conversions.convert(
            widget.categoryName,
            value,
            _fromUnit,
            _toUnit,
          );
          _toController.text = _formatResult(result);
        } else {
          _toController.text = '';
        }
      } else {
        final value = double.tryParse(_toController.text);
        if (value != null) {
          final result = Conversions.convert(
            widget.categoryName,
            value,
            _toUnit,
            _fromUnit,
          );
          _fromController.text = _formatResult(result);
        } else {
          _fromController.text = '';
        }
      }
    });
  }

  String _formatResult(double value) {
    if (value.abs() < 0.0001 && value != 0) {
      return value.toStringAsExponential(4);
    }
    if (value == value.roundToDouble()) {
      return value.toStringAsFixed(0);
    }
    String result = value.toStringAsFixed(6);
    result = result.replaceAll(RegExp(r'0+$'), '');
    result = result.replaceAll(RegExp(r'\.$'), '');
    return result;
  }

  void _swapUnits() {
    setState(() {
      final tempUnit = _fromUnit;
      _fromUnit = _toUnit;
      _toUnit = tempUnit;

      final tempText = _fromController.text;
      _fromController.text = _toController.text;
      _toController.text = tempText;
    });
  }

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1F2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1F2E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.categoryName,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              _buildConversionCard(
                controller: _fromController,
                selectedUnit: _fromUnit,
                isActive: _isFromFieldActive,
                onChanged: (value) => _updateConversion(true),
                onUnitChanged: (newUnit) {
                  setState(() {
                    _fromUnit = newUnit!;
                    _updateConversion(true);
                  });
                },
              ),

              const SizedBox(height: 20),

              GestureDetector(
                onTap: _swapUnits,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: widget.color,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.swap_vert,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              _buildConversionCard(
                controller: _toController,
                selectedUnit: _toUnit,
                isActive: !_isFromFieldActive,
                onChanged: (value) => _updateConversion(false),
                onUnitChanged: (newUnit) {
                  setState(() {
                    _toUnit = newUnit!;
                    _updateConversion(true);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConversionCard({
    required TextEditingController controller,
    required String selectedUnit,
    required bool isActive,
    required Function(String) onChanged,
    required Function(String?) onUnitChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2F3E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isActive ? widget.color : Colors.transparent,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Unit Dropdown
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1F2E),
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButton<String>(
              value: selectedUnit,
              dropdownColor: const Color(0xFF2A2F3E),
              underline: const SizedBox(),
              isExpanded: true,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              icon: const Icon(Icons.arrow_drop_down, color: Colors.white70),
              items: _units.map((String unit) {
                return DropdownMenuItem<String>(value: unit, child: Text(unit));
              }).toList(),
              onChanged: onUnitChanged,
            ),
          ),

          const SizedBox(height: 16),

          // Value Input
          TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\-?\d*\.?\d*')),
            ],
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '0',
              hintStyle: TextStyle(
                color: Colors.white30,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
