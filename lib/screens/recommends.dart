import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RecommendationScreen extends StatelessWidget {
  static const routeName = "/recommendation";

  List<Recommendation> recommendations = [
    Recommendation(
      name: 'Python Projects for Kids',
      description:
          'Offers a variety of fun and engaging Python projects for kids to work on, including games, animations, and simple apps.',
      image: 'assets/python_projects.png',
      link: 'https://nostarch.com/pythonprojects',
    ),
    Recommendation(
      name: 'Pygame',
      description:
          'A Python library for creating games and interactive programs. Perfect for kids who want to build their own games.',
      image: 'assets/pygame.png',
      link: 'https://www.pygame.org/news',
    ),
    Recommendation(
      name: 'Codecademy',
      description:
          'An interactive online platform for learning Python and other programming languages. Provides step-by-step tutorials and projects.',
      image: 'assets/codecademy.png',
      link: 'https://www.codecademy.com/learn/learn-python-3',
    ),
    Recommendation(
      name: 'Scratch',
      description:
          'A block-based programming language designed specifically for kids. Allows building animations, games, and interactive stories.',
      image: 'assets/scratch.png',
      link: 'https://scratch.mit.edu/',
    ),
    Recommendation(
      name: 'Django Girls',
      description:
          'A non-profit organization that offers free workshops and resources to help kids and young adults learn to build web applications with Python and Django.',
      image: 'assets/django_girls.png',
      link: 'https://djangogirls.org/',
    ),
  ];

  RecommendationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Resources'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: recommendations.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  String url = recommendations[index].link;
                  if (!await launchUrl(Uri.parse(url))) {
                    throw Exception('Could not launch $url');
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Card(
                    child: ListTile(
                      title: Text(recommendations[index].name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text(recommendations[index].description),
                          const SizedBox(height: 10),
                          Text(
                            recommendations[index].link,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class Recommendation {
  final String name;
  final String description;
  final String image;
  final String link;

  Recommendation({
    required this.name,
    required this.description,
    required this.image,
    required this.link,
  });
}
