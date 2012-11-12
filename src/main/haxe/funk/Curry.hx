package funk;

import funk.Funk;
import funk.option.Any;

using funk.option.Any;

enum Curry<T1, T2, T3, T4, T5, R> {
	curry1(func : Function1<T1, R>);
	curry2(func : Function2<T1, T2, R>);
	curry3(func : Function3<T1, T2, T3, R>);
	curry4(func : Function4<T1, T2, T3, T4, R>);
	curry5(func : Function5<T1, T2, T3, T4, T5, R>);
}

class Currys {

	public static function call<T1, T2, T3, T4, T5, R>(	curry : Curry<T1, T2, T3, T4, T5, R>,
														value0 : T1) : Dynamic {
		return switch(curry) {
			case curry1(func):
				func(value0);

			case curry2(func):
				cast function(value1 : T2) {
					return func(value0, value1);
				};

			case curry3(func):
				cast function(value1 : T2) {
					return function(value2 : T3) {
						return func(value0, value1, value2);
					};
				};

			case curry4(func):
				cast function(value1 : T2) {
					return function(value2 : T3) {
						return function(value3 : T4) {
							return func(value0, value1, value2, value3);
						};
					};
				};

			case curry5(func):
				cast function(value1 : T2) {
					return function(value2 : T3) {
						return function(value3 : T4) {
							return function(value4 : T5) {
								return func(value0, value1, value2, value3, value4);
							};
						};
					};
				};
		}
	}

	public static function complete<T1, T2, T3, T4, T5, R>(	curry : Curry<T1, T2, T3, T4, T5, R>,
															?args : Array<Dynamic> = null) : R {
		return switch (curry) {
			case curry1(func):
				Reflect.callMethod(null, func, args.getOrElse(function(){
					return [null];
				}));
			case curry2(func):
				Reflect.callMethod(null, func, args.getOrElse(function(){
					return [null, null];
				}));
			case curry3(func):
				Reflect.callMethod(null, func, args.getOrElse(function(){
					return [null, null, null];
				}));
			case curry4(func):
				Reflect.callMethod(null, func, args.getOrElse(function(){
					return [null, null, null, null];
				}));
			case curry5(func):
				Reflect.callMethod(null, func, args.getOrElse(function(){
					return [null, null, null, null, null];
				}));
		}
	}

}
