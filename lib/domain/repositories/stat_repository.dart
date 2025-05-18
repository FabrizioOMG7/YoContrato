import '../entities/stat_entity.dart';

// Interfaz que define cómo obtener StatEntity.
abstract class StatRepository {
  Future<List<StatEntity>> getStats();
}