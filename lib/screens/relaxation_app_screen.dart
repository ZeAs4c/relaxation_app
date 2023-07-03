import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../models/item_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RelaxationAppScreen extends StatefulWidget {
  const RelaxationAppScreen({super.key});

  @override
  RelaxationAppScreenState createState() => RelaxationAppScreenState();
}

class RelaxationAppScreenState extends State<RelaxationAppScreen> {
  final List<Item> items = [
    Item(
      name: "Forest",
      audioPath: "relaxation_audios/forest.mp3",
      imagePath: "images/forest.jpeg",
    ),
    Item(
      name: "Night",
      audioPath: "relaxation_audios/night.mp3",
      imagePath: "images/night.jpeg",
    ),
    Item(
      name: "Ocean",
      audioPath: "relaxation_audios/ocean.mp3",
      imagePath: "images/ocean.jpeg",
    ),
    Item(
      name: "Waterfall",
      audioPath: "relaxation_audios/waterfall.mp3",
      imagePath: "images/waterfall.jpeg",
    ),
    Item(
      name: "Wind",
      audioPath: "relaxation_audios/wind.mp3",
      imagePath: "images/wind.jpeg",
    ),
  ];

  final AudioPlayer audioPlayer = AudioPlayer();
  int? playingIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(items[index].imagePath),
                    ),
                  ),
                  child: ListTile(
                    title: Text(
                      items[index].name,
                    ),
                    leading: IconButton(
                      icon: playingIndex == index
                          ? FaIcon(FontAwesomeIcons.stop)
                          : FaIcon(FontAwesomeIcons.play),
                      onPressed: () async {
                        if (playingIndex == index) {
                          setState(() {
                            playingIndex = null;
                          });
                          audioPlayer.stop();
                        } else {
                          try {
                            //await означает, что мы ждем пока найдеться путь, перед тем как проигрывать аудио
                            await audioPlayer
                                .setAsset(items[index].audioPath)
                                .catchError((onError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red.withOpacity(0.5),
                                  content: Text("Oops, an error $onError"),
                                ),
                              );
                            });
                            audioPlayer.play();
                            setState(() {
                              playingIndex = index;
                            });
                          } catch (error) {
                            print(error);
                          }
                        }
                      },
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
