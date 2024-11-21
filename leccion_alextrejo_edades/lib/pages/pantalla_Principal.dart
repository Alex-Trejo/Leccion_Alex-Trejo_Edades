import 'package:flutter/material.dart';
import '../logica/calculoEdades.dart';

class PantallaPrincipal extends StatefulWidget {
  @override
  _PantallaPrincipalState createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  final CalculoDeEdades _calculoDeEdades = CalculoDeEdades();

  final List<TextEditingController> _edadControllers =
      List.generate(10, (_) => TextEditingController());

  String _resultado = '';

  void _calcular() {
    List<int> edades = [];

    for (var controller in _edadControllers) {
      String input = controller.text.trim();
      int? edad = int.tryParse(input);

      // Validaciones
      if (input.isEmpty || edad == null || edad <= 0) {
        setState(() {
          _resultado =
              'Por favor, ingresa edades válidas (números enteros positivos mayores a 0).';
        });
        return;
      }
      edades.add(edad);
    }

    // Calcular porcentajes usando la lógica de negocio
    final resultados = _calculoDeEdades.calcularPorcentajes(edades);

    setState(() {
      _resultado =
          'Mayores de edad: ${resultados["mayores"]!.toStringAsFixed(2)}%\n'
          'Menores de edad: ${resultados["menores"]!.toStringAsFixed(2)}%';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.calculate),
            SizedBox(width: 8),
            Text('Cálculo de Edades'),
          ],
        ),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Título
            Row(
              children: [
                Icon(Icons.edit, color: Colors.blue.shade700, size: 28),
                SizedBox(width: 8),
                Text(
                  'Ingresa las edades:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Campos para ingresar las edades
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: _edadControllers[index],
                      decoration: InputDecoration(
                        labelText: 'Edad ${index + 1}',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.blue.shade50,
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        // Validación en tiempo real
                        if (int.tryParse(value) == null && value.isNotEmpty) {
                          setState(() {
                            _resultado = 'Por favor, solo ingresa números.';
                          });
                        }
                      },
                    ),
                  );
                },
              ),
            ),

            // Botón para calcular
            SizedBox(
              height: 50,
              child: ElevatedButton.icon(
                onPressed: _calcular,
                icon: Icon(Icons.check_circle_outline),
                label: Text(
                  'Calcular Porcentajes',
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
              ),
            ),
            SizedBox(height: 16),

            // Mostrar el resultado
            Container(
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200, width: 1.5),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue.shade800, size: 28),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _resultado,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue.shade800,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
