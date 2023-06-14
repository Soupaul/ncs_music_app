import 'package:flutter/material.dart';
import 'package:ncs_music_app/models/song.dart';
import 'package:ncs_music_app/resources/api.dart';
import 'package:ncs_music_app/screens/player.dart';

class Home extends StatefulWidget {
  final String title;
  const Home({super.key, required this.title});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(
                "New Releases",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: API.getNewReleases(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.data == "Error") {
                      return const Center(
                        child: Text(
                          "Error loading data",
                          style: TextStyle(fontSize: 18.0),
                        ),
                      );
                    }

                    List<Song> songs = snapshot.data;

                    return ListView.builder(
                      padding: const EdgeInsets.only(top: 10.0),
                      itemCount: songs.length,
                      itemBuilder: (context, index) => Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    Player(song: songs[index]),
                              ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(width: 1.0),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Row(
                                children: [
                                  Image.network(
                                    songs[index].thumbnail!,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            songs[index].title!,
                                            style: const TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 16.0,
                                            child: ListView.separated(
                                              separatorBuilder: (context, i) =>
                                                  const Text(
                                                ", ",
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  songs[index].artists!.length,
                                              itemBuilder: (context, i) => Text(
                                                songs[index].artists![i],
                                                style: const TextStyle(
                                                  fontSize: 14.0,
                                                ),
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
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
