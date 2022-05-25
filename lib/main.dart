import 'dart:math';

import 'package:bloc_study/bloc/pizza_bloc.dart';
import 'package:bloc_study/models/pizza_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //1、注册Bloc
    return MultiBlocProvider(
        providers: [
          BlocProvider<PizzaBloc>(
            create: (context) => PizzaBloc()..add(LoadPizzaCounter()),
            // create: (context) => PizzaBloc()
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'The Pizza Bloc',
          home: HomeScreen(),
        ));
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('The Pizza Bloc'),
        centerTitle: true,
        backgroundColor: Colors.orange[800],
      ),
      body: Center(
        //2、创建BlocBuilder
        child: BlocBuilder<PizzaBloc, PizzaState>(
          builder: (context, state) {
            //如果状态是初始化状态，就返回圆形加载的进度条
            if (state is PizzaInitial) {
              return CircularProgressIndicator(
                color: Colors.orange,
              );
            }
            //如果状态是加载完成的
            if (state is PizzaLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${state.pizzas.length}',  //pizza的数量
                    style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none, //不裁剪
                      children: buildContent(state),
                    ),
                  )
                ],
              );
            } else {
              return const Text('Something went wrong!');
            }
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              /**
               *   T read<T>() {
                  return Provider.of<T>(this, listen: false);
                  }
                  查询Bloc,，并调用添加Pizza事件来添加一个Pizza
               */
              context.read<PizzaBloc>().add(AddPizza(pizza: Pizza.pizzas[0]));
            },
            child: Icon(Icons.local_pizza_outlined),
            backgroundColor: Colors.orange[800],
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<PizzaBloc>().add(RemovePizza(pizza: Pizza.pizzas[0]));
            },
            child: Icon(Icons.remove),
            backgroundColor: Colors.orange[800],
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<PizzaBloc>().add(AddPizza(pizza: Pizza.pizzas[1]));
            },
            child: Icon(Icons.local_pizza_rounded),
            backgroundColor: Colors.orange[800],
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<PizzaBloc>().add(RemovePizza(pizza: Pizza.pizzas[1]));
            },
            child: Icon(Icons.remove),
            backgroundColor: Colors.orange[800],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

// 随机定位一个pizza对象
List<Widget> buildContent(state) {
  List<Widget> widgets = [];
  for (int index = 0; index < state.pizzas.length; index++) {
    widgets.add(
      Positioned(
        left: Random().nextInt(250).toDouble(),
        top: Random().nextInt(400).toDouble(),
        child: SizedBox(
          height: 150,
          width: 150,
          child: state.pizzas[index].image,
        ),
      ),
    );
  }
  return widgets;
}
