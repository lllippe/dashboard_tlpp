import 'dart:async';
import 'package:dashboard_tlpp/screens/common/error_dialog.dart';
import 'package:dashboard_tlpp/screens/common/exception_dialog.dart';
import 'package:dashboard_tlpp/services/auth_service.dart';
import 'package:dashboard_tlpp/theme/app_colors.dart';
import 'package:dashboard_tlpp/utils/breakpoints.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}): super (key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   bool _isHovering = true;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _usuarioController = TextEditingController();
  final AuthService authService = AuthService();
  bool _passwordVsible = false;
  bool loginError = false;

  @override
  Widget build(BuildContext context) {
    if(!isMobile(context)) {
      double screenWidth = MediaQuery.of(context).size.width;
      double screenHeight = MediaQuery.of(context).size.height;
      return Scaffold(
        body: Container(
              height: screenHeight,
              width: screenWidth,
              decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background_desktop.png'),
                fit: BoxFit.cover
              )
            ),
            child: SingleChildScrollView(
              child: Row(
                children: [
                  SizedBox(
                    width: screenWidth * 0.5,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 60.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 69.0, left: 61),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset('assets/images/Logo_fr.png'),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text('FRPelissari', 
                                  style: GoogleFonts.inter(
                                    color: AppColors.colorWhite,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 69.0, left: 61),
                            child: Text('Dashboard TLPP', 
                              style: GoogleFonts.inter(
                                color: AppColors.colorWhite,
                                fontWeight: FontWeight.bold,
                                fontSize: 60,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 69.0, left: 61),
                            child: Text('Seja bem vindo ao Dashboard financeiro em TLPP.', 
                              style: GoogleFonts.inter(
                                color: AppColors.colorWhite,
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0, left: 61),
                            child: Text('Projeto construído utilizando TLPP como backend, '
                                'conectando diretamente ao Protheus e como frontend, Flutter.', 
                              style: GoogleFonts.inter(
                                color: AppColors.colorWhite,
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40.0, left: 61),
                            child: Text('Deixem seus comentários!', 
                              style: GoogleFonts.inter(
                                color: AppColors.colorWhite,
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.3, left: screenWidth * 0.08),
                    child: Column(
                      children: [
                        (loginError)
                        ? Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: AppColors.colorWhite,
                              width: 2
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(15))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0, bottom: 10, left: 30, right: 30),
                            child: Text('Usuário e/ou senha não conferem!',
                                style: GoogleFonts.inter(
                                color: AppColors.colorWhite,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        )
                        : Container(),
                        Stack(
                          children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 28.0),
                            child: CustomPaint(
                              painter: CustomBorderPainter(
                                borderColor: AppColors.colorWhite,
                                borderWidth: 4.0,
                                cutLength: 200,
                                borderRadius: BorderRadius.circular(16.0), // Example: rounded corners
                              ),
                              child: Container(
                                width: screenWidth * 0.34,
                                height: 300,
                                color: Colors.transparent, // Background color for the content
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 48.0, bottom: 10),
                                      child: SizedBox(
                                        width: screenWidth * 0.26,
                                        child: TextFormField(
                                          onTap: () {
                                            setState(() {
                                              loginError = false;
                                            });
                                          },
                                          cursorColor: AppColors.colorWhite,
                                          controller: _usuarioController,
                                          style: GoogleFonts.inter(
                                            color: AppColors.colorWhite,
                                            fontSize: 14,
                                          ),
                                          decoration: InputDecoration(
                                            floatingLabelStyle: TextStyle(color: AppColors.colorWhite),
                                            enabledBorder: UnderlineInputBorder(      
                                              borderSide: BorderSide(color: AppColors.colorWhite),   
                                              ),
                                            focusedBorder: UnderlineInputBorder(      
                                              borderSide: BorderSide(color: AppColors.colorWhite),   
                                              ),
                                            label: Text("Usuário",                                         
                                                style: GoogleFonts.inter(
                                                color: AppColors.colorWhite,
                                                fontSize: 15
                                              ),),
                                          ),
                                          keyboardType: TextInputType.text,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 45.0),
                                      child: SizedBox(
                                        width: screenWidth * 0.26,
                                        child: TextFormField(
                                          onTap: () {
                                            setState(() {
                                              loginError = false;
                                            });
                                          },
                                          cursorColor: AppColors.colorWhite,
                                          controller: _passwordController,
                                          style: GoogleFonts.inter(
                                            color: AppColors.colorWhite,
                                            fontSize: 14,
                                          ),
                                          decoration: InputDecoration(
                                            counterStyle: TextStyle(color: AppColors.colorWhite),
                                            floatingLabelStyle: TextStyle(color: AppColors.colorWhite),
                                            enabledBorder: UnderlineInputBorder(      
                                              borderSide: BorderSide(color: AppColors.colorWhite),   
                                              ),
                                            focusedBorder: UnderlineInputBorder(      
                                              borderSide: BorderSide(color: AppColors.colorWhite),   
                                              ),
                                            label: Text("Senha", 
                                              style: GoogleFonts.inter(
                                                color: AppColors.colorWhite,
                                                fontSize: 15
                                              ),
                                            ),
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  _passwordVsible = !_passwordVsible;
                                                });
                                              },
                                              icon: Icon(
                                                _passwordVsible
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: AppColors.colorWhite,
                                              ),
                                            ),
                                          ),
                                          keyboardType: TextInputType.visiblePassword,
                                          maxLength: 16,
                                          obscureText: _passwordVsible ? false : true,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        tryLogin(context);
                                      },
                                      onHover: (isHovering) {
                                        setState(() {
                                          _isHovering = !isHovering;
                                        });
                                      },
                                      child: Container(
                                        width: screenWidth * 0.34,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                          ),
                                          border: Border(top: _isHovering ? BorderSide.none : BorderSide(color: AppColors.colorWhite, width: 1)),
                                          color: _isHovering ? AppColors.colorWhite : Colors.transparent,
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('Continuar',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.inter(
                                                color: _isHovering ? AppColors.colorVeryDarkBlue.withValues(alpha: 0.8) : AppColors.colorWhite,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 3.0),
                                              child: Icon(
                                                Icons.chevron_right, 
                                                size: 37,
                                                color: _isHovering ? AppColors.colorVeryDarkBlue.withValues(alpha: 0.8) : AppColors.colorWhite,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ),
                            ),
                          ),
                          Positioned(
                              left: screenWidth * 0.03,
                              top: 7,
                              child: Container(
                                padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                                color: Colors.transparent,
                                child: Text(
                                  'Faça seu login',
                                  style: GoogleFonts.inter(
                                    color: AppColors.colorWhite,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                          ]
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      );
    } else {
      double screenWidth = MediaQuery.of(context).size.width;
      double screenHeight = MediaQuery.of(context).size.height;
      return Scaffold(
        body: Container(
              height: screenHeight,
              width: screenWidth,
              decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background_desktop.png'),
                fit: BoxFit.cover
              )
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 69.0, left: 31),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset('assets/images/Logo_fr.png',scale: 1.3,),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text('FRPelissari', 
                              style: GoogleFonts.inter(
                                color: AppColors.colorWhite,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 69.0, left: 31),
                        child: Text('Dashboard TLPP', 
                          style: GoogleFonts.inter(
                            color: AppColors.colorWhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 69.0, left: 31, right: 31),
                        child: Text('Seja bem vindo ao Dashboard financeiro em TLPP.', 
                          style: GoogleFonts.inter(
                            color: AppColors.colorWhite,
                            fontWeight: FontWeight.normal,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0, left: 31, right: 31),
                        child: Text('Projeto construído utilizando TLPP como backend, '
                            'conectando diretamente ao Protheus e como frontend, Flutter.', 
                          style: GoogleFonts.inter(
                            color: AppColors.colorWhite,
                            fontWeight: FontWeight.normal,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0, left: 31, right: 31),
                        child: Text('Deixem seus comentários!', 
                          style: GoogleFonts.inter(
                            color: AppColors.colorWhite,
                            fontWeight: FontWeight.normal,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      (loginError)
                      ? Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                color: AppColors.colorWhite,
                                width: 2
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(15))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0, bottom: 10, left: 30, right: 30),
                              child: Text('Usuário e/ou senha não conferem!',
                                  style: GoogleFonts.inter(
                                  color: AppColors.colorWhite,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      : Container(),
                    ],
                  ),
                  Stack(
                    children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 58.0, bottom: 58),
                      child: CustomPaint(
                        painter: CustomBorderPainter(
                          borderColor: AppColors.colorWhite,
                          borderWidth: 4.0,
                          cutLength: 190,
                          borderRadius: BorderRadius.circular(16.0), // Example: rounded corners
                        ),
                        child: Container(
                          width: screenWidth * 0.63,
                          height: 238,
                          color: Colors.transparent,
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0, bottom: 10),
                                child: SizedBox(
                                  width: screenWidth * 0.46,
                                  child: TextFormField(
                                    onTap: () {
                                      setState(() {
                                        loginError = false;
                                      });
                                    },
                                    cursorColor: AppColors.colorWhite,
                                    controller: _usuarioController,
                                    style: GoogleFonts.inter(
                                      color: AppColors.colorWhite,
                                      fontSize: 14,
                                    ),
                                    decoration: InputDecoration(
                                      floatingLabelStyle: TextStyle(color: AppColors.colorWhite),
                                      enabledBorder: UnderlineInputBorder(      
                                        borderSide: BorderSide(color: AppColors.colorWhite),   
                                        ),
                                      focusedBorder: UnderlineInputBorder(      
                                        borderSide: BorderSide(color: AppColors.colorWhite),   
                                        ),
                                      label: Text("Usuário",
                                          style: GoogleFonts.inter(
                                          color: AppColors.colorWhite,
                                          fontSize: 15
                                        ),),
                                    ),
                                    keyboardType: TextInputType.text,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: screenWidth * 0.46,
                                child: TextFormField(
                                  onTap: () {
                                    setState(() {
                                      loginError = false;
                                    });
                                  },
                                  cursorColor: AppColors.colorWhite,
                                  controller: _passwordController,
                                  style: GoogleFonts.inter(
                                    color: AppColors.colorWhite,
                                    fontSize: 14,
                                  ),
                                  decoration: InputDecoration(
                                    counterStyle: TextStyle(color: AppColors.colorWhite),
                                    floatingLabelStyle: TextStyle(color: AppColors.colorWhite),
                                    enabledBorder: UnderlineInputBorder(      
                                      borderSide: BorderSide(color: AppColors.colorWhite),   
                                      ),
                                    focusedBorder: UnderlineInputBorder(      
                                      borderSide: BorderSide(color: AppColors.colorWhite),   
                                      ),
                                    label: Text("Senha", 
                                      style: GoogleFonts.inter(
                                        color: AppColors.colorWhite,
                                        fontSize: 15
                                      ),
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _passwordVsible = !_passwordVsible;
                                        });
                                      },
                                      icon: Icon(
                                        _passwordVsible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: AppColors.colorWhite,
                                      ),
                                    ),
                                  ),
                                  keyboardType: TextInputType.visiblePassword,
                                  maxLength: 16,
                                  obscureText: _passwordVsible ? false : true,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 25.0),
                                child: InkWell(
                                  onTap: () {
                                    tryLogin(context);
                                  },
                                  onHover: (isHovering) {
                                    setState(() {
                                      _isHovering = !isHovering;
                                    });
                                  },
                                  child: Container(
                                    width: screenWidth * 0.63,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                      border: Border(top: _isHovering ? BorderSide.none : BorderSide(color: AppColors.colorWhite, width: 1)),
                                      color: _isHovering ? AppColors.colorWhite : Colors.transparent,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('Continuar',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.inter(
                                            color: _isHovering ? AppColors.colorVeryDarkBlue.withValues(alpha: 0.8) : AppColors.colorWhite,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 3.0),
                                          child: Icon(
                                            Icons.chevron_right, 
                                            size: 30,
                                            color: _isHovering ? AppColors.colorVeryDarkBlue.withValues(alpha: 0.8) : AppColors.colorWhite,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ),
                      ),
                    ),
                    Positioned(
                        left: screenWidth * 0.06,
                        top: 40,
                        child: Container(
                          padding: EdgeInsets.only(bottom: 10, left: 5, right: 10),
                          color: Colors.transparent,
                          child: Text(
                            'Faça seu login',
                            style: GoogleFonts.inter(
                              color: AppColors.colorWhite,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ]
                  ),
                ],
              ),
            ),
          ),
      );
    }
  }

    void tryLogin(BuildContext context) {
    String usuario = _usuarioController.text;
    String password = _passwordController.text;

    if (usuario.isNotEmpty && password.isNotEmpty) {
      authService.login(usuario, password).then((token) {
          setState(() {
          loginError = true;
        });
        Navigator.pushReplacementNamed(context, 'dashboard');
      }).catchError((e) {
        setState(() {
          loginError = true;
        });
      }, test: (e) => e is UserNotFoundException).catchError((e) {
        setState(() {
          loginError = true;
        });
      }, test: (e) => e is FormatException).catchError((e) {
        setState(() {
          loginError = true;
        });
      }, test: (e) => e is TimeoutException);
    } else {
      setState(() {
        loginError = true;
      });
    }


  }
}

class CustomBorderPainter extends CustomPainter {
  final Color borderColor;
  final double borderWidth;
  final double cutLength;
  final BorderRadius? borderRadius; // Optional: for rounded corners

  CustomBorderPainter({
    required this.borderColor,
    required this.borderWidth,
    required this.cutLength,
    this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final Path path = Path();
    //Linha superior a partir do corte size.width * 0.42 + 
    path.moveTo(cutLength, 0);
    path.lineTo(size.width * 0.95, 0);

    //cria o BorderRadius
    path.arcToPoint(
      Offset(size.width, size.height * 0.09), 
      radius: Radius.circular(25), 
      clockwise: true, 
    );

    //Linha lateral direita
    path.moveTo(size.width, size.height * 0.09);
    path.lineTo(size.width, size.height * 0.93);

    //cria o BorderRadius
    path.arcToPoint(
      Offset(size.width * 0.95, size.height + 0.05), 
      radius: Radius.circular(25), 
      clockwise: true, 
    );

    //Linha inferior
    path.moveTo(size.width * 0.95, size.height);
    path.lineTo(size.width * 0.05, size.height);

    //cria o BorderRadius
    path.arcToPoint(
      Offset(0, size.height * 0.93), 
      radius: Radius.circular(25), 
      clockwise: true, 
    );
    
    //Linha lateral esquerda
    path.moveTo(0, size.height * 0.93);
    path.lineTo(0, size.height * 0.08);

    //cria o BorderRadius
    path.arcToPoint(
      Offset(size.width * 0.05, 0), 
      radius: Radius.circular(25), 
      clockwise: true, 
    );

    //Linha superior antes do corte
    path.moveTo(size.width * 0.05, 0);
    path.lineTo(size.width * 0.09, 0);
    
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomBorderPainter oldDelegate) {
    return oldDelegate.cutLength != cutLength;
    //return oldDelegate.borderColor != borderColor ||
    //    oldDelegate.borderWidth != borderWidth ||
    //    oldDelegate.borderRadius != borderRadius;
  }
}
