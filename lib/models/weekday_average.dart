class WeekdayAverage {
  final double average;
  final DateTime date;

  WeekdayAverage(DateTime d, this.average)
      : date = DateTime(d.year, d.month, d.day);
}
