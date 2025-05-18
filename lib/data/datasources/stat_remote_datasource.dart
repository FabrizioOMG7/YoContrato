// lib/data/datasources/stat_remote_datasource.dart
import '../models/stat_model.dart';
abstract class StatRemoteDatasource {
  Future<List<StatModel>> fetchStats();
}

class StatRemoteDatasourceImpl implements StatRemoteDatasource {
  @override
  Future<List<StatModel>> fetchStats() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const [
      StatModel(
        title: 'Total finalizados',
        count: 2,
        iconName: 'check_circle_outline',
      ),
      StatModel(
        title: 'Total en atención',
        count: 1,
        iconName: 'access_time',
      ),
      StatModel(
        title: 'Total desaprobados',
        count: 1,
        iconName: 'cancel_outlined',
      ),
      StatModel(
        title: 'Cantidad desistimiento',
        count: 0,
        iconName: 'sentiment_dissatisfied',
      ),
    ];
  }
}