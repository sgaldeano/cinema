import 'package:flutter/material.dart';
import '../models/models.dart' show Movie;
import '../widgets/widgets.dart';

class DetailsPage extends StatelessWidget {

  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(movie),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(movie),
              const SizedBox(height: 15),
              _Overview(movie),
              const SizedBox(height: 15),
              CastingCards(movie.id)
            ]),
          )
        ],
      )
    );
  }
}

class _CustomAppBar extends StatelessWidget {

  final Movie movie;

  const _CustomAppBar(this.movie);

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return SliverAppBar(
      expandedHeight: size.height * 0.25,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.zero,
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          padding: const EdgeInsets.only(bottom: 8, left: 20, right: 20),
          child: Text(movie.title,
            style: const TextStyle(
              fontSize: 16,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center
          )
        ),
        background: FadeInImage(
            placeholder: const AssetImage('assets/loading.gif'),
            image: NetworkImage(movie.fullBackdropPath),
            fit: BoxFit.cover
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {

  final Movie movie;

  const _PosterAndTitle(this.movie);

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                height: 150,
                placeholder: const AssetImage('assets/no_image.jpg'),
                image: NetworkImage(movie.fullPosterPath),
                fit: BoxFit.cover,
              )
            ),
          ),
          const SizedBox(
            width: 20
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 190),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title,
                  style: textTheme.titleLarge,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2
                ),

                Text(movie.originalTitle,
                  style: textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                    maxLines: 2
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.star_border_outlined, size: 20, color: Colors.grey),
                    const SizedBox(width: 3),
                    Text('${movie.voteAverage}',
                      style: textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                )
              ]
            ),
          )
        ],
      )
    );
  }
}

class _Overview extends StatelessWidget {

  final Movie movie;

  const _Overview(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        child: Text(movie.overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.bodyLarge
      )
    );
  }
}
