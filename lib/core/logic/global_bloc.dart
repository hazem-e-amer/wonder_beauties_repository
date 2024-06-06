import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wonder_beauties/configure_di.dart';
import 'package:wonder_beauties/core/app_store/app_store.dart';

part 'global_event.dart';
part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalBloc()
      : super(GlobalState.initial(
            languageCode: getIt<AppStore>().selectedLanguageCode,
            isDarkTheme: getIt<AppStore>().isDarkMode)) {
    on<LanguageChanged>((event, emit) {
      emit(state.copyWith(languageCode: event.language));
    });

    on<ThemeChanged>((event, emit) {
      emit(state.copyWith(isDarkTheme: event.isDark));
      if (event.isDark) {
        getIt<AppStore>().setDarkMode(2);
      } else {
        getIt<AppStore>().setDarkMode(1);
      }
    });
  }
}
