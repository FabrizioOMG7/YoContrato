// lib/presentation/bloc/stat_cubit.dart
import 'package:bloc/bloc.dart';
import '../../../domain/entities/stat_entity.dart';
import '../../../domain/usecases/get_stats.dart';

// Estados mejor estructurados
abstract class StatState {
  final List<StatEntity>? stats;
  final bool loading;
  
  const StatState({this.stats, required this.loading});
}

class StatInitial extends StatState {
  const StatInitial() : super(stats: null, loading: false);
}

class StatsLoading extends StatState {
  const StatsLoading() : super(stats: null, loading: true);
}

class StatsLoaded extends StatState {
  @override
  final List<StatEntity> stats;
  
  @override // Anotación necesaria
  const StatsLoaded(this.stats) : super(stats: stats, loading: false);
}

class StatCubit extends Cubit<StatState> {
  final GetStats getStats;

  StatCubit(this.getStats) : super(const StatInitial());

  Future<void> loadStats() async {
    emit(const StatsLoading());
    try {
      // Corrección: Agregar parámetro null requerido
      final stats = await getStats.call(null); 
      emit(StatsLoaded(stats));
    } catch (e) {
      emit(const StatsLoaded([])); 
    }
  }
}