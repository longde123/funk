package funk.types;

import funk.types.Any;
import funk.types.extensions.EnumValues;

enum Tuple4Type<T1, T2, T3, T4> {
    tuple4(t1 : T1, t2 : T2, t3 : T3, t4 : T4);
}

abstract Tuple4<T1, T2, T3, T4>(Tuple4Type<T1, T2, T3, T4>)
                                                            from Tuple4Type<T1, T2, T3, T4>
                                                            to Tuple4Type<T1, T2, T3, T4>
                                                            {

    inline function new(tuple : Tuple4Type<T1, T2, T3, T4>) {
        this = tuple;
    }

    inline public function _1() : T1 {
        return Tuple4Types._1(this);
    }

    inline public function _2() : T2 {
        return Tuple4Types._2(this);
    }

    inline public function _3() : T3 {
        return Tuple4Types._3(this);
    }

    inline public function _4() : T4 {
        return Tuple4Types._4(this);
    }

    @:to
    inline public static function toString<T1, T2, T3, T4>(tuple : Tuple4Type<T1, T2, T3, T4>) : String {
        return Tuple4Types.toString(tuple);
    }
}

class Tuple4Types {

    public static function _1<T1, T2, T3, T4>(tuple : Tuple4<T1, T2, T3, T4>) : T1 {
        return EnumValues.getValueByIndex(tuple, 0);
    }

    public static function _2<T1, T2, T3, T4>(tuple : Tuple4<T1, T2, T3, T4>) : T2 {
        return EnumValues.getValueByIndex(tuple, 1);
    }

    public static function _3<T1, T2, T3, T4>(tuple : Tuple4<T1, T2, T3, T4>) : T3 {
        return EnumValues.getValueByIndex(tuple, 2);
    }

    public static function _4<T1, T2, T3, T4>(tuple : Tuple4<T1, T2, T3, T4>) : T4 {
        return EnumValues.getValueByIndex(tuple, 3);
    }

    public static function equals<T1, T2, T3, T4>(  a : Tuple4<T1, T2, T3, T4>,
                                                    b : Tuple4<T1, T2, T3, T4>,
                                                    ?func1 : Predicate2<T1, T1>,
                                                    ?func2 : Predicate2<T2, T2>,
                                                    ?func3 : Predicate2<T3, T3>,
                                                    ?func4 : Predicate2<T4, T4>
                                                    ) : Bool {
        return switch (a) {
            case tuple4(t1_0, t2_0, t3_0, t4_0):
                switch (b) {
                    case tuple4(t1_1, t2_1, t3_1, t4_1):
                        AnyTypes.equals(t1_0, t1_1, func1) && AnyTypes.equals(t2_0, t2_1, func2) &&
                            AnyTypes.equals(t3_0, t3_1, func3) && AnyTypes.equals(t4_0, t4_1, func4);
                    case _: false;
                }
            case _: false;
        }
    }

    public static function join<T1, T2, T3, T4>(tuple : Tuple4<T1, T2, T3, T4>) : String {
        return '${AnyTypes.toString(_1(tuple))}${AnyTypes.toString(_2(tuple))}${AnyTypes.toString(_3(tuple))}${AnyTypes.toString(_4(tuple))}';
    }

    public static function toArray<T1, T2, T3, T4>(tuple : Tuple4<T1, T2, T3, T4>) : Array<Dynamic> {
        return EnumValues.getValues(tuple);
    }

    public static function toString<T1, T2, T3, T4>(    tuple : Tuple4<T1, T2, T3, T4>,
                                                        ?func0 : Function1<T1, String>,
                                                        ?func1 : Function1<T2, String>,
                                                        ?func2 : Function1<T3, String>,
                                                        ?func3 : Function1<T4, String>
                                                        ) : String {
        return '(${AnyTypes.toString(_1(tuple), func0)}, ${AnyTypes.toString(_2(tuple), func1)}, ${AnyTypes.toString(_3(tuple), func2)}, ${AnyTypes.toString(_4(tuple), func3)})';
    }
}
