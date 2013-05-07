package funk.arrows;

import funk.arrows.ApplyArrow;
import funk.arrows.EitherArrow;
import funk.arrows.LeftChoiceArrow;
import funk.arrows.OrArrow;
import funk.arrows.RepeatArrow;
import funk.arrows.RightChoiceArrow;
import funk.futures.Deferred;
import funk.types.Either;
import funk.types.Function2;
import funk.types.Tuple2;

using funk.types.Option;
using funk.futures.Promise;
using funk.types.Function1;

typedef ArrowFunction<I, O> = Function2<I, Function1<O, Void>, Void>;
    
abstract Arrow<I, O>(ArrowFunction<I, O>) {

    inline public function new(func : ArrowFunction<I, O>) {
        this = func;
    }

    public static function unit<I>() : Arrow<I, I> return Arrow1.lift(function(x : I) : I return x);

    public static function pure<I, O>(value : O) : Arrow<I, O> return Arrow1.lift(function(x : I) : O return value);

    public static function future<I>() : Arrow<Promise<I>, I> return new FutureArrow();

    inline public function withInput(input : I, cont : Function1<O, Void>) : Void (this)(input, cont);

    inline public function apply(input : I) : Promise<O> {
        var deferred = new Deferred();
        var promise = deferred.promise();
        withInput(this, input, deferred.resolve.effectOf());
        return promise;
    }
}

class ArrowTypes {

    public static function apply<I, O>() : ArrowApply<I, O> return new ApplyArrow();

    public static function arrowOf<I, O>(func : Function1<I, Promise<O>>) : Arrow<I, O> {
        var arrow : Arrow<I, Promise<O>> = Arrow1.lift(func);
        return then(arrow, Arrow.future());
    }

    public static function either<A, B>(a : Arrow<A, B>, b : Arrow<A, B>) : Arrow<A, B> return new EitherArrow(a, b);

    public static function left<A, B, C>(arrow : Arrow<A, B>) : ArrowLeftChoice<A, B, C> {
        return new LeftChoiceArrow(arrow);
    }

    public static function option<I, O>(arrow : Arrow<I, O>) : Arrow<Option<I>, Option<O>> {
        return new OptionArrow(arrow);
    }

    public static function or<L, R, P>(left : Arrow<L, P>, right : Arrow<R, P>) : ArrowOr<L, R, P> {
        return new OrArrow(left, right);
    }

    public static function repeat<I, O>(arrow : Arrow<I, Repetition<I, O>>) : Arrow<I, O> return new RepeatArrow(arrow);

    public static function right<A, B, C>(arrow : Arrow<A, B>) : ArrowRightChoice<A, B, C> {
        return new RightChoiceArrow(arrow);
    }

    public static function then<A, B, C>(before : Arrow<A, B>, after : Arrow<B, C>) : Arrow<A, C> {
        return new ThenArrow(before, after);
    }
}

class Arrow1 {

    public static function lift<T1, R>(func : Function1<T1, R>) : Arrow<T1, R> {
        return new Arrow(function(input : T1, cont : Function1<R, Void>) cont(func(input)));
    }
}