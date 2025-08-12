part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.photos = const <Photo>[],
    this.error = '',
  });

  final HomeStatus status;
  final List<Photo> photos;
  final String error;

  HomeState copyWith({
    HomeStatus? status,
    List<Photo>? photos,
    String? error,
  }) {
    return HomeState(
      status: status ?? this.status,
      photos: photos ?? this.photos,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [status, photos, error];
}