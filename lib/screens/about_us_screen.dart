import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Cores da NASA para o tema
    final Color nasaBlue = const Color(0xFF0b3c91);
    final Color nasaRed = const Color(0xFFfc3d21);

    return Scaffold(
      backgroundColor: const Color(0xFF0d253f),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
        ),
        title: const Text('Sobre Nós'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                nasaBlue,
                nasaRed,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            // --- LOGO SDF ---
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: nasaBlue.withValues(alpha: 0.5),
                    blurRadius: 20,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Image.asset(
                'assets/images/SDF-Logo.png',
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 25),

            // --- TEXTOS ---
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Good morning, good afternoon, and good evening!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF01b4e4),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Permita-me apresentar, Armando me chamo, sou estudante do IFRO do curso de Análise e Desenvolvimento de Sistemas.\n\n"
                    "Esse aplicativo é uma solução acadêmica desenvolvida para a disciplina de Programação Mobile I.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Desenvolvido utilizando a API pública da NASA (Astronomy Picture of the Day), explorando o vasto universo de dados espaciais diretamente no seu dispositivo.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  fontStyle: FontStyle.italic,
                  height: 1.5,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // --- SEÇÃO INSTITUIÇÃO & API ---
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Instituição & Tecnologia",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 15),

            SizedBox(
              height: 80,
              child: Row(
                children: [
                  // Logo IFRO (PNG)
                  Expanded(
                    child: _buildLogoContainer(
                      child: Image.asset(
                        'assets/images/IFLogo.png',
                        fit: BoxFit.contain,
                      ),
                      label: "IFRO",
                    ),
                  ),

                  const SizedBox(width: 15),

                  // Logo NASA (PNG)
                  Expanded(
                    child: _buildLogoContainer(
                      child: Image.asset(
                        'assets/images/NASA_logo.png',
                        fit: BoxFit.contain,
                      ),
                      label: "NASA API",
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // --- SEÇÃO DESENVOLVEDOR ---
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Desenvolvedor",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 15),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/ByGT.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Git-Linkedin
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildContactRow(Icons.code, "github.com/ArmandoGT"),
                        const SizedBox(height: 8),
                        _buildContactRow(Icons.link, "linkedin.com/in/armandogt"),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Widget-auxiliar logos simples
  Widget _buildLogoContainer({required Widget child, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 45,
            width: 45,
            child: child,
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Widget-auxiliar para o Git-Linkedin
  Widget _buildContactRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF01b4e4), size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
