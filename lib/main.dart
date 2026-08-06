import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Spotify UI",
      home: const MusicPlayerPage(),
    );
  }
}

class MusicPlayerPage extends StatefulWidget {
  const MusicPlayerPage({super.key});

  @override
  State<MusicPlayerPage> createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage> {
  double progress = 0.42;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff8C6036),
              Color(0xff2A1A0E),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                //-----------------------------------
                // Top Arrow
                //-----------------------------------
                const Center(
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                    size: 35,
                  ),
                ),

                const SizedBox(height: 20),

                //-----------------------------------
                // Album Cover
                //-----------------------------------
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.asset(
                    "lib/photo.png",
                    width: double.infinity,
                    height: 360,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(height: 25),

                //-----------------------------------
                // Song Info
                //-----------------------------------
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Akasaka Sad",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Rina Sawayama",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add_circle_outline,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

                //-----------------------------------
                // Slider
                //-----------------------------------
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 7,
                    ),
                  ),
                  child: Slider(
                    value: progress,
                    activeColor: Colors.white,
                    inactiveColor: Colors.white24,
                    onChanged: (value) {
                      setState(() {
                        progress = value;
                      });
                    },
                  ),
                ),

                //-----------------------------------
                // Time
                //-----------------------------------
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "1:19",
                      style: TextStyle(color: Colors.white70),
                    ),
                    Text(
                      "-1:39",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                //-----------------------------------
                // Controls
                //-----------------------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(
                      Icons.shuffle,
                      color: Colors.white,
                      size: 26,
                    ),
                    const Icon(
                      Icons.skip_previous,
                      color: Colors.white,
                      size: 38,
                    ),
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.pause,
                          size: 38,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.skip_next,
                      color: Colors.white,
                      size: 38,
                    ),
                    const Icon(
                      Icons.repeat,
                      color: Colors.white,
                      size: 26,
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                //-----------------------------------
                // Device
                //-----------------------------------
                const Row(
                  children: [
                    Icon(
                      Icons.bluetooth,
                      color: Colors.green,
                      size: 18,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "AirPods Max",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                //-----------------------------------
                // Device & Track Meta
                //-----------------------------------
                const Row(
                  children: [
                    Icon(
                      Icons.queue_music,
                      color: Colors.white,
                      size: 22,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "SAWAYAMA",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.nightlight_round,
                      color: Colors.white,
                      size: 22,
                    ),
                    SizedBox(width: 16),
                    Icon(
                      Icons.ios_share,
                      color: Colors.white,
                      size: 22,
                    ),
                  ],
                ),

                const SizedBox(height: 50),

                //-----------------------------------
                // Lyrics Card
                //-----------------------------------
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xffC7A273),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Lyrics",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.black26,
                        child: Icon(
                          Icons.open_in_full,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}