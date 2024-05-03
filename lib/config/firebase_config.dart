import 'package:chatsphere/firebase_options.dart';
import 'package:chatsphere/presentation/helpers/auth_service.dart';
import 'package:chatsphere/presentation/helpers/database_service.dart';
import 'package:chatsphere/presentation/helpers/storage_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

Future<void> setupFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> registerService() async {
  final GetIt getIt = GetIt.instance;
  getIt.registerSingleton<AuthService>(
    AuthService(),
  );
  getIt.registerSingleton<DatabaseService>(
    DatabaseService(),
  );
  getIt.registerSingleton<StorageService>(
    StorageService(),
  );
}
