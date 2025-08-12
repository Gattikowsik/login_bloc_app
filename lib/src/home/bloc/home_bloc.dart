import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login_bloc_app/src/home/models/photo_model.dart';
import 'package:login_bloc_app/src/home/repository/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _homeRepository;

  HomeBloc({required HomeRepository homeRepository})
      : _homeRepository = homeRepository,
        super(const HomeState()) {
    on<FetchHomeData>(_onFetchHomeData);
  }

  Future<void> _onFetchHomeData(
      FetchHomeData event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final photos = await _homeRepository.fetchPhotos();
      emit(state.copyWith(status: HomeStatus.success, photos: photos));
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.failure, error: e.toString()));
    }
  }
}