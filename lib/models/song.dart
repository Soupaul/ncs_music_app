class Song {
  String? title;
  String? thumbnail;
  List<String>? artists;
  String? genre;
  String? releaseDate;
  String? content;

  Song(
      {this.title,
      this.thumbnail,
      this.artists,
      this.genre,
      this.releaseDate,
      this.content});

  Song.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    thumbnail = json['thumbnail'];
    artists = json['artists'].cast<String>();
    genre = json['genre'];
    releaseDate = json['release_date'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['thumbnail'] = thumbnail;
    data['artists'] = artists;
    data['genre'] = genre;
    data['release_date'] = releaseDate;
    data['content'] = content;
    return data;
  }
}
