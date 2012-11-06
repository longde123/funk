package funk.signal;

import funk.signal.PrioritySignal0;

import massive.munit.Assert;
import massive.munit.AssertExtensions;

using massive.munit.Assert;
using massive.munit.AssertExtensions;

class PrioritySignal0Test {

	private var signal : PrioritySignal0;

	@Before
	public function setup() {
		signal = new PrioritySignal0();
	}

	@After
	public function tearDown() {
		signal = null;
	}

	@Test
	public function when_adding_two_items_with_larger_priority__should_dispatch_in_order() : Void {
		var called0 = false;
		var called1 = false;

		signal.addWithPriority(function(){
			called0 = true;
		}, 1);
		signal.addWithPriority(function(){
			if(called0) {
				called1 = true;
			}
		}, 2);
		signal.dispatch();

		called1.isTrue();
	}

	@Test
	public function when_adding_three_items_with_larger_priority__should_dispatch_in_order() : Void {
		var called0 = false;
		var called1 = false;
		var called2 = false;

		signal.addWithPriority(function(){
			called0 = true;
		}, 1);
		signal.addWithPriority(function(){
			if(called0) {
				called1 = true;
			}
		}, 2);
		signal.addWithPriority(function(){
			if(called1) {
				called2 = true;
			}
		}, 3);
		signal.dispatch();

		called2.isTrue();
	}

	@Test
	public function when_adding_two_items_with_smaller_priority__should_dispatch_in_order() : Void {
		var called0 = false;
		var called1 = false;

		signal.addWithPriority(function(){
			if(called0) {
				called1 = true;
			}
		}, 2);
		signal.addWithPriority(function(){
			called0 = true;
		}, 1);
		signal.dispatch();

		called1.isTrue();
	}

	@Test
	public function when_adding_three_items_with_smaller_priority__should_dispatch_in_order() : Void {
		var called0 = false;
		var called1 = false;
		var called2 = false;

		signal.addWithPriority(function(){
			if(called1) {
				called2 = true;
			}
		}, 3);
		signal.addWithPriority(function(){
			if(called0) {
				called1 = true;
			}
		}, 2);
		signal.addWithPriority(function(){
			called0 = true;
		}, 1);
		signal.dispatch();

		called2.isTrue();
	}

	@Test
	public function when_adding_three_items_with_mixed_priority__should_dispatch_in_order() : Void {
		var called0 = false;
		var called1 = false;
		var called2 = false;

		signal.addWithPriority(function(){
			if(called0) {
				called1 = true;
			}
		}, 2);
		signal.addWithPriority(function(){
			if(called1) {
				called2 = true;
			}
		}, 3);
		signal.addWithPriority(function(){
			called0 = true;
		}, 1);
		signal.dispatch();

		called2.isTrue();
	}

	@Test
	public function when_adding_with_priority__should_size_be_1() : Void {
		signal.addWithPriority(function(){
		});
		signal.size.areEqual(1);
	}

	@Test
	public function when_adding_with_priority_after_dispatch__should_size_be_1() : Void {
		signal.addWithPriority(function(){
		});
		signal.dispatch();
		signal.size.areEqual(1);
	}

	@Test
	public function when_adding_once_with_priority__should_size_be_1() : Void {
		signal.addOnceWithPriority(function(){
		});
		signal.size.areEqual(1);
	}

	@Test
	public function when_adding_once_with_priority_after_dispatch__should_size_be_1() : Void {
		signal.addOnceWithPriority(function(){
		});
		signal.dispatch();
		signal.size.areEqual(0);
	}

	@Test
	public function when_adding_adding_same_function_twice__should_return_same_slot() : Void {
		var func = function(){
		};

		var slot = signal.addWithPriority(func);
		signal.addWithPriority(func).get().areEqual(slot.get());
	}
}