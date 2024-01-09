import 'dart:math';

import 'package:estudo_bloc/bloc/client_bloc.dart';
import 'package:estudo_bloc/bloc/client_event.dart';
import 'package:estudo_bloc/bloc/client_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/client.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({super.key});

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  final clientsList = [];
  late final ClientBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = ClientBloc();
    bloc.add(ClientLoadEvent());
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  String randomName() {
    final rand = Random();
    return [
      'Maria Almeida',
      'Vinicius Silva',
      'Luis Williams',
      'Alysson Silva',
      'Bianca Mello'
    ].elementAt(rand.nextInt(4));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () {
              bloc.add(
                ClientAddEvent(
                  client: Client(nome: randomName()),
                ),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: BlocBuilder<ClientBloc, ClientState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is ClientInitialState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is ClientSuccessState) {
              final clientList = state.clients;
              return ListView.separated(
                itemCount: clientList.length,
                itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Text(clientList[index].nome.substring(0, 1)),
                    ),
                  ),
                  title: Text(clientList[index].nome),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      bloc.add(
                        ClientRemoveEvent(client: clientList[index]),
                      );
                    },
                  ),
                ),
                separatorBuilder: (_, __) => const Divider(),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
