// lib/data/repositories/stat_repository_impl.dart
import '../../domain/entities/stat_entity.dart';
import '../../domain/repositories/stat_repository.dart';
import '../datasources/stat_remote_datasource.dart';
class StatRepositoryImpl implements StatRepository {
  final StatRemoteDatasource remote;
  StatRepositoryImpl(this.remote);
  @override Future<List<StatEntity>> getStats() async {
    return await remote.fetchStats();
  }
}