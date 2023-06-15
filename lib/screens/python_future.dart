import 'package:flutter/material.dart';
import 'package:guidance/models/language.dart';

class FutureScreen extends StatelessWidget {
  final Language language;

  const FutureScreen({super.key, required this.language});

  static const routeName = "/future_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${language.title} Career'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child:
        language.id == 1 ?
        pythonColumns() : language.id == 2 ?
        rubyColumn() : scratchColumn(),
      ),
    );
  }

  Column rubyColumn() {
    return const Column(children: [
      Card(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'If a kid finishes a Ruby programming language course, they can pursue a career as a Ruby developer. As a Ruby developer, they can work on various projects such as web applications, mobile applications, and games. They can also work in various industries such as finance, healthcare, e-commerce, and more.',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ),
    ],);
  }

  scratchColumn() {}

  Column pythonColumns() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Python is a versatile and widely-used programming language that is used in a variety of industries, including software development, data science, artificial intelligence, web development, and more.',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ),
        SizedBox(height: 16.0),
        Text(
          'Some examples of careers that use Python include:',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.0),
        CareerCard(
          title: 'Software Developer',
          description:
          'Python is a popular language used by many companies to create software, mobile apps, and video games. As a software developer, kids can use Python to create new programs, fix bugs, and improve existing software.',
        ),
        CareerCard(
          title: 'Data Analyst',
          description:
          'Python is an excellent tool for data analysis and visualization. As a data analyst, kids can use Python to analyze and interpret large sets of data, and create visualizations that help businesses make informed decisions.',
        ),
        CareerCard(
          title: 'Artificial Intelligence/ML Engineer',
          description:
          'Python is widely used in the field of artificial intelligence and machine learning. As an AI/ML engineer, kids can use Python to build models that can recognize images, translate languages, and make predictions.',
        ),
        CareerCard(
          title: 'Web Developer',
          description:
          'Python can be used to build dynamic websites and web applications. As a web developer, kids can use Python to create interactive websites, user interfaces, and web services.',
        ),
        CareerCard(
          title: 'Cyber security Specialist',
          description:
          'Python can also be used for cyber security purposes, such as building security tools, detecting vulnerabilities, and analyzing security data.',
        ),
        SizedBox(height: 16.0),
        Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'By learning Python, kids can gain valuable skills that can prepare them for exciting careers in these fields and more. As technology continues to advance, the demand for skilled programmers and developers will only increase, making Python a valuable tool for kids who want to pursue a career in technology.',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ),
      ],
    );
  }
}

class CareerCard extends StatelessWidget {
  final String title;
  final String description;

  const CareerCard({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style:
              const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              description,
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
