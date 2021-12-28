import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_socket_log_client/domain/repsitory/home_repository.dart';
import 'package:flutter_socket_log_client/ui/screens/home/bloc/home_event.dart';
import 'package:flutter_socket_log_client/ui/screens/home/bloc/home_state.dart';
import 'package:flutter_socket_log_client/ui/screens/home/bloc/ui_message.dart';
import 'package:flutter_socket_log_client/util/fake_data.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _homeRepository;
  final BehaviorSubject<UserMessage> _uiMessageSubject = BehaviorSubject();

  HomeBloc(this._homeRepository) : super(LoadingState()) {
    handleOutsideBlocEvents();
    handleInternalBlocEvents();
    observeStates();

    // if ip not set, show dialog
    _homeRepository.appBarData.then((appBarData) {
      if (appBarData.ip.isEmpty) {
        add(ShowInputIpDialogEvent());
      }
    });
  }

  Stream<UserMessage> get observeMessages => MergeStream([
        _uiMessageSubject.stream,
        _homeRepository.observeUserMessages,
      ]);

  void handleOutsideBlocEvents() {
    on<UpdateAppSettingsEvent>((event, emit) async {
      await _homeRepository.updateAppNameAndIp(
        event.ip,
        event.appName,
        event.shouldClearSettings,
      );
    });

    on<ToggleConnectionStateEvent>(
      (event, emit) {
        _homeRepository.toggleConnection();
      },
      transformer: droppable(),
    );

    on<ShowInputIpDialogEvent>(
      (event, emit) async {
        AppBarData appBarData = await _homeRepository.appBarData;
        emit(EmptyState());
        emit(ShowInputIpDialogState(
          appName: appBarData.appName,
          ip: appBarData.ip,
        ));
      },
      transformer: droppable(),
    );

    on<ShowAddTabDialogEvent>((event, emit) async {
      // fake dialogs for testing
      emit(EmptyState());
      emit(ShowAddTabDialogState(
        allLogLevels: fakeLogLevels,
        allLogTags: fakeLogTags,
      ));
      return;

      if (_homeRepository.allLogLevels == null) {
        _uiMessageSubject
            .add(UserMessage.error('At least one log should be received to add new tab'));
      } else {
        emit(EmptyState());
        emit(ShowAddTabDialogState(
          allLogLevels: _homeRepository.allLogLevels!,
          allLogTags: _homeRepository.allLogTags!,
        ));
      }
    });

    on<AddNewTabEvent>((event, emit) async {
      emit(EmptyState());
      emit(TabsState(await _homeRepository.saveTab(
        event.tabName,
        event.selectedLogTags,
        event.selectedLogLevels,
      )));
    });
  }

  void handleInternalBlocEvents() {
    on<ConnectionToggledEvent>((event, emit) {
      emit(EmptyState());
      emit(LogConnectionState(event.isConnected));
    });

    on<AppBarDataReceivedEvent>((event, emit) {
      emit(EmptyState());
      emit(
        AppBarDataState(
          appName: event.appName,
          ip: event.ip,
        ),
      );
    });
  }

  void observeStates() {
    _homeRepository.observeAppBarData.listen((appBarData) {
      add(AppBarDataReceivedEvent(appBarData.appName, appBarData.ip));
    });

    _homeRepository.observeSocketConnectionState.listen((bool isConnected) {
      add(ConnectionToggledEvent(isConnected));
    });
  }
}
