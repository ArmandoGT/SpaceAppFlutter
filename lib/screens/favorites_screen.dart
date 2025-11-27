import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/apod_provider.dart';

class FavoritesScreen extends StatelessWidget {
  final Function(String date) onFavoriteTap;

  const FavoritesScreen({super.key, required this.onFavoriteTap});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ApodProvider>(context);

    final nasaBlue = Theme.of(context).colorScheme.primary;
    final nasaRed = Theme.of(context).colorScheme.secondary;

    if (provider.favorites.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.star_border, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Sua galeria está vazia.',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: provider.favorites.length,
      itemBuilder: (context, index) {
        final fav = provider.favorites[index];

        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: const EdgeInsets.all(10),

            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: fav.mediaType == 'image'
                  ? Image.network(
                fav.url,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Container(width: 60, height: 60, color: Colors.grey, child: const Icon(Icons.error)),
              )
                  : Container(
                width: 60, height: 60, color: Colors.black87,
                child: const Icon(Icons.play_circle_filled, color: Colors.white),
              ),
            ),

            title: Text(
              fav.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold, color: nasaBlue),
            ),

            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(fav.date),
            ),

            trailing: IconButton(
              icon: Icon(Icons.delete_outline, color: nasaRed),
              onPressed: () {
                provider.removeFavorite(fav);
              },
            ),

            onTap: () {
              onFavoriteTap(fav.date);
            },
          ),
        );
      },
    );
  }
}
