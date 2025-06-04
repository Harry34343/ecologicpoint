import 'package:a/screens/createaccaountscreen.dart';
import 'package:a/screens/mapa(testNOoficial).dart';
import 'package:a/screens/menuplanta.dart';
import 'package:a/screens/welcomescreen.dart';
import 'package:a/screens/tipsscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart'; // debugPaintSizeEnabled no es común dejarlo así para producción
import 'package:a/screens/loginscreen.dart';
import 'package:a/screens/armarioscreen.dart';
import 'package:a/screens/homescreen.dart';
import 'package:a/screens/challengesscreen.dart';
import 'package:provider/provider.dart';
import 'package:a/providers/challenges_filter_provider.dart';
import 'package:a/screens/profilescreen.dart'; // Ajusta según tu estructura
import 'package:a/screens/mapa(testNOoficial).dart';
import 'package:a/screens/tiendascreen.dart';

void main() {
  // debugPaintSizeEnabled = false; // Es mejor quitar esto para builds normales o ponerlo condicionalmente
  runApp(
    MultiProvider(
      // PASO 1: Envolver la App con MultiProvider
      providers: [
        ChangeNotifierProvider(create: (_) => ChallengesFilterProvider()),
        // Puedes añadir más providers aquí en el futuro
        // ChangeNotifierProvider(create: (_) => OtroProvider()),
      ],
      child: const EcologicPoint(), // Tu widget App principal
    ),
  );
}

class EcologicPoint extends StatelessWidget {
  const EcologicPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        // Considera si realmente quieres un tema oscuro por defecto para toda la app
        // o si esto era solo para una pantalla específica.
        // Los colores de EcologicPoint son más claros.
        // scaffoldBackgroundColor: Color.fromARGB(255, 18, 32, 47), // Esto es un color oscuro
        scaffoldBackgroundColor: const Color(
          0xFFF7F6EA,
        ), // Color de fondo más claro de EcologicPoint
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF355E3B),
        ).copyWith(
          // Ajusta los colores del tema si es necesario
          primary: const Color(0xFF355E3B), // Verde principal
          secondary: const Color(0xFFA8C686), // Verde más claro
          background: const Color(0xFFF7F6EA), // Fondo
        ),
        appBarTheme: const AppBarTheme(
          // Para consistencia en AppBars
          backgroundColor: Color(0xFFF7F6EA),
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xFF1F1F1F)),
          titleTextStyle: TextStyle(
            fontFamily: 'Poppins', // O la fuente que uses para títulos
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Color(0xFF1F1F1F),
          ),
        ), // Fuente por defecto para la app
      ),
      // home: Scaffold(body: LogIn()), // Se ignora si initialRoute está definido
      initialRoute: '/welcome', // Define cuál es la primera pantalla al abrir
      routes: {
        '/welcome':
            (context) =>
                const WelcomePage(), // Asegúrate que WelcomePage sea const si no cambia
        '/login':
            (context) =>
                const LogIn(), // Asegúrate que LogIn sea const si no cambia
        '/home': (context) => const HomeScreen(),
        '/createacc':
            (context) => const CreateAcc(), // Asumo que es CreateAccountScreen
        '/planta': (context) => const Plant1(),
        '/armario': (context) => const ArmarioScreen(),
        '/tips': (context) => const TipsScreen(),
        '/retos': (context) => const ChallengesScreen(),
        '/perfil': (context) => const ProfileScreen(),
        '/tienda': (context) => const BoutiqueScreen(),
      },
    );
  }
}
