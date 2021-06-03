import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class BrasilUtil {
  static final String locale = 'pt_BR';

  static formatCurrency(double currency) {
    return NumberFormat.currency(locale: locale, symbol: 'R\$')
        .format(currency);
  }

  static formatCurrencyWithoutSymbol(double currency) {
    return NumberFormat.currency(locale: locale, symbol: '')
        .format(currency);
  }

  static formatLongDate(DateTime dateTime) {
    initializeDateFormatting(locale);
    return DateFormat('d MMMM y', locale).format(dateTime);
  }

  static formatShortDate(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  static String weekDay(DateTime dateTime) {
    initializeDateFormatting(locale);
    return DateFormat.E(locale).format(dateTime);
  }

  static bool datesIsEqual(DateTime date1, DateTime date2) {
    return date1.day == date2.day &&
        date1.month == date2.month &&
        date1.year == date2.year;
  }

  static toDateTimeFromShortDate(String date) {
    if (date.isEmpty) {
      return null;
    }
    return DateFormat('dd/MM/yyyy').parse(date);
  }
}
