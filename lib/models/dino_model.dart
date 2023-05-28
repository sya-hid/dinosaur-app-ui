import 'package:flutter/material.dart';

class DinoModel {
  final String image, name;
  final Color color;
  final Detail? detail;

  DinoModel(
      {required this.image,
      required this.name,
      required this.color,
      this.detail});
}

List<DinoModel> dinos = [
  DinoModel(
    image: 'assets/Triceratops.png',
    name: 'Triceratops',
    color: const Color(0xFFC7832B),
  ),
  DinoModel(
    image: 'assets/Stegosaurus.png',
    name: 'Stegosaurus',
    color: const Color(0xFFCC5523),
  ),
  DinoModel(
    image: 'assets/T.Rex.png',
    name: 'T.Rex',
    color: const Color(0xFFE18838),
    detail: Detail(
        fact:
            'Tyrannosaurus Rex had powerful back legs that let it hunt prey over short distances at up to 20mph (32 kph). They would have charged out of the undergrowth to surprise their prey - and their flexible neck helped them adjust the angle of attack.',
        sceleton: 'assets/T.Rex_.png',
        length: 40.7,
        weight: 16,
        sprint: 32),
  ),
  DinoModel(
    image: 'assets/Diplodocus.png',
    name: 'Diplodocus',
    color: const Color(0xFF7B9F0D),
  ),
  DinoModel(
    image: 'assets/Pterosaurs.png',
    name: 'Pterosaurs',
    color: const Color(0xFF515063),
  ),
];

class Detail {
  final String fact, sceleton;
  final double length, weight, sprint;

  Detail(
      {required this.fact,
      required this.sceleton,
      required this.length,
      required this.weight,
      required this.sprint});
}
