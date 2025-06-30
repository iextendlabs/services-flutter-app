import 'package:flutter/material.dart';
import 'quotemodel.dart'; // This defines the Quote class

class QuotesRepository {
  static final ValueNotifier<List<Quote>> quotes = ValueNotifier<List<Quote>>(
    [],
  );
  // Use quotes.value = [...] to update the list elsewhere in your app
}
