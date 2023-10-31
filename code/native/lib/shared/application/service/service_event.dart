part of 'service_bloc.dart';

@immutable
sealed class ServiceEvent extends Equatable {}

class LoadServices extends ServiceEvent {
  final PocketBase pocketbase;

  LoadServices({required this.pocketbase});

  @override
  List<Object?> get props => [pocketbase];
}
