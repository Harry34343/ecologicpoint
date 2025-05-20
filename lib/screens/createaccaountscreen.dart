import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:a/widgets/button.dart' as button;

class CreateAcc extends StatefulWidget {
  @override
  _CreateAccState createState() => _CreateAccState();
}

class _CreateAccState extends State<CreateAcc> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _ccontrasenaController = TextEditingController();
  void initState() {
    super.initState();
    _usuarioController.addListener(_verificarCampos);
    _contrasenaController.addListener(_verificarCampos);
    _mailController.addListener(_verificarCampos);
    _ccontrasenaController.addListener(_verificarCampos);
  }

  bool _camposCompletos = false;
  void _verificarCampos() {
    final usuario = _usuarioController.text.trim();
    final password = _contrasenaController.text.trim();
    final cpassword = _ccontrasenaController.text.trim();
    final mail = _mailController.text.trim();

    setState(() {
      _camposCompletos =
          usuario.isNotEmpty &&
          password.isNotEmpty &&
          cpassword.isNotEmpty &&
          mail.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenwidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;
        double relWidth(double w) => screenwidth * (w / 440);
        double relHeight(double h) => screenHeight * (h / 956);

        return Column(
          children: [
            Container(
              width: screenwidth,
              height: relHeight(956),
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
                    top: relHeight(123),
                    child: Container(
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
                            child: SvgPicture.asset(
                              'assets/logo2.svg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: relWidth(0),
                    top: relHeight(281),
                    child: Container(
                      width: screenwidth,
                      height: relHeight(675),
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
                          Container(
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
                                        "Crea tu cuenta",
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
                                  left: relWidth(0),
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
                          Container(
                            width: double.infinity,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              spacing: relHeight(24),
                              children: [
                                Container(
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
                                Container(
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
                                          'Correo ',
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
                                              Icons.mail,
                                              color:
                                                  _mailController.text.isEmpty
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
                                                  controller: _mailController,
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
                                                        'Introduce tu correo',
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
                                Container(
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
                                          'Contraseña',
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xFF1F1F1F),
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
                                            borderRadius: BorderRadius.circular(
                                              24,
                                            ),
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
                                                        'Introduce tu contraseña',
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
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: relHeight(4),
                                    children: [
                                      SizedBox(
                                        width: relWidth(296),
                                        child: Text(
                                          'Confirmar Contraseña',
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xFF1F1F1F),
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
                                            borderRadius: BorderRadius.circular(
                                              24,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.lock,
                                              color:
                                                  _ccontrasenaController
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
                                                      _ccontrasenaController,
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
                                                        'Confirma tu contraseña',
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
                                            Icon(
                                              Icons.remove_red_eye,
                                              color:
                                                  _ccontrasenaController
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
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: relHeight(12),
                                children: [
                                  Container(
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: relWidth(16),
                                        vertical: relHeight(8),
                                      ),
                                      child: button.FilledButton(
                                        isActivated: _camposCompletos,
                                        text: 'Crear cuenta',
                                        onPressed: () {
                                          if (_camposCompletos) {
                                            Navigator.pushNamed(
                                              context,
                                              '/planta',
                                            );
                                          }
                                        },
                                      ), // El botón se desactiva visualmente con isActivated
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: relWidth(12),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '¿Ya tienes una cuenta?',
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xFF1F1F1F),
                                            fontSize: relWidth(14),

                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: relWidth(16),
                                            vertical: relHeight(8),
                                          ),
                                          decoration: ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(24),
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
                                              button.CustomTextButton(
                                                isActivated: true,
                                                text: 'Iniciar sesión',
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    '/home',
                                                  );
                                                },
                                              ), // El botón se desactiva visualmente con isActivated
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
                        ],
                      ),
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
