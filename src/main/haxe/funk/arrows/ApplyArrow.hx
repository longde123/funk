package funk.arrows;

import funk.types.Function1;

using funk.types.Tuple2;
using funk.futures.Promise;

typedef ArrowApply<I, O> = Arrow<Tuple2<Arrow<I, O>, I>, O>;

abstract ApplyArrow<I, O>(ArrowApply<I, O>) from ArrowApply<I, O> to ArrowApply<I, O> {

    inline public function new() {
        this = new Arrow(function(tuple : Tuple2<Arrow<I, O>, I>, cont : Function1<O, Void>) {
            tuple._1().withInput(tuple._2(), function(x) cont(x));
        });
    }

    inline public function arrow() return this;

    inline public function apply(input : Tuple2<Arrow<I, O>, I>) : Promise<O> return this.apply(input);
}
