// lib/domain/usecases/get_stats.dart
import '../../core/usecases/usecase.dart';
import '../entities/stat_entity.dart';
import '../repositories/stat_repository.dart';
class GetStats implements UseCase<List<StatEntity>, void> {
  final StatRepository repository;
  GetStats(this.repository);
  @override Future <List<StatEntity>> call([dynamic params]) async {
    return await repository.getStats();
  }
}