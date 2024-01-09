import '../models/client.dart';

abstract class ClientEvents {}

class ClientLoadEvent extends ClientEvents {}

class ClientAddAllEvent extends ClientEvents {
  Client client;

  ClientAddAllEvent({
    required this.client,
  });
}

class ClientAddEvent extends ClientEvents {
  Client client;

  ClientAddEvent({
    required this.client,
  });
}

class ClientRemoveEvent extends ClientEvents {
  Client client;

  ClientRemoveEvent({
    required this.client,
  });
}

class ClientRemoveAllEvent extends ClientEvents {
  Client client;

  ClientRemoveAllEvent({
    required this.client,
  });
}
