package funk.signals;

import funk.Funk;

using funk.signals.Signal0;
using funk.types.Function0;
using funk.types.PartialFunction0;
using funk.types.Option;
using funk.ds.immutable.List;

class PrioritySignal0 extends Signal0 {

    public function new() {
        super();
    }

    public function addWithPriority(func : PartialFunction0<Void>, ?priority : Int = 0) : Option<Slot0> {
        return registerListenerWithPriority(func, false, priority);
    }

    public function addOnceWithPriority(    func : PartialFunction0<Void>,
                                            ?priority:Int = 0) : Option<Slot0> {
        return registerListenerWithPriority(func, true, priority);
    }

    private function registerListenerWithPriority(  func : PartialFunction0<Void>,
                                                    once : Bool,
                                                    priority : Int) : Option<Slot0> {
        if(registrationPossible(func, once)) {
            var added : Bool = false;
            var slot : Slot0 = new PrioritySlot0(this, func, once, priority);

            _list = _list.flatMap(function(value : Slot0) {
                var prioritySlot : PrioritySlot0 = cast value;

                var list = Nil.prepend(value);
                return if(priority >= prioritySlot.priority()) {
                    added = true;
                    list.append(slot);
                } else list;
            });

            if(!added) _list = _list.prepend(slot);

            return Some(slot);
        }

        return _list.find(function(s : Slot0) : Bool return s.listener() == func);
    }
}

class PrioritySlot0 extends Slot0 {

    private var _priority : Int;

    public function new(signal : Signal0, listener : PartialFunction0<Void>, once : Bool, priority : Int) {
        super(signal, listener, once);

        _priority = priority;
    }

    inline public function priority() : Int return _priority;
}
