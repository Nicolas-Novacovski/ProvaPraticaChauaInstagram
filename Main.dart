import 'package:flutter/material.dart';

void main() {
  runApp(const InstagramCloneApp());
}

class InstagramCloneApp extends StatelessWidget {
  const InstagramCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Home Clone',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
      ),
      home: const InstagramHomePage(),
    );
  }
}

class InstagramHomePage extends StatelessWidget {
  const InstagramHomePage({super.key});

  static final List<Map<String, String>> stories = [
    {'name': 'Seu story', 'image': 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=200'},
    {'name': 'fulano', 'image': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200'},
    {'name': 'beltrano', 'image': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200'},
    {'name': 'ciclano', 'image': 'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?w=200'},
    {'name': 'fulano2', 'image': 'https://images.unsplash.com/photo-1527980965255-d3b416303d12?w=200'},
    {'name': 'beltrano2', 'image': 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=200'},
  ];

  static final List<Map<String, String>> posts = [
    {
      'user': 'fulano',
      'avatar': 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=200',
      'image': 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=900',
      'location': 'Brasil',
      'likes': '152 curtidas',
      'caption': 'Mais um dia normal, só vivendo e postando qualquer coisa por aqui.',
      'comments': 'Ver todos os 12 comentários',
      'time': 'HÁ 2 HORAS'
    },
    {
      'user': 'beltrano',
      'avatar': 'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?w=200',
      'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=900',
      'location': 'Praia qualquer',
      'likes': '89 curtidas',
      'caption': 'Saindo um pouco da rotina pra ver se a cabeça descansa.',
      'comments': 'Ver todos os 8 comentários',
      'time': 'HÁ 5 HORAS'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 14,
        title: const Text(
          'Instagram',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.w500,
            fontFamily: 'Billabong',
          ),
        ),
        actions: const [
          Icon(Icons.favorite_border, color: Colors.black, size: 28),
          SizedBox(width: 18),
          Icon(Icons.chat_bubble_outline, color: Colors.black, size: 27),
          SizedBox(width: 14),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 110,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              scrollDirection: Axis.horizontal,
              itemCount: stories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final story = stories[index];
                return StoryItem(
                  name: story['name']!,
                  imageUrl: story['image']!,
                  isOwnStory: index == 0,
                );
              },
            ),
          ),
          const Divider(height: 1, thickness: 0.4),
          ...posts.map((post) => PostCard(post: post)),
        ],
      ),
      bottomNavigationBar: Container(
        height: 62,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFE5E5E5), width: 0.7)),
        ),
        child: const SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.home_filled, size: 31, color: Colors.black),
              Icon(Icons.search, size: 31, color: Colors.black),
              Icon(Icons.add_box_outlined, size: 30, color: Colors.black),
              Icon(Icons.movie_outlined, size: 30, color: Colors.black),
              CircleAvatar(
                radius: 14,
                backgroundImage: NetworkImage('https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=200'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StoryItem extends StatelessWidget {
  final String name;
  final String imageUrl;
  final bool isOwnStory;

  const StoryItem({
    super.key,
    required this.name,
    required this.imageUrl,
    this.isOwnStory = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72,
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: isOwnStory
                      ? null
                      : const LinearGradient(
                          colors: [Color(0xFFFEDA75), Color(0xFFFA7E1E), Color(0xFFD62976), Color(0xFF962FBF)],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        ),
                  border: isOwnStory ? Border.all(color: Colors.grey.shade300, width: 1) : null,
                ),
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: CircleAvatar(
                    radius: 29,
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                ),
              ),
              if (isOwnStory)
                Positioned(
                  right: 2,
                  bottom: 2,
                  child: Container(
                    width: 21,
                    height: 21,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 14),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            name,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final Map<String, String> post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(post['avatar']!),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post['user']!,
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                    ),
                    Text(
                      post['location']!,
                      style: const TextStyle(fontSize: 12, color: Colors.black87),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.more_horiz, color: Colors.black),
            ],
          ),
        ),
        AspectRatio(
          aspectRatio: 1,
          child: Image.network(
            post['image']!,
            width: double.infinity,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                color: Colors.grey.shade200,
                child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
          child: Row(
            children: const [
              Icon(Icons.favorite_border, size: 29),
              SizedBox(width: 15),
              Icon(Icons.mode_comment_outlined, size: 27),
              SizedBox(width: 15),
              Icon(Icons.send_outlined, size: 27),
              Spacer(),
              Icon(Icons.bookmark_border, size: 29),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 9, 12, 0),
          child: Text(
            post['likes']!,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 5, 12, 0),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black, fontSize: 14, height: 1.25),
              children: [
                TextSpan(
                  text: '${post['user']} ',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                TextSpan(text: post['caption']),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 6, 12, 0),
          child: Text(
            post['comments']!,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 6, 12, 16),
          child: Text(
            post['time']!,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 10, letterSpacing: 0.4),
          ),
        ),
      ],
    );
  }
}
