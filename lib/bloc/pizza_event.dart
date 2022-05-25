part of 'pizza_bloc.dart';

abstract class PizzaEvent extends Equatable {
  const PizzaEvent();

  @override
  List<Object> get props => [];
}

class LoadPizzaCounter extends PizzaEvent {}

class AddPizza extends PizzaEvent {
  final Pizza pizza;

  AddPizza({required this.pizza});

  @override
  List<Object> get props => [pizza];
}

class RemovePizza extends PizzaEvent {
  final Pizza pizza;

  RemovePizza({required this.pizza});

  @override
  List<Object> get props => [pizza];
}
