import 'package:get/get.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorController extends GetxController {
  var expression = ''.obs;
  var result = ''.obs;
  var history = <String>[].obs;
  bool _justCalculated = false;

  void onButtonPressed(String buttonText) {
    if (_justCalculated && '0123456789'.contains(buttonText)) {
      expression.value = '';
      result.value = '';
      _justCalculated = false;
    }

    switch (buttonText) {
      case 'C':
        expression.value = '';
        result.value = '';
        break;
      case 'CE':
        if (expression.value.isNotEmpty) {
          expression.value = expression.value.substring(
            0,
            expression.value.length - 1,
          );
        }
        break;
      case '+':
      case '−':
      case '×':
      case '÷':
        _addOperator(buttonText);
        break;
      case '=':
        _evaluate();
        break;
      case '%':
        _applyPercent();
        break;
      case '+/−':
        _toggleSign();
        break;
      case ',':
        expression.value += '.';
        break;
      default:
        expression.value += buttonText;
    }
  }

  void _addOperator(String op) {
    if (expression.value.isEmpty) return;

    final last = expression.value[expression.value.length - 1];
    if ('+−×÷'.contains(last)) {
      expression.value =
          expression.value.substring(0, expression.value.length - 1) + op;
    } else {
      expression.value += op;
    }
  }

  void _evaluate() {
    try {
      String exp = expression.value
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('−', '-');

      GrammarParser p = GrammarParser();
      Expression parsedExp = p.parse(exp);
      double eval = parsedExp.evaluate(EvaluationType.REAL, ContextModel());

      String formatted = eval == eval.toInt()
          ? '${eval.toInt()}'
          : eval.toString();
      result.value = formatted;

      history.add('${expression.value}=$formatted');

      _justCalculated = true;
    } catch (_) {
      result.value = 'Error';
    }
  }

  void _applyPercent() {
    try {
      final match = RegExp(
        r'(.+?)([+\-×÷])(\d+\.?\d*)$',
      ).firstMatch(expression.value);
      if (match != null) {
        final num1 = double.parse(match.group(1)!);
        final op = match.group(2)!;
        final num2 = double.parse(match.group(3)!);
        final percentValue = num1 * num2 / 100;

        final newExpression = '${match.group(1)}$op$percentValue';
        expression.value = newExpression;
      }
    } catch (_) {
      result.value = 'Error';
    }
  }

  void _toggleSign() {
    if (expression.value.isEmpty) return;

    final match = RegExp(r'(\d+\.?\d*)$').firstMatch(expression.value);
    if (match != null) {
      final token = match.group(0)!;
      final start = expression.value.length - token.length;

      double number = double.tryParse(token) ?? 0;
      number = -number;

      final formatted = number == number.toInt()
          ? number.toInt().toString()
          : number.toString();
      expression.value = expression.value.replaceRange(start, null, formatted);
    }
  }
}
