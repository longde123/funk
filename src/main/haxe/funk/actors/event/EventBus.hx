package funk.actors.event;

using funk.collections.immutable.List;
using funk.types.Tuple2;
using funk.types.Any;
using funk.types.AnyRef;
using funk.types.Option;

typedef EventBus = {

    function subscribe(subscriber : ActorRef) : Bool;

    function unsubscribe(subscriber : ActorRef) : Bool;

    function publish(event : EnumValue, subscriber : ActorRef) : Void;
};

class LookupClassification {

    private var _subscribers : List<Tuple2<Class<AnyRef>, ActorRef>>;

    public function new() {
        _subscribers = Nil;
    }

    public function subscribe(subscriber : ActorRef, to : Class<AnyRef>) : Bool {
        var found = _subscribers.find(function(tuple) {
            return (tuple._2() == subscriber && (!AnyTypes.toBool(to) || tuple._1() == to));
        });

        return if (found.isEmpty()) {
            _subscribers = _subscribers.prepend(tuple2(to, subscriber));
            true;
        } else false;
    }

    public function unsubscribe(subscriber : ActorRef, ?from : Class<AnyRef>) : Bool {
        var original = _subscribers;
        _subscribers = original.filterNot(function(tuple : Tuple2<Class<AnyRef>, ActorRef>) {
            return (tuple._2() == subscriber && (!AnyTypes.toBool(from) || tuple._1() == from));
        });
        return _subscribers == original;
    }

    public function publish(event : EnumValue, subscriber : ActorRef) : Void {
    }

    public function publishEvent(event : EnumValue) : Void {
        var list = _subscribers.filter(function(tuple : Tuple2<Class<AnyRef>, ActorRef>) {
            return tuple._1() == event;
        });
        while(list.nonEmpty()) {
            var head = list.head();
            publish(event, head._2());
            list = list.tail();
        }
    }
}
