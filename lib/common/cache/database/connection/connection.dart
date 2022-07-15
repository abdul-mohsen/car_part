// We use a conditional export to expose the right connection factory depending
// on the platform.

export 'unsupported.dart'
    if (dart.library.html) 'web.dart'
    if (dart.library.ffi) 'native.dart';
