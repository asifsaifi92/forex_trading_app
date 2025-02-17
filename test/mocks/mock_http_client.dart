import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([http.Client])  // ✅ Generates a mock for http.Client
void main() {}
