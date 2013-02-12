package funk.io.logging.extensions;

import funk.io.logging.Log;
import funk.io.logging.LogLevel;
import funk.reactive.Stream;
import funk.types.Tuple2;

using funk.io.logging.extensions.LogLevels;
using funk.reactive.extensions.Streams;
using funk.types.extensions.Tuples2;

class Logs {

	public static function log<T>(output : LogLevel<T>) : LogLevel<T> {
		Log.streamIn().dispatch(output);
		return output;
	}

    public static function trace<T>(output : T) : T {
        log(Trace(Data(output)));
        return output;
    }

    public static function traceWithValue<T>(output : T, value : String) : T {
        log(Trace(DataWithValue(output, value)));
        return output;
    }

    public static function debug<T>(output : T) : T {
        log(Debug(Data(output)));
        return output;
    }

    public static function debugWithValue<T>(output : T, value : String) : T {
        log(Debug(DataWithValue(output, value)));
        return output;
    }

    public static function info<T>(output : T) : T {
        log(Info(Data(output)));
        return output;
    }

    public static function infoWithValue<T>(output : T, value : String) : T {
        log(Info(DataWithValue(output, value)));
        return output;
    }

    public static function warn<T>(output : T) : T {
        log(Warn(Data(output)));
        return output;
    }

    public static function warnWithValue<T>(output : T, value : String) : T {
        log(Warn(DataWithValue(output, value)));
        return output;
    }

    public static function error<T>(output : T) : T {
        log(Error(Data(output)));
        return output;
    }

    public static function errorWithValue<T>(output : T, value : String) : T {
        log(Error(DataWithValue(output, value)));
        return output;
    }

    public static function fatal<T>(output : T) : T {
        log(Fatal(Data(output)));
        return output;
    }

    public static function fatalWithValue<T>(output : T, value : String) : T {
        log(Fatal(DataWithValue(output, value)));
        return output;
    }
}