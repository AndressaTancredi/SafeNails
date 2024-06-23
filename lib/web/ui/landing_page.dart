import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            HeroSection(),
            FeaturesSection(),
            FooterSection(),
          ],
        ),
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      color: Colors.grey[200],
      child: Column(
        children: <Widget>[
          Text(
            'Mantenha sua saúde e o planeta seguros',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            'Baixe nosso aplicativo na Apple Store e Google Play Store',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  // Adicione o link da Apple Store
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                child: Text('Baixar na Apple Store'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  // Adicione o link do Google Play
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: Text('Baixar na Google Play'),
              ),
            ],
          ),
          SizedBox(height: 20),
          Image.asset(
            'assets/images/nail_polish.jpg',
            height: 400,
          ),
        ],
      ),
    );
  }
}

class FeaturesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Column(
        children: <Widget>[
          Text(
            'Funcionalidades',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FeatureItem(
                title: 'Funcionalidade 1',
                description: 'Descrição da funcionalidade 1.',
              ),
              FeatureItem(
                title: 'Funcionalidade 2',
                description: 'Descrição da funcionalidade 2.',
              ),
              FeatureItem(
                title: 'Funcionalidade 3',
                description: 'Descrição da funcionalidade 3.',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final String title;
  final String description;

  FeatureItem({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)],
        ),
        child: Column(
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              description,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class FooterSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      color: Colors.black,
      child: Text(
        '© 2024 Safe Nails. Todos os direitos reservados.',
        style: TextStyle(color: Colors.white, fontSize: 14),
        textAlign: TextAlign.center,
      ),
    );
  }
}
