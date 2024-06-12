import 'package:flutter/material.dart';

import 'package:flutter_03/widgets/expenses.dart';

var myColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 96, 59, 181), //lesson .125
);

var myDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: Color.fromARGB(255, 5, 99, 125),
); //DarkMode，lesson .128

void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: myDarkColorScheme,
        // appBarTheme: const AppBarTheme().copyWith(
        //   backgroundColor: myDarkColorScheme.onPrimaryContainer,
        //   foregroundColor: myDarkColorScheme.primaryContainer,
        // ),
        cardTheme: const CardTheme().copyWith(
          color: myDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: myDarkColorScheme.primaryContainer,
            foregroundColor: myDarkColorScheme.onPrimaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.w600,
                color: myDarkColorScheme.onSecondaryContainer,
                fontSize: 18,
              ),
            ),
      ),
      theme: ThemeData().copyWith(
        colorScheme: myColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: myColorScheme.onPrimaryContainer,
          foregroundColor: myColorScheme.primaryContainer,
        ),
        cardTheme: CardTheme().copyWith(
          color: myColorScheme.secondaryContainer,
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: myColorScheme.secondaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.w600,
                color: myColorScheme.onSecondaryContainer,
                fontSize: 18,
              ),
            ),
      ),
      //themeMode: ThemeMode.system,//default
      home: const Expenses(),
    ),
  );
}
