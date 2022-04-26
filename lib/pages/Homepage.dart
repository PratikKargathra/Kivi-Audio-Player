import 'dart:async';

import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'sorces/sources.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);
  @override
  State<Homepage> createState() => _HomepageState();
}
class _HomepageState extends State<Homepage> {

  int tabBar = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic( const Duration(milliseconds: 100), (t){setState(() {});});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(right: 20, left: 20,top: 60),
        children:  [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Transform.scale(scale: 0.8,child: IconButton(onPressed: (){}, icon: const Icon(Icons.search ,size: 30,))),
              Transform.scale(scale: 0.8,child: IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert_rounded, size: 30,))),
            ],
          ),
          const SizedBox(height: 20,),
          const Text("Kiwi Music Player",style: TextStyle(color:  Color(0xFF590D2B), fontSize: 30, fontWeight: FontWeight.w500),),
          const SizedBox(height: 20,),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45.withOpacity(0.15),
                    offset: const
                    Offset(0,0),
                    blurRadius: 3,
                    spreadRadius: 1,
                  )
                ]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: (){
                      setState(() {
                        tabBar = 0;
                      });
                    },
                    child: Text("Assets Songs", style: TextStyle(color: (tabBar == 0)?Colors.white:const Color(0xFF590D2B)),),
                  style: TextButton.styleFrom(
                    primary: Colors.blue,
                    backgroundColor: (tabBar == 0)?const Color(0xFF590D2B):Colors.transparent,
                    elevation: (tabBar == 0)?0:0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )
                  ),
                ),
                TextButton(
                  onPressed: (){
                    setState(() {
                      tabBar = 1;
                    });
                  },
                  child: Text("Network Songs", style: TextStyle(color: (tabBar == 1)?Colors.white:const Color(0xFF590D2B)),),
                  style: TextButton.styleFrom(
                    primary: Colors.blue,
                    backgroundColor: (tabBar == 1)?const Color(0xFF590D2B):Colors.transparent,
                    elevation: (tabBar == 1)?0:0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: (){
                    setState(() {
                      tabBar = 2;
                    });
                  },
                  child: Text("Local Songs", style: TextStyle(color: (tabBar == 2)?Colors.white:const Color(0xFF590D2B)),),
                  style: TextButton.styleFrom(
                    primary: Colors.blue,
                    backgroundColor: (tabBar == 2)?const Color(0xFF590D2B):Colors.transparent,
                    elevation: (tabBar == 2)?0:0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20,),
          Column(
            children: songs.map((e) => MusicBox(data: e,) ).toList(),
          ),

        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}

int songIndex = 0;

class MusicBox extends StatefulWidget {
  MusicBox({Key? key,required  this.data}) : super(key: key);
  Song data;
  @override
  State<MusicBox> createState() => _MusicBoxState();
}

class _MusicBoxState extends State<MusicBox> {

  final assetsAudioPlayer = AssetsAudioPlayer();
  double songDurationInSeconds = 0;
  String songDuration = "0:0:0";

  @override
  void initState() {
    super.initState();
    assetsAudioPlayer.open(
      Playlist(audios: songs.map((e) => Audio(e.song)).toList(), startIndex: songs.indexOf(widget.data)),
      autoStart: false,
    );

    assetsAudioPlayer.current.listen((Playing? playing) {
      songDuration = playing!.audio.duration.toString().split(".")[0];
      songDurationInSeconds = playing.audio.duration.inSeconds.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: (){
            songIndex = songs.indexOf(widget.data);
            Navigator.pushNamed(context,"player");

          },
          child: Container(
            padding: const EdgeInsets.only(right: 20),
              height: 80,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45.withOpacity(0.15),
                    offset: const
                    Offset(0,0),
                    blurRadius: 3,
                    spreadRadius: 1,
                  )
                ]
              ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration:  BoxDecoration(
                    color: Colors.blue,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
                    image: DecorationImage(image: NetworkImage(widget.data.img), fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(width: 20,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text(widget.data.title, style: const TextStyle(fontSize: 20),),
                  const SizedBox(height: 5,),
                  Text(widget.data.artist, style: const TextStyle(fontSize: 15),),
                ],),
                const Spacer(),
                Text(songDuration),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10,),
      ],
    );
  }
}



class AppMusicPlayer extends StatefulWidget {
  const AppMusicPlayer({Key? key}) : super(key: key);

  @override
  State<AppMusicPlayer> createState() => _AppMusicPlayerState();
}

class _AppMusicPlayerState extends State<AppMusicPlayer> {

  bool isPlaying = true;
  final assetsAudioPlayer = AssetsAudioPlayer();
  double currentPositionInSeconds = 0;
  double songDurationInSeconds = 0;
  String currentPosition = "0:0:0";
  String songDuration = "0:0:0";


  @override
  void initState() {
    super.initState();
    assetsAudioPlayer.open(
      Playlist(
          audios: songs.map((e) => Audio(
            e.song,
            metas: Metas(
              title:  e.title,
              artist: e.artist,
              album: e.album,
              image: MetasImage.network(e.img), //can be MetasImage.network
            ),
          )).toList(),
        startIndex: songIndex,
      ),
      showNotification: true,
      autoStart: true,
    );
    assetsAudioPlayer.current.listen((Playing? playing) {
      songDuration = playing!.audio.duration.toString().split(".")[0];
      songDurationInSeconds = playing.audio.duration.inSeconds.toDouble();
      setState(() {});
    });

    assetsAudioPlayer.currentPosition.listen((Duration? duration) {
      currentPosition = duration.toString().split(".")[0];
      currentPositionInSeconds = duration!.inSeconds.toDouble();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
         await assetsAudioPlayer.stop();
         return true;
      },
      child: Scaffold(
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 50),
                height: MediaQuery.of(context).size.width*0.5,
                width: MediaQuery.of(context).size.width*0.5,
                decoration: BoxDecoration(
                color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(songs[songIndex].img),
                  ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.10),
                          blurRadius: 20,
                          offset: const Offset(0,-4),
                          spreadRadius: 0
                      )
                    ]
                ),
              ),
              Text(songs[songIndex].title,style: const TextStyle(fontSize: 35, fontWeight: FontWeight.w500,color: Colors.black87),),
              const SizedBox(height: 10,),
              Text(songs[songIndex].artist, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500,color: Colors.black87),),
              const SizedBox(height: 50,),
              Container(
                padding: const EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height*0.35,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.10),
                          blurRadius: 20,
                          offset: const Offset(0,-4),
                          spreadRadius: 0
                      )
                    ]
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(currentPosition, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),),
                          Text(songDuration,style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),)
                        ],
                      ),
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                          trackHeight: 5,
                          thumbShape: SliderComponentShape.noThumb,),
                      child: Slider(
                          thumbColor: Colors.transparent,
                          activeColor: const Color(0xff590D2B),
                          inactiveColor:  const Color(0xffEFF1F7) ,
                          value: currentPositionInSeconds,
                          min: 0,
                          max: songDurationInSeconds,
                          onChanged: (val){
                            setState(() {
                              assetsAudioPlayer.seek(Duration(seconds: val.toInt()));
                            });
                          }
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 1,),
                        Transform.scale(
                          scale: 0.8,
                          child: FloatingActionButton(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            onPressed: ()  async {
                              assetsAudioPlayer.shuffle;
                            },
                            child:  const Icon(Icons.shuffle,color:  Color(0xff590D2B),),
                          ),
                        ),
                        FloatingActionButton(
                          elevation: 0,
                          backgroundColor: const Color(0xFFE8F0FA),
                          onPressed: ()  async {
                            await assetsAudioPlayer.previous();
                            if(songIndex>0){
                              songIndex--;
                            }
                            setState(() {});
                          },
                          child:  const Icon(Icons.skip_previous,color:  Color(0xff590D2B),),
                        ),
                        const SizedBox(width: 1,),
                        Transform.scale(
                          scale: 1.3,
                          child: FloatingActionButton(
                            elevation: 0,
                            backgroundColor: const Color(0xff590D2B),
                            onPressed: () async {
                              await assetsAudioPlayer.playOrPause();
                              isPlaying = !isPlaying;
                              setState(() {});
                            },
                            child:  Icon((isPlaying)?Icons.pause:Icons.play_arrow),
                          ),
                        ),
                        const SizedBox(width: 1,),
                        FloatingActionButton(
                          elevation: 0,
                          backgroundColor: const Color(0xFFE8F0FA),
                          onPressed: () async {
                            await assetsAudioPlayer.next();
                            if(songIndex<songs.length){
                              songIndex++;
                            }
                            setState(() {});
                          },
                          child:  const Icon(Icons.skip_next,color:  Color(0xff590D2B),),
                        ),
                        Transform.scale(
                          scale: 0.8,
                          child: FloatingActionButton(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            onPressed: ()  async {
                            },
                            child:  const Icon(Icons.loop_rounded,color:  Color(0xff590D2B),),
                          ),
                        ),
                        const SizedBox(width: 1,),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffF9F9FB),
                Color(0xFFEFF1F3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
