import 'package:estudo_bloc/bloc/client_event.dart';
import 'package:estudo_bloc/bloc/client_state.dart';
import 'package:estudo_bloc/repositories/clients_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientBloc extends Bloc<ClientEvents, ClientState> {
  final _clientRepo = ClientsRepository();

  ClientBloc() : super(ClientInitialState()) {
    on<ClientLoadEvent>((event, emit) => emit(
          ClientSuccessState(clients: _clientRepo.loadClients()),
        ));

    on<ClientAddEvent>((event, emit) => emit(
          ClientSuccessState(clients: _clientRepo.addClient(event.client)),
        ));
    on<ClientRemoveEvent>((event, emit) => emit(
          ClientSuccessState(clients: _clientRepo.removeClient(event.client)),
        ));
  }
}
