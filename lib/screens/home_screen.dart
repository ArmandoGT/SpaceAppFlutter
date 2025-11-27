import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/apod_provider.dart';
import 'about_us_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final Color nasaBlue = const Color(0xFF0b3c91);
  final Color nasaRed = const Color(0xFFfc3d21);
  final Color backgroundGrey = const Color(0xFFc2c2c2);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ApodProvider>(context, listen: false).fetchApod(null);
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1995, 6, 16),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: nasaBlue,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      Provider.of<ApodProvider>(context, listen: false).fetchApod(formattedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ApodProvider>(context);

    final List<Widget> pages = [
      _buildDailySection(provider),

      FavoritesScreen(
        onFavoriteTap: (date) {
          provider.fetchApod(date);
          setState(() => _selectedIndex = 0);
        },
      ),
    ];

    return Scaffold(
      backgroundColor: backgroundGrey,
      appBar: AppBar(
        backgroundColor: nasaBlue,
        title: const Text(
          'Diário Espacial NASA',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          if (_selectedIndex == 0)
            IconButton(
              icon: const Icon(Icons.calendar_month_rounded, color: Colors.white),
              tooltip: 'Escolher Data',
              onPressed: () => _selectDate(context),
            ),
        ],
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: nasaBlue,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.rocket_launch),
              label: 'Do Dia'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Favoritos'
          ),
        ],
      ),
    );
  }

  // --- Widget Imagem do Dia ---
  Widget _buildDailySection(ApodProvider provider) {
    if (provider.isLoading) {
      return Center(child: CircularProgressIndicator(color: nasaBlue));
    }

    if (provider.errorMessage.isNotEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 60, color: nasaRed),
              const SizedBox(height: 10),
              Text(
                provider.errorMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: nasaBlue),
                onPressed: () => provider.fetchApod(null),
                child: const Text("Tentar Novamente", style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      );
    }

    if (provider.currentApod == null) {
      return const Center(child: Text('Nenhum dado carregado.'));
    }

    final apod = provider.currentApod!;
    final isFav = provider.isFavorite(apod.date);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                  child: apod.mediaType == 'image'
                      ? Image.network(
                    apod.url,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 300,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return SizedBox(
                        height: 300,
                        child: Center(child: CircularProgressIndicator(color: nasaBlue)),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 300,
                      color: Colors.grey[300],
                      child: const Center(child: Icon(Icons.broken_image, size: 50)),
                    ),
                  )
                      : Container(
                    height: 200,
                    color: Colors.black87,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.play_circle_outline, color: Colors.white, size: 50),
                        const SizedBox(height: 10),
                        const Text('Este conteúdo é um vídeo.', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              apod.title,
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: nasaBlue),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              color: isFav ? nasaRed : Colors.grey,
                              size: 32,
                            ),
                            onPressed: () {
                              provider.toggleFavorite();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(isFav ? 'Removido dos favoritos!' : 'Salvo nos favoritos!'),
                                    duration: const Duration(seconds: 1),
                                    backgroundColor: isFav ? nasaRed : nasaBlue,
                                  )
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 16, color: nasaRed),
                          const SizedBox(width: 6),
                          Text(
                            apod.date,
                            style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            "Explicação",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              apod.explanation,
              style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
              textAlign: TextAlign.justify,
            ),
          ),

          const SizedBox(height: 30),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[100],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/IconSDF.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/SDF-Logo.png',
                          errorBuilder: (c, e, s) => Icon(Icons.rocket, color: nasaBlue),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Quer saber mais?",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: nasaBlue,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: nasaBlue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const AboutUsScreen()),
                            );
                          },
                          icon: const Icon(Icons.info_outline, size: 18),
                          label: const Text("Sobre Nós"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
