// import 'package:flutter/material.dart';
//
// enum TransactionType { income, expense }
//
// class Balance {
//   TransactionType type = .income;
//   static double _balance = 0;
//   static double _income = 0;
//   static double _expense = 0;
//
//   static double getbalance() {
//     return _balance;
//   }
//
//   static void setBalance(int bal) {
//     _balance += bal;
//   }
//
//   static double getIncome() {
//     return _income;
//   }
//
//   static void setIncome(int bal) {
//     _income += bal;
//     _balance += bal;
//   }
//
//   static double getExpense() {
//     if(_expense == 0 || _expense < 0){
//       return _expense;
//     }
//     return -_expense;
//   }
//
//   static void setExpense(int bal) {
//     _balance -= bal;
//     _expense -= bal;
//   }
//
//   static void addIncome(int bal) {
//     setIncome(bal);
//   }
//
//   static void addExpense(int bal) {
//     setExpense(bal);
//   }
// }
