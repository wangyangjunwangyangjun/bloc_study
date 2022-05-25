import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/pizza_model.dart';

part 'pizza_event.dart';

part 'pizza_state.dart';

class PizzaBloc extends Bloc<PizzaEvent, PizzaState> {
  /**
   * super(PizzaInitial())是将PizzaInitial()返回的结果传递给父类Bloc的构造器
   */
  PizzaBloc() : super(PizzaInitial()) {
    /**
     * void on<E extends Event>(
        EventHandler<E, State> handler, {
        EventTransformer<E>? transformer,
        })
     */
    on<LoadPizzaCounter>(
      (event, emit) async {
        //等待一秒
        await Future<void>.delayed(Duration(seconds: 1));
        //生成加载Pizza的状态
        emit(PizzaLoaded(pizzas: <Pizza>[]));
      },
    );
    on<AddPizza>(
      (event, emit) {
        if (state is PizzaLoaded) {
          final state = this.state as PizzaLoaded;
          emit(PizzaLoaded(
            pizzas: List.from(state.pizzas)..add(event.pizza),
          ));
        }
      },
    );

    /**
     * 如果当前状态是PizzaLoaded的状态，
     * 那么将emit引发一个新的状态PizzaLoaded，
     * 里面的内容将发生变化，即移除一个pizza
     */
    on<RemovePizza>(
      (event, emit) {
        if (state is PizzaLoaded) {
          final state = this.state as PizzaLoaded;
          emit(PizzaLoaded(
            pizzas: List.from(state.pizzas)..remove(event.pizza),
          ));
        }
      },
    );
  }
}
