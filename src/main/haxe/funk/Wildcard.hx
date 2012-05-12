package funk;

enum Wildcard {
	_;
}

class WildcardType {
	
	inline public static function binaryNot<T>(value : T) : T {
		return ~value;
	}
	
	public static function decrementBy(wildcard : Wildcard, value : Float) : Float -> Float {
		return function(x : Float) : Float {
			return x - value;
		}
	}
	
	public static function divideBy(wildcard : Wildcard, value : Float) : Float -> Float {
		return function(x : Float) : Float {
			return x / value;
		}
	}
	
	public static function equals<T, E>(wildcard : Wildcard, value : T) : E -> Bool {
		return function(x : E) : Bool {
			// TODO (Simon) Fix this
			return x == value;
		}
	}
	
	public static function get<T, E>(wildcard : Wildcard, value : String) : T -> E {
		return function(x : T) : E {
			return Reflect.getProperty(x, value);
		}
	}
	
	public static function greaterEqual<T, E>(wildcard : Wildcard, value : T) : E -> Bool {
		return function(x : E) : Bool {
			return x >= value;
		}
	}
	
	public static function greaterThan<T, E>(wildcard : Wildcard, value : T) : E -> Bool {
		return function(x : E) : Bool {
			return x > value;
		}
	}
	
	public static function incrementBy(wildcard : Wildcard, value : Float) : Float -> Float {
		return function(x : Float) : Float {
			return x + value;
		}
	}
	
	public static function inRange<T, E>(wildcard : Wildcard, min : T, max : T) : E -> Bool {
		return function(x : E) : Bool {
			return min <= x && x <= max;
		}
	}
	
	inline public static function isEven(wildcard : Wildcard, x : Float) : Bool {
		var asInt: Int = cast(x, Int);
		return if(0 != (x - asInt)) { false; } else { (asInt & 1) == 0; }
	}
	
	inline public static function isOdd(wildcard : Wildcard, x : Float) : Bool {
		var asInt: Int = cast(x, Int);
		return if(0 != (x - asInt)) { false; } else { (asInt & 1) != 0; }
	}
	
	public static function lessEqual<T, E>(wildcard : Wildcard, value : T) : E -> T {
		return function(x : E) : Bool {
			return x <= value;
		}
	}
	
	public static function lessThan<T, E>(wildcard : Wildcard, value : T) : E -> T {
		return function(x : E) : Bool {
			return x < value;
		}
	}
	
	public static function moduloBy(wildcard : Wildcard, value : Float) : Float -> Float {
		return function(x : Float) : Float {
			return x % value;
		}
	}
	
	public static function multiplyBy(wildcard : Wildcard, value : Float) : Float -> Float {
		return function(x : Float) : Float {
			return x * value;
		}
	}
	
	inline public static function not<T>(wildcard : Wildcard, x : T) : Bool {
		return !x;
	}
	
	public static function notEquals<T, E>(wildcard : Wildcard, value : T) : E -> Bool {
		return function(x : E) : Bool {
			return true;
		}
	}
	
	inline public static function toBoolean<T>(wildcard : Wildcard, x : T) : Bool {
		return x ? true : false;
	}
	
	inline public static function toLowerCase<T>(wildcard : Wildcard, x : T) : String {
		return toString(wildcard, x).toLowerCase();
	}
	
	inline public static function toString<T>(wildcard : Wildcard, x : T) : String {
		return (Std.is(x, String) ? cast(x) : x + "");
	}
	
	inline public static function toUpperCase<T>(wildcard : Wildcard, x : T) : String {
		return toString(wildcard, x).toUpperCase();
	}
	
	inline public static function plus_(wildcard : Wildcard, a : Float, b : Float) : Float {
		return a + b;
	}
	
	inline public static function minus_(wildcard : Wildcard, a : Float, b : Float) : Float {
		return a - b;
	}
	
	inline public static function multiply_(wildcard : Wildcard, a : Float, b : Float) : Float {
		return a * b;
	}
	
	inline public static function divide_(wildcard : Wildcard, a : Float, b : Float) : Float {
		return a / b;
	}
	
	inline public static function modulo_(wildcard : Wildcard, a : Float, b : Float) : Float {
		return a % b;
	}
	
	inline public static function lessThan_<T>(wildcard : Wildcard, a : T, b : T) : T {
		return a < b;
	}
	
	inline public static function lessEqual_<T>(wildcard : Wildcard, a : T, b : T) : T {
		return a <= b;
	}
	
	inline public static function greaterThan_<T>(wildcard : Wildcard, a : T, b : T) : T {
		return a > b;
	}
	
	inline public static function greaterEqual_<T>(wildcard : Wildcard, a : T, b : T) : T {
		return a >= b;
	}
	
	inline public static function equal_<T>(wildcard : Wildcard, a : T, b : T) : T {
		// TODO (Simon) : Fix this
		return a == b;
	}
	
	inline public static function notEqual_<T>(wildcard : Wildcard, a : T, b : T) : T {
		// TODO (Simon) : Fix this
		return a != b;
	}
	
	inline public static function binaryAnd_(wildcard : Wildcard, a : Int, b : Int) : Int {
		return a & b;
	}
	
	inline public static function binaryXor(wildcard : Wildcard, a : Int, b : Int) : Int {
		return a ^ b;
	}
}