// Contrato genérico para casos de uso.
abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}