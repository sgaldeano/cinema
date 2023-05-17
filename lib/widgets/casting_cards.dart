import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:s7_cinema/providers/movies_provider.dart';
import '../models/models.dart' show Cast;

class CastingCards extends StatelessWidget {

  final int movieId;

  const CastingCards(this.movieId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final movieProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
        future: movieProvider.getMovieCasting(movieId),
        builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
          if (!snapshot.hasData) {
            return Container(
                height: 180,
                alignment: Alignment.center,
                child: const CircularProgressIndicator()
            );
          }

          final List<Cast> casting = snapshot.data!;

          return Container(
              margin: const EdgeInsets.only(
                  bottom: 30
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: 15
              ),
              width: double.infinity,
              height: 190,
              child: ListView.builder(
                  itemCount: casting.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    final cast = casting[index];
                    return cast.profilePath != null ? _CastCard(cast) : null;
                  }
              )
          );
        }
    );
  }
}

class _CastCard extends StatelessWidget {

  final Cast cast;

  const _CastCard(this.cast, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        width: 110,
        height: 100,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                  placeholder: const AssetImage('assets/no_image.jpg'),
                  image: NetworkImage(cast.fullProfilePath),
                  width: 110,
                  height: 140,
                  fit: BoxFit.cover
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: Text(cast.name,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            )
          ],
        )
    );
  }
}