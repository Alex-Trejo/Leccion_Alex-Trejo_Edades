// //23.	Realice un algoritmo que permita ingresar 10 edades de personas
// para luego hallar y mostrar el % de gente mayor de edad (≥ 18) y el %
// de menores de edad.


class CalculoDeEdades {
  Map<String, double> calcularPorcentajes(List<int> edades) {
    int mayores = edades.where((edad) => edad >= 18).length;
    int total = edades.length;
    
    double porcentajeMayores = (mayores / total) * 100;
    double porcentajeMenores = ((total - mayores) / total) * 100;
    
    return {
      "mayores": porcentajeMayores,
      "menores": porcentajeMenores,
    };
  }
}
