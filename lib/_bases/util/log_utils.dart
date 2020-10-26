import 'dart:developer';

void logWithDots(String args1, String args2, String state, {error}) {
  log(
      '$args1 ${dots(args1, args2)} $state',
      name: args2,
      time: DateTime.now(),
      error: error
  );
}

String dots(String args1, String args2) {
  String dots = '';
  for(int i=100; i>=args1.length+args2.length; i--) {
    dots += '.';
  }
  return dots;
}

Future<bool> logProcess({String name, Function function}) async {
  try {
    bool isSuccess = await function() ;
    if(isSuccess) {
      logWithDots(name, 'Initializer.$name', 'success');
    } else {
      logWithDots(name, 'Initializer.$name', 'failed');
    }
    return isSuccess;
  } catch(error) {
    logWithDots(name, 'Initializer.$name', 'failed', error: error);
    return false;
  }
}

void debug(String title, {error}) {
  log(
      title,
      name: '[DEBUG]',
      time: DateTime.now(),
      error: error
  );
}