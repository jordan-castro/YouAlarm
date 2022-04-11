// This file handles reading the days from an alarm.
// ignore_for_file: constant_identifier_names

const SUNDAY = "su";
const MONDAY = "mo";
const TUESDAY = "tu";
const WEDNESDAY = "we";
const THURSDAY = "th";
const FRIDAY = "fr";
const SATURDAY = "sa";

/// Check if the day is in the String.
bool isOfDay(String day, String dayString) {
  return dayString.contains(day);
}