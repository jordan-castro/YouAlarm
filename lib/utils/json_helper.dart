typedef Json = Map<String, dynamic>;

/// Hace el parse a qualckier mierda que pasamos.
dynamic parseString(someString) {
  if (someString is String) {
    // Chequea que el string no es vacio
    if (someString.trim().length > 0) {
      return someString;
    } else {
      return null;
    }
  } else {
    // Chequea si es null
    if (someString == null) {
      return null;
    }
    return someString.toString();
  }
}

/// Parses String to integer and if for some reason you pass a integer then
/// it just returns that integer. Throws error if not integer or String/.
dynamic parseInt(someInteger) {
  try {
    return int.parse(someInteger);
  } catch (_) {
    if (someInteger is int) {
      return someInteger;
    } else {
      if (someInteger != null) {
        throw Exception("Not String or int: $someInteger");
      }
    }
  }
  return null;
}

/// Parses `String` to `double` and if for some reason you pass a `double` already
/// then it just returns that `double`. Throws error if not `double` or `String`.
dynamic parseDouble(someDouble) {
  try {
    return double.parse(someDouble);
  } catch (_) {
    if (someDouble is double) {
      return someDouble;
    } else {
      if (someDouble != null) {
        throw Exception("Not String or double: $someDouble");
      }
    }
  }
  return null;
}

/// Converts `String` to `DateTime`.
dynamic convertDateTime(String? someDateString) {
  try {
    // Split off the seconds and split the year-month-day
    List<String> dateStringList = someDateString!.split(" ")[0].split("-");

    // One line that bitch!
    List<int> date = [
      for (var x = 0; x < dateStringList.length; x++)
        parseInt(dateStringList[x])
    ];

    // Check if date is even passed in.
    if (date[0] == 0) {
      return null;
    }

    return DateTime(date[0], date[1], date[2]);
  } catch (_) {
    return null;
  }
}

/// This returns a bool from a [String] or [int]
bool parseBool(someBoolean) {
  var value = null;
  // Checking if string to convert
  if (someBoolean is String) {
    value = int.tryParse(someBoolean);
  } else if (someBoolean == null) {
    return false;
  }

  // 1 is true
  return value == 1;
}

/// Parse JSON data dynamically.
///
/// **Params**
/// - `Map<dynamic, dynamic> json` the json to parse.
/// - `dynamic keyFrom` the key to be converted.
/// - `dynamic keyTo` the key to convert to.
dynamic parseJson(Map json, keyFrom, keyTo) {
  // Create a new map
  Map<dynamic, dynamic> parsedJson = {};
  parsedJson.addAll(json);

  if (parsedJson.containsKey(keyFrom)) {
    parsedJson[keyTo] = parsedJson[keyFrom];
  }

  // Return the new map
  return parsedJson;
}

Duration? parseDuration(someDuration) {
  if (someDuration is Duration) {
    return someDuration;
  }

  if (someDuration is int) {
    // Convert
    return Duration(milliseconds: someDuration);
  }

  return null;
}
