// lib/providers/challenges_filter_provider.dart
import 'package:flutter/foundation.dart';
// Asegúrate que la ruta a ChallengScreen o donde definas ChallengeData sea correcta
// Si ChallengeData está en challengesscreen.dart y este provider está en una carpeta hermana:
import '../screens/challengesscreen.dart'; // Ajusta esta ruta si es necesario


class ChallengesFilterProvider with ChangeNotifier {
  // La lista initialChallengesData debería definirse aquí o cargarse desde una fuente de datos.
  // Por simplicidad, asumimos que está disponible (definida en challengesscreen.dart por ahora)
  final List<ChallengeData> _allChallenges = List.from(initialChallengesData);

  int _selectedTabIndex = 0;
  int get selectedTabIndex => _selectedTabIndex;

  List<ChallengeData> get filteredChallenges {
    if (_selectedTabIndex == 1) { // Activos
      return _allChallenges.where((c) => c.currentProgress > 0 && c.currentProgress < c.totalProgress).toList();
    } else if (_selectedTabIndex == 2) { // Completados
      return _allChallenges.where((c) => c.currentProgress == c.totalProgress && c.totalProgress > 0).toList();
    } else { // Todos
      return _allChallenges;
    }
  }

  void selectTab(int index) {
    if (_selectedTabIndex != index) {
      _selectedTabIndex = index;
      notifyListeners();
    }
  }

  // Ejemplo de cómo podrías actualizar un reto (necesitarías identificarlo por un ID único en un caso real)
  void updateChallengeProgress(String title, int newProgress) {
    final index = _allChallenges.indexWhere((c) => c.title == title);
    if (index != -1) {
      // Esta es una forma de actualizar. Si ChallengeData fuera una clase con métodos, sería diferente.
      // Aquí estamos creando una nueva instancia para reemplazar la antigua.
      final oldChallenge = _allChallenges[index];
      _allChallenges[index] = ChallengeData(
        iconAssetPath: oldChallenge.iconAssetPath,
        title: oldChallenge.title,
        description: oldChallenge.description,
        points: oldChallenge.points,
        currentProgress: newProgress, // El nuevo progreso
        totalProgress: oldChallenge.totalProgress,
        isSvg: oldChallenge.isSvg,
      );
      notifyListeners();
    }
  }
}