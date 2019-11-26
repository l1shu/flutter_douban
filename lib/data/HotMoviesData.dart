class HotMoviesData {
  Rating rating;
  List<String> genres;
  String title;
  List<Cast> casts;
  int collectCount;
  List<Cast> directors;
  Avatars images;
  String id;

  HotMoviesData();

  factory HotMoviesData.fromJson(Map<String, dynamic> movieDataJson) {
    HotMoviesData hotMoviesData = HotMoviesData();

    Rating rating = Rating(
      movieDataJson['rating']['max'],
      double.parse(movieDataJson['rating']['average'].toString()),
      movieDataJson['rating']['min'],
    );

    List<String> genres = new List();
    for (String genre in movieDataJson['genres']) {
      genres.add(genre);
    }

    List<Cast> casts = new List();
    for (dynamic castData in movieDataJson['casts']) {
      Avatars avatars;
      if (castData['avatars'] != null) {
        avatars = Avatars(
          castData['avatars']['small'],
          castData['avatars']['large'],
          castData['avatars']['medium']
        );
      } else {
        avatars = Avatars('', '', '');
      }
      Cast cast = Cast(castData['alt'], avatars, castData['name'], castData['id']);
      casts.add(cast);
    }

    List<Cast> directors = new List();
    for (dynamic castData in movieDataJson['directors']) {
      Avatars avatars;
      if (castData['avatars'] != null) {
        avatars = Avatars(
          castData['avatars']['small'],
          castData['avatars']['large'],
          castData['avatars']['medium']
        );
      } else {
        avatars = Avatars('', '', '');
      }
      Cast cast = Cast(castData['alt'], avatars, castData['name'], castData['id']);
      directors.add(cast);
    }


    hotMoviesData.rating = rating;
    hotMoviesData.genres = genres;
    hotMoviesData.title = movieDataJson['title'];
    hotMoviesData.casts = casts;
    hotMoviesData.collectCount = movieDataJson['collect_count'];
    hotMoviesData.directors = directors;
    hotMoviesData.images = Avatars(
      movieDataJson['images']['small'],
      movieDataJson['images']['large'],
      movieDataJson['images']['medium']
    );
    hotMoviesData.id = movieDataJson['id'];

    return hotMoviesData;
  }

  String getCasts() {
    String castsString = '';
    for (Cast cast in casts) {
      castsString += cast.name;
      castsString += '/';
    }

    return castsString.substring(0, castsString.length - 1);
  }

  String getDirectors() {
    String directorsString = '';
    for (Cast cast in directors) {
      directorsString += cast.name;
      directorsString += '/';
    }

    return directorsString.substring(0, directorsString.length - 1);
  }
}

class Rating {
  int max;
  double average;
  int min;

  Rating(this.max, this.average, this.min);
}

class Cast {
  String alt;
  Avatars avatars;
  String name;
  String id;

  Cast(this.alt, this.avatars, this.name, this.id);
}

class Avatars {
  String small;
  String large;
  String medium;

  Avatars(this.small, this.large, this.medium);
}