import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List todoList = [
    ['Добавьте задачу..', false]
  ];

  TextEditingController _contrroler = TextEditingController();

  void todoChanged(int index) {
    setState(() {
      todoList[index][1] = !todoList[index][1];
    });
  }

  void todoAdd() {
    setState(() {
      todoList.add([_contrroler.text, false]);
      _contrroler.clear();
    });
  }

  void todoDel(int index) {
    setState(() {
      todoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'MY TODO',
            style: GoogleFonts.ubuntu(
              fontWeight: FontWeight.bold, 
              fontSize: 28
            ),
          ),
          centerTitle: true,
        ),

        body: Container(
          child: ListView.builder(
            itemCount: todoList.length,

            itemBuilder:
                (context, index) => TodoBody(
                  task: (todoList[index][0].toString().isEmpty) 
                  ? 'хмм.. Здесь пусто' 
                  : todoList[index][0],

                  status: todoList[index][1],
                  onChanged: (value) => todoChanged(index),
                  delTodo: (value) => todoDel(index),
                ),
          ),
        ),

        floatingActionButton: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 25,
                  left: 25,
                  bottom: 10,
                  top: 10,
                ),

                child: TextField(
                  controller: _contrroler,

                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(width: 1.8, color: Colors.grey),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(width: 2, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),

            FloatingActionButton(
              onPressed: todoAdd,
              backgroundColor: Colors.grey[800],
              child: Icon(Icons.add, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class TodoBody extends StatelessWidget {
  const TodoBody({
    super.key,
    required this.task,
    required this.status,
    this.onChanged, this.delTodo,
  });

  final String task;
  final bool status;
  final Function(bool?)? onChanged;
  final Function(BuildContext?)? delTodo;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),

      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(), 
          children: [
            SlidableAction(
              onPressed: delTodo,
              icon: Icons.delete,
              ),
          ]
        ),

        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(10),
          ),
        
          child: Row(
            children: [
              Checkbox(
                value: status,
                onChanged: onChanged,
                activeColor: Colors.white,
                checkColor: Colors.green,
                side: BorderSide(color: Colors.grey),
              ),

              Text(
                task, 
                style: GoogleFonts.rubik(
                  color: Colors.white, 
                  fontSize: 22,

                  decoration: status 
                  ? TextDecoration.lineThrough 
                  : TextDecoration.none,
                  decorationColor: Colors.white
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
