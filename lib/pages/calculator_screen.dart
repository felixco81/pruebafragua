import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tip_calculator_provider.dart';
import '../data/propinas_data .dart';

class CalculatorScreen extends StatelessWidget {
  CalculatorScreen({super.key});
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _customController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final tipCalc = Provider.of<TipCalculator>(context);

    final monto = double.tryParse(_amountController.text) ?? 0;
    final tip = tipCalc.tip.toStringAsFixed(2);
    final tipPercentage = tipCalc.percentage;

    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora de propinas')),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        color: const Color.fromARGB(255, 236, 236, 236),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white, // color del contenedor
            borderRadius: BorderRadius.circular(16), // bordes redondeados
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // color sombra
                blurRadius: 8, // suavidad
                offset: const Offset(0, 4), // posición de la sombra
              ),
            ],
          ),

          child: Column(
            children: [
               const SizedBox(height: 20),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Total',
                  hintText: 'Ingresa el total de la cuenta', 
                   border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
              ),
               const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  ...listPropinas.map((tip) {
                    return OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: tip == tipPercentage
                            ? const Color.fromARGB(220, 23, 2, 184)
                            : Colors.white,
                        foregroundColor: tip == tipPercentage
                            ? const Color.fromARGB(255, 255, 255, 255)
                            : const Color.fromARGB(255, 0, 0, 0),
                      ),
                      onPressed: () {
                        tipCalc.setPercentage(tip.toDouble(), custom: false);
                        _customController.clear();
                      },
                      child: Text(
                        tip.toString() + '%',
                        style: TextStyle(fontSize: 13),
                      ),
                    );
                  }),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: 0 == tipPercentage
                          ? const Color.fromARGB(220, 23, 2, 184)
                          : Colors.white,
                      foregroundColor: 0 == tipPercentage
                          ? const Color.fromARGB(255, 255, 255, 255)
                          : const Color.fromARGB(255, 0, 0, 0),
                    ),
                    onPressed: () {
                      tipCalc.setPercentage(0, custom: true);
                    },
                    child: Text('Otro', style: TextStyle(fontSize: 13)),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Custom percentage input
              if (tipCalc.isCustom) // 👈 ahora dependemos de isCustom
                TextField(
                  controller: _customController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Ingres el %',
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                  onChanged: (val) {
                    final pct = double.tryParse(val) ?? 0;
                    tipCalc.setPercentage(
                      pct,
                      custom: true,
                    ); // mantiene el estado
                  },
                ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  
                  onPressed: () {
                    final amount = double.tryParse(_amountController.text) ?? 0;
                    tipCalc.calculate(amount);
                  },
                  child: const Text('Calcular propina'),
                ),
              ),

              const SizedBox(height: 20),
              Row(
                spacing: 12,
                children: [
                  Text('Pagado', style: TextStyle(fontSize: 24)),
                  const Spacer(),
                  Text(monto.toString(), style: TextStyle(fontSize: 30)),
                ],
              ),
              Row(
                spacing: 12,
                children: [
                  Text('Propina', style: TextStyle(fontSize: 24)),
                  const Spacer(),
                  Text(
                    tipCalc.error ? "Error !!" : tipCalc.tip.toString(),
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
