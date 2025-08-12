import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_bloc_app/src/home/bloc/home_bloc.dart';
import 'package:login_bloc_app/src/home/models/photo_model.dart';
import 'package:login_bloc_app/src/home/repository/home_repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        homeRepository: RepositoryProvider.of<HomeRepository>(context),
      )..add(FetchHomeData()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Photo Gallery',
            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: const HomeView(),
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        switch (state.status) {
          case HomeStatus.initial:
          case HomeStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case HomeStatus.success:
            return PhotoList(photos: state.photos);
          case HomeStatus.failure:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Failed to fetch photos: ${state.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<HomeBloc>().add(FetchHomeData()),
                    child: const Text('Retry'),
                  )
                ],
              ),
            );
        }
      },
    );
  }
}

class PhotoList extends StatelessWidget {
  final List<Photo> photos;
  const PhotoList({super.key, required this.photos});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: photos.length,
      itemBuilder: (context, index) {
        final photo = photos[index];
        return PhotoListItem(photo: photo);
      },
    );
  }
}

class PhotoListItem extends StatelessWidget {
  final Photo photo;
  const PhotoListItem({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    final double imageAspectRatio = photo.width / photo.height;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: imageAspectRatio,
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/placeholder.gif', // Add a placeholder gif/image
              image: photo.downloadUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  photo.author,
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w600, // Semi-Bold
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Dimensions: ${photo.width} x ${photo.height}', // Description
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Colors.grey.shade700, // Dark Grey
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}