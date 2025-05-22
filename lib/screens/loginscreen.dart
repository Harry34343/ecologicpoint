import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:a/widgets/button.dart' as button;

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _usuarioController.addListener(_verificarCampos);
    _contrasenaController.addListener(_verificarCampos);
  }

  bool _camposCompletos = false;
  void _verificarCampos() {
    final usuario = _usuarioController.text.trim();
    final password = _contrasenaController.text.trim();

    setState(() {
      _camposCompletos = usuario.isNotEmpty && password.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;
        double relWidth(double w) => screenWidth * (w / 440);
        double relHeight(double h) => screenHeight * (h / 956);

        return Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(color: const Color(0xFF355E3B)),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: SvgPicture.asset(
                      'assets/fondoX.svg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    left: relWidth(60),
                    top: relHeight(165),
                    child: SizedBox(
                      width: relWidth(321),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: relWidth(97),
                            height: relHeight(120),
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(),
                            child: SvgPicture.asset('assets/logo2.svg'),
                          ),
                          SizedBox(
                            width: relWidth(321),
                            child: Text(
                              'EcologicPoint+',
                              style: GoogleFonts.agbalumo(
                                color: const Color(0xFF355E3B),
                                decoration: TextDecoration.none,
                                fontSize: relWidth(48),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: relHeight(419),
                    child: Container(
                      width: screenWidth,
                      height: relHeight(537),
                      padding: EdgeInsets.only(
                        left: relWidth(24),
                        right: relWidth(24),
                        bottom: relHeight(48),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        spacing: relHeight(32),
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Stack(
                              children: [
                                SizedBox(
                                  width: relWidth(392),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "¡Bienvenido!",
                                        style: GoogleFonts.agbalumo(
                                          fontSize: relWidth(32),
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromRGBO(31, 31, 31, 1),
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                      Text(
                                        "Ingresa tus datos para continuar",
                                        style: GoogleFonts.poppins(
                                          fontSize: relWidth(16),
                                          fontWeight: FontWeight.w400,
                                          decoration: TextDecoration.none,
                                          color: Color.fromRGBO(
                                            95,
                                            105,
                                            100,
                                            1,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  top: relHeight(6),
                                  child: button.CustomIconButton(
                                    isActivated: true,
                                    icon: Icons.arrow_back,
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/welcome');
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              spacing: relHeight(24),
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: relHeight(4),
                                    children: [
                                      SizedBox(
                                        width: relWidth(392),
                                        child: Text(
                                          'Usuario',
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xFF1F1F1F),
                                            fontSize: relWidth(16),

                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: relWidth(16),
                                          vertical: relHeight(8),
                                        ),
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFFE4E9E4),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              24,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.person,
                                              color:
                                                  _usuarioController
                                                          .text
                                                          .isEmpty
                                                      ? const Color.fromRGBO(
                                                        158,
                                                        179,
                                                        169,
                                                        1,
                                                      )
                                                      : const Color.fromRGBO(
                                                        53,
                                                        94,
                                                        59,
                                                        1,
                                                      ),
                                              size: relWidth(20),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Material(
                                                color: Colors.transparent,
                                                child: TextField(
                                                  controller:
                                                      _usuarioController,
                                                  onChanged: (_) {
                                                    setState(
                                                      () {},
                                                    ); // Para actualizar el color del icono
                                                  },
                                                  style: GoogleFonts.poppins(
                                                    fontSize: relWidth(16),
                                                    fontWeight: FontWeight.w400,
                                                    color: const Color(
                                                      0xFF1F1F1F,
                                                    ),
                                                  ),
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    hintText:
                                                        'Introduce tu usuario',
                                                    hintStyle: GoogleFonts.poppins(
                                                      fontSize: relWidth(16),
                                                      color:
                                                          const Color.fromRGBO(
                                                            158,
                                                            179,
                                                            169,
                                                            1,
                                                          ),
                                                    ),
                                                    border: InputBorder.none,
                                                  ),
                                                  cursorColor:
                                                      const Color.fromRGBO(
                                                        53,
                                                        94,
                                                        59,
                                                        1,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    spacing: relHeight(8),
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          spacing: relHeight(4),
                                          children: [
                                            SizedBox(
                                              width: relWidth(392),
                                              child: Text(
                                                'Contraseña',
                                                style: GoogleFonts.poppins(
                                                  color: const Color(
                                                    0xFF1F1F1F,
                                                  ),
                                                  fontSize: 16,

                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.symmetric(
                                                horizontal: relWidth(16),
                                                vertical: relHeight(8),
                                              ),
                                              decoration: ShapeDecoration(
                                                color: const Color(0xFFE4E9E4),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(24),
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.lock,
                                                    color:
                                                        _contrasenaController
                                                                .text
                                                                .isEmpty
                                                            ? const Color.fromRGBO(
                                                              158,
                                                              179,
                                                              169,
                                                              1,
                                                            )
                                                            : const Color.fromRGBO(
                                                              53,
                                                              94,
                                                              59,
                                                              1,
                                                            ),
                                                    size: relWidth(20),
                                                  ),
                                                  const SizedBox(width: 12),
                                                  Expanded(
                                                    child: Material(
                                                      color: Colors.transparent,
                                                      child: TextField(
                                                        controller:
                                                            _contrasenaController,
                                                        onChanged: (_) {
                                                          setState(
                                                            () {},
                                                          ); // Para actualizar el color del icono
                                                        },
                                                        style:
                                                            GoogleFonts.poppins(
                                                              fontSize:
                                                                  relWidth(16),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  const Color(
                                                                    0xFF1F1F1F,
                                                                  ),
                                                            ),
                                                        decoration: InputDecoration(
                                                          isDense: true,
                                                          hintText:
                                                              'Introduce tu contraseña',
                                                          hintStyle:
                                                              GoogleFonts.poppins(
                                                                fontSize:
                                                                    relWidth(
                                                                      16,
                                                                    ),
                                                                color:
                                                                    const Color.fromRGBO(
                                                                      158,
                                                                      179,
                                                                      169,
                                                                      1,
                                                                    ),
                                                              ),
                                                          border:
                                                              InputBorder.none,
                                                        ),
                                                        cursorColor:
                                                            const Color.fromRGBO(
                                                              53,
                                                              94,
                                                              59,
                                                              1,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.remove_red_eye,
                                                    color:
                                                        _contrasenaController
                                                                .text
                                                                .isEmpty
                                                            ? const Color.fromRGBO(
                                                              158,
                                                              179,
                                                              169,
                                                              1,
                                                            )
                                                            : const Color.fromRGBO(
                                                              53,
                                                              94,
                                                              59,
                                                              1,
                                                            ),
                                                    size: relWidth(20),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: relWidth(16),
                                          vertical: relWidth(8),
                                        ),
                                        decoration: ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              24,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          spacing: relHeight(12),
                                          children: [
                                            Text(
                                              '¿Olvidaste tu contraseña?',
                                              style: GoogleFonts.poppins(
                                                color: const Color(0xFF355E3B),
                                                fontSize: 14,

                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: relHeight(800)), // manual
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: relWidth(16),
                          ),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: relWidth(16),
                              vertical: relHeight(8),
                            ),
                            child: button.FilledButton(
                              isActivated: _camposCompletos,
                              text: 'Iniciar sesión',
                              onPressed: () {
                                if (_camposCompletos) {
                                  Navigator.pushNamed(context, '/home');
                                }
                              },
                            ), // El botón se desactiva visualmente con isActivated
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '¿Aún no tienes una cuenta?',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF1F1F1F),
                                  fontSize: relWidth(
                                    14,
                                  ), // Removed invalid parameter

                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: relWidth(16),
                                ),
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                                child: button.CustomTextButton(
                                  isActivated: true,
                                  text: 'Registrate ahora',
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/createacc');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
