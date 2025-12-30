import 'package:fire_chat/features/home/presentation/home.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {

  HomeCubit() : super(HomeState(currentIndex: 0));

  void currentIndexChanged(int index) {
    emit(state.copyWith(currentIndex: index));
  }

}