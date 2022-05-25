import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Pizza extends Equatable {
  final String id;
  final String name;
  final Image image;

  const Pizza(this.id, this.name, this.image);

  // Equatable
  @override
  List<Object?> get props => [id, name, image];

  static List<Pizza> pizzas = [
    Pizza('0', 'Pizza0', Image.asset("images/pizza0.jpg")),
    Pizza('1', 'Pizza1', Image.asset("images/pizza1.jpg")),
  ];
}