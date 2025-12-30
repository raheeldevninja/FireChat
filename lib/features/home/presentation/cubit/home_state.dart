part of 'home_cubit.dart';

class HomeState extends Equatable {

  final int currentIndex;

  const HomeState({required this.currentIndex});

  HomeState copyWith({int? currentIndex}) {
    return HomeState(currentIndex: currentIndex ?? this.currentIndex);
  }

  @override
  List<Object?> get props => [currentIndex];

}