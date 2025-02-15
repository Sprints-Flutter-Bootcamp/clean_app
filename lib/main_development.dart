import 'package:clean_app/app/app.dart';
import 'package:clean_app/bootstrap.dart';
import 'package:clean_app/injection_container.dart';

void main() {
  init();
  bootstrap(() => const App());
}
