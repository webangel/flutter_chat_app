import 'package:flutter/material.dart';

class CounterScreem extends StatefulWidget {
  const CounterScreem({super.key, required this.title});

  final String title;

  @override
  State<CounterScreem> createState() => _CounterScreemState();
}

class _CounterScreemState extends State<CounterScreem> {
  int _counter = 0;

  void _incrementCounter() {
    _counter++;
    setState(() {});
  }

  void _decrementCounter() {
    if (_counter == 0) return;
    _counter--;
    setState(() {});
  }

  void _resetCounter() {
    _counter = 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Text('$_counter', style: TextStyle(fontSize: 70)),
            Text('Has pulsado el botón $_counter cantidad de veces'),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomButton(icon: Icons.add, onPressed: _incrementCounter),
          SizedBox(height: 16),
          CustomButton(icon: Icons.remove, onPressed: _decrementCounter),
          SizedBox(height: 16),
          CustomButton(icon: Icons.restart_alt, onPressed: _resetCounter),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  const CustomButton({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      tooltip: 'Increment',
      child: Icon(icon),
    );
  }
}
