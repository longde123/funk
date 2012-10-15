package funk.collections;

import funk.collections.IList;
import funk.collections.immutable.ListUtil;
import funk.errors.ArgumentError;
import funk.errors.RangeError;
import funk.option.Option;
import funk.tuple.Tuple2;
import massive.munit.Assert;
import massive.munit.AssertExtensions;

using funk.collections.immutable.ListUtil;
using funk.option.Option;
using funk.tuple.Tuple2;
using massive.munit.Assert;
using massive.munit.AssertExtensions;

class ListTestBase {

	public var actual : IList<Dynamic>;

	public var expected : IList<Dynamic>;

	public var other : IList<Dynamic>;

	public var filledList : IList<Dynamic>;

	private function generateIntList(size : Int) : IList<Int> {
		var count = 0;
		return size.fill(function() : Int {
			return count++;
		});
	}

	@Test
	public function should_be_not_empty():Void {
		actual.nonEmpty.isTrue();
	}

	@Test
	public function should_be_empty():Void {
		actual.isEmpty.isFalse();
	}

	@Test
	public function should_have_5_size():Void {
		var value = 5;
		generateIntList(value).size.areEqual(value);
	}

	@Test
	public function should_have_99999_size():Void {
		var value = 99999;
		generateIntList(value).size.areEqual(value);
	}

	@Test
	public function should_have_a_defined_size():Void {
		actual.hasDefinedSize.isTrue();
	}

	@Test
	public function should_call_count() : Void {
		var exp = 5;
		var act = 0;
		generateIntList(exp).count(function(x) {
			act++;
			return true;
		});
		act.areEqual(exp);
	}

	@Test
	public function should_count_be_same_as_expected() : Void {
		var exp = 5;
		var act = generateIntList(exp).count(function(x) {
			return true;
		});
		act.areEqual(exp);
	}

	@Test
	public function should_count_be_0() : Void {
		var exp = 0;
		var act = generateIntList(exp).count(function(x) {
			return false;
		});
		act.areEqual(exp);
	}

	@Test
	public function when_drop_0__return_same_list() : Void {
		actual.drop(0).areEqual(actual);
	}

	@Test
	public function when_drop_3__return_IList() : Void {
		actual.drop(2).isType(IList);
	}

	@Test
	public function when_drop_2__return_size_2() : Void {
		actual.drop(2).size.areEqual(2);
	}

	@Test
	public function when_drop_2__return_get_0_is_2() : Void {
		var opt : Option<Int> = generateIntList(5).drop(2).get(0);
		opt.get().areEqual(2);
	}

	@Test
	public function when_drop_2__return_get_1_is_3() : Void {
		var opt : Option<Int> = generateIntList(5).drop(2).get(1);
		opt.get().areEqual(3);
	}

	@Test
	public function when_drop_2_then_1__return_get_0_is_3() : Void {
		var opt : Option<Int> = generateIntList(5).drop(2).drop(1).get(0);
		opt.get().areEqual(3);
	}

	@Test
	@Expect("funk.errors.ArgumentError")
	public function when_drop_on_list__throw_argument_when_passing_minus_to_drop() : Void {
		var called = try {
			actual.drop(-1);
			false;
		} catch(error : ArgumentError) {
			true;
		}
		called.isTrue();
	}

	@Test
	public function when_dropRight_0_on_list__return_same_list() : Void {
		actual.dropRight(0).areEqual(actual);
	}

	@Test
	public function when_dropRight_1_on_list__return_and_get_0_equals_0() : Void {
		generateIntList(5).dropRight(1).get(0).get().areEqual(0);
	}

	@Test
	public function when_dropRight_2_on_list__return_and_get_2_equals_2() : Void {
		generateIntList(5).dropRight(2).get(2).get().areEqual(2);
	}

	@Test
	public function when_dropRight_on_list__throw_argument_when_passing_minus_to_dropRight() : Void {
		var called = try {
			actual.dropRight(-1);
			false;
		} catch(error : ArgumentError) {
			true;
		}
		called.isTrue();
	}

	@Test
	public function when_dropWhile__return_not_null() : Void {
		generateIntList(5).dropWhile(function(x : Int):Bool {
			return x < 2;
		}).isNotNull();
	}

	@Test
	public function when_dropWhile__return_is_type_of_list() : Void {
		generateIntList(5).dropWhile(function(x : Int):Bool {
			return x < 2;
		}).isType(IList);
	}

	@Test
	public function when_dropWhile__return_size_is_3() : Void {
		generateIntList(5).dropWhile(function(x : Int):Bool {
			return x < 2;
		}).size.areEqual(3);
	}

	@Test
	public function when_dropWhile__return_get_2_equals_4() : Void {
		generateIntList(5).dropWhile(function(x : Int):Bool {
			return x < 2;
		}).get(2).get().areEqual(4);
	}


	@Test
	public function when_exists__should_return_true_when_calling_exists() : Void {
		actual.exists(function(x : Int):Bool {
			return x == 2;
		}).isTrue();
	}

	@Test
	public function when_filter__should_return_list() : Void {
		actual.filter(function(x : Dynamic):Bool {
			return x == 1;
		}).isType(IList);
	}

	@Test
	public function when_filter__should_return_list_of_size_1() : Void {
		actual.filter(function(x : Dynamic):Bool {
			return x == 1;
		}).size.areEqual(1);
	}

	@Test
	public function when_filter__should_return_even_list_of_size_2() : Void {
		actual.filter(function(x : Dynamic):Bool {
			return x % 2 == 0;
		}).size.areEqual(2);
	}

	@Test
	public function when_filterNot__should_return_list() : Void {
		actual.filterNot(function(x : Dynamic):Bool {
			return x == 1;
		}).isType(IList);
	}

	@Test
	public function when_filterNot__should_return_list_of_size_4() : Void {
		actual.filterNot(function(x : Dynamic):Bool {
			return x == 1;
		}).size.areEqual(3);
	}

	@Test
	public function when_filterNot__should_return_even_list_of_size_2() : Void {
		actual.filterNot(function(x : Dynamic):Bool {
			return x % 2 == 0;
		}).size.areEqual(2);
	}



	/*
	@Test
	public function when_find_on_nil__should_return_Option_when_calling_mapFalse() : Void {
		actual.find(function(x : Dynamic):Bool {
			return false;
		}).isEnum(Option);
	}

	@Test
	public function when_find_on_nil__should_return_None_when_calling_mapFalse() : Void {
		actual.find(function(x : Dynamic):Bool {
			return false;
		}).isEmpty().isTrue();
	}

	@Test
	public function when_find_on_nil__should_not_call_find() : Void {
		actual.find(function(x : Dynamic):Bool {
			Assert.fail("fail if called");
			return false;
		}).isEnum(Option);
	}

	@Test
	public function when_findIndexOf_on_nil__should_return_minus_1_when_calling_mapTrue() : Void {
		actual.findIndexOf(function(x : Dynamic):Bool {
			return true;
		}).areEqual(-1);
	}

	@Test
	public function when_IndexOf_on_nil__should_return_minus_1_when_finding_null() : Void {
		actual.indexOf(null).areEqual(-1);
	}

	@Test
	public function when_IndexOf_on_nil__should_return_minus_1_when_finding_true() : Void {
		actual.indexOf(true).areEqual(-1);
	}

	@Test
	public function when_IndexOf_on_nil__should_return_minus_1_when_finding_false() : Void {
		actual.indexOf(false).areEqual(-1);
	}

	@Test
	public function when_IndexOf_on_nil__should_return_minus_1_when_finding_array() : Void {
		actual.indexOf([]).areEqual(-1);
	}

	@Test
	public function when_zip_on_nil__should_not_be_null() : Void {
		actual.zip(other).isNotNull();
	}

	@Test
	public function when_zip_on_nil__should_be_equal_to_nil() : Void {
		actual.zip(other).areEqual(expected);
	}

	@Test
	public function when_zip_on_nil__should_be_equal_to_nil_even_if_other_is_not_empty() : Void {
		actual.zip(other.prepend(1)).areEqual(expected);
	}

	@Test
	public function when_find_on_nil__should_not_call_findIndexOf() : Void {
		actual.findIndexOf(function(x : Dynamic):Bool {
			Assert.fail("fail if called");
			return false;
		}).areEqual(-1);
	}

	@Test
	public function when_map_on_nil__should_return_list() : Void {
		actual.map(function(value : Int) : Float {
			return 1.1;
		}).isType(IList);
	}

	@Test
	public function when_map_on_nil__should_return_empty_list() : Void {
		actual.map(function(value : Int) : Float {
			return 1.1;
		}).size.areEqual(0);
	}

	@Test
	public function when_flatMap_on_nil__should_return_list_when_calling_indentity() : Void {
		actual.flatMap(function(x : Dynamic):IList<Dynamic> {
			return other;
		}).areEqual(expected);
	}

	@Test
	public function when_find_on_nil__should_not_call_flatMap() : Void {
		actual.flatMap(function(x : Dynamic):IList<Dynamic> {
			Assert.fail("fail if called");
			return other;
		}).areEqual(expected);
	}

	@Test
	public function when_flatten_on_nil__should_return_list() : Void {
		actual.flatten.areEqual(expected);
	}

	@Test
	public function when_fold_on_nil__should_foldLeft_should_return_0() : Void {
		//should("return 0 when calling foldLeft").expect(actual.foldLeft(0, _.plus_)).toBeEqualTo(0);
	}

	@Test
	public function when_fold_on_nil__should_not_call_foldLeft() : Void {
		actual.foldLeft(0, function(x:Int, y:Int):Int {
			Assert.fail("fail if called");
			return 0;
		}).areEqual(0);
	}

	@Test
	public function when_fold_on_nil__should_foldRight_should_return_0() : Void {
		//should("return 0 when calling foldRight").expect(actual.foldRight(0, _.plus_)).toBeEqualTo(0);
	}

	@Test
	public function when_fold_on_nil__should_not_call_foldRight() : Void {
		actual.foldRight(0, function(x:Int, y:Int):Int {
			Assert.fail("fail if called");
			return 0;
		}).areEqual(0);
	}

	@Test
	public function when_forall_on_nil__should_return_false() : Void {
		actual.forall(function(value : Int) : Bool {
			return true;
		}).isFalse();
	}

	@Test
	public function when_forall_on_nil__should_not_run_function() : Void {
		actual.forall(function(value : Int) : Bool {
			Assert.fail("fail if called");
			return true;
		}).isFalse();
	}

	@Test
	public function when_foreach_on_nil__should_not_run_function() : Void {
		actual.foreach(function(value : Int) : Void {
			Assert.fail("fail if called");
		});
	}

	@Test
	public function when_partition__should_return_isNotNull() : Void {
		actual.partition(function(value : Int) : Bool {
			return true;
		}).isNotNull();
	}

	@Test
	public function when_partition__should_return_a_ITuple2() : Void {
		actual.partition(function(value : Int) : Bool {
			return true;
		}).isType(ITuple2);
	}

	@Test
	public function when_partition__should_return_a_ITuple2_and__1_is_IList() : Void {
		actual.partition(function(value : Int) : Bool {
			return true;
		})._1.isType(IList);
	}

	@Test
	public function when_partition__should_return_a_ITuple2_and__1_is_IList_of_size_0() : Void {
		actual.partition(function(value : Int) : Bool {
			return true;
		})._1.size.areEqual(0);
	}

	@Test
	public function when_partition__should_return_a_ITuple2_and__2_is_IList() : Void {
		actual.partition(function(value : Int) : Bool {
			return true;
		})._2.isType(IList);
	}

	@Test
	public function when_partition__should_return_a_ITuple2_and__2_is_IList_of_size_0() : Void {
		actual.partition(function(value : Int) : Bool {
			return true;
		})._2.size.areEqual(0);
	}

	@Test
	public function when_reduceRight_on_nil__should_return_Option() : Void {
		actual.reduceRight(function(a:Int, b:Int):Int {
			return -1;
		}).isEnum(Option);
	}

	@Test
	public function when_reduceRight_on_nil__should_return_None() : Void {
		actual.reduceRight(function(a:Int, b:Int):Int {
			return -1;
		}).isEnum(Option);
	}

	@Test
	public function when_reduceRight_on_nil__should_not_call_method() : Void {
		actual.reduceRight(function(a:Int, b:Int):Int {
			Assert.fail("fail if called");
			return -1;
		}).isEnum(Option);
	}

	@Test
	public function when_reduceLeft_on_nil__should_return_Option() : Void {
		actual.reduceLeft(function(a:Int, b:Int):Int {
			return -1;
		}).isEnum(Option);
	}

	@Test
	public function when_reduceLeft_on_nil__should_return_None() : Void {
		actual.reduceLeft(function(a:Int, b:Int):Int {
			return -1;
		}).isEnum(Option);
	}

	@Test
	public function when_take_0_on_nil__should_return_isNotNull() : Void {
		actual.take(0).isNotNull();
	}

	@Test
	public function when_take_0_on_nil__should_return_valid_IList() : Void {
		actual.take(0).isType(IList);
	}

	@Test
	public function when_take_0_on_nil__should_return_size_0() : Void {
		actual.take(0).size.areEqual(0);
	}

	@Test
	public function when_take_minus_1_on_nil__should_throw_error() : Void {
		var called = try {
			actual.take(-1);
			false;
		} catch(error : ArgumentError){
			true;
		}
		called.isTrue();
	}

	@Test
	public function when_takeRight_0_on_nil__should_return_isNotNull() : Void {
		actual.takeRight(0).isNotNull();
	}

	@Test
	public function when_takeRight_0_on_nil__should_return_valid_IList() : Void {
		actual.takeRight(0).isType(IList);
	}

	@Test
	public function when_takeRight_0_on_nil__should_return_size_0() : Void {
		actual.takeRight(0).size.areEqual(0);
	}

	@Test
	public function when_takeRight_minus_1_on_nil__should_throw_error() : Void {
		var called = try {
			actual.takeRight(-1);
			false;
		} catch(error : ArgumentError){
			true;
		}
		called.isTrue();
	}

	@Test
	public function when_takeWhile_on_nil__should_return_isNotNull() : Void {
		actual.takeWhile(function(value : Int) : Bool {
			return true;
		}).isNotNull();
	}

	@Test
	public function when_takeWhile_on_nil__should_return_valid_IList() : Void {
		actual.takeWhile(function(value : Int) : Bool {
			return true;
		}).isType(IList);
	}

	@Test
	public function when_takeWhile_on_nil__should_return_size_0() : Void {
		actual.takeWhile(function(value : Int) : Bool {
			return true;
		}).size.areEqual(0);
	}

	@Test
	public function when_takeWhile_on_nil__should_not_call_method() : Void {
		actual.takeWhile(function(value : Int) : Bool {
			Assert.fail("fail if called");
			return true;
		});
	}

	@Test
	public function when_get_0_on_nil__should_return_Option() : Void {
		actual.get(0).isEnum(Option);
	}

	@Test
	public function when_get_0_on_nil__should_return_None() : Void {
		actual.get(0).isEmpty().isTrue();
	}

	@Test
	public function when_take_on_nil__should_not_return_null() : Void {
		actual.take(0).isNotNull();
	}

	@Test
	public function when_take_on_nil__should_return_nil_list() : Void {
		actual.take(0).areEqual(expected);
	}

	@Test
	public function when_take_on_nil__should_return_nil_list_with_1() : Void {
		actual.take(1).areEqual(expected);
	}

	@Test
	public function when_takeRight_on_nil__should_not_return_null() : Void {
		actual.takeRight(0).isNotNull();
	}

	@Test
	public function when_takeRight_on_nil__should_return_nil_list() : Void {
		actual.takeRight(0).areEqual(expected);
	}

	@Test
	public function when_takeRight_on_nil__should_return_nil_list_with_1() : Void {
		actual.takeRight(1).areEqual(expected);
	}

	@Test
	public function when_contains_on_nil__should_not_contain_null() : Void {
		actual.contains(null).isFalse();
	}

	@Test
	public function when_contains_on_nil__should_not_contain_true() : Void {
		actual.contains(true).isFalse();
	}

	@Test
	public function when_contains_on_nil__should_not_contain_object() : Void {
		actual.contains({}).isFalse();
	}

	@Test
	public function when_contains_on_nil__should_not_contain_array() : Void {
		actual.contains([]).isFalse();
	}

	@Test
	public function when_toArray_on_nil__should_not_be_null() : Void {
		actual.toArray.isNotNull();
	}

	@Test
	public function when_toArray_on_nil__should_be_length_0() : Void {
		actual.toArray.length.areEqual(0);
	}

	@Test
	public function when_head_on_nil__should_be_null() : Void {
		actual.head.isNull();
	}

	@Test
	public function when_headOption_on_nil__should_be_Option() : Void {
		actual.headOption.isEnum(Option);
	}

	@Test
	public function when_headOption_on_nil__should_be_None() : Void {
		actual.headOption.isEmpty().isTrue();
	}

	@Test
	public function when_indices_on_nil__should_not_be_null() : Void {
		actual.indices.isNotNull();
	}

	@Test
	public function when_indices_on_nil__should_be_equal_to_nil() : Void {
		actual.indices.areEqual(expected);
	}

	@Test
	public function when_init_on_nil__should_not_be_null() : Void {
		actual.init.isNotNull();
	}

	@Test
	public function when_init_on_nil__should_be_equal_to_nil() : Void {
		actual.init.areEqual(expected);
	}

	@Test
	public function when_last_on_nil__should_not_be_null() : Void {
		actual.last.isNotNull();
	}

	@Test
	public function when_last_on_nil__should_be_equal_to_Option() : Void {
		actual.last.isEnum(Option);
	}

	@Test
	public function when_last_on_nil__should_be_equal_to_None() : Void {
		actual.last.isEmpty().isTrue();
	}

	@Test
	public function when_reverse_on_nil__should_not_be_null() : Void {
		actual.reverse.isNotNull();
	}

	@Test
	public function when_reverse_on_nil__should_be_equal_to_nil() : Void {
		actual.reverse.areEqual(expected);
	}

	@Test
	public function when_tail_on_nil__should_be_null() : Void {
		actual.tail.isNull();
	}

	@Test
	public function when_tailOption_on_nil__should_be_Option() : Void {
		actual.tailOption.isEnum(Option);
	}

	@Test
	public function when_tailOption_on_nil__should_be_None() : Void {
		actual.tailOption.isEmpty().isTrue();
	}

	@Test
	public function when_zipWithIndex_on_nil__should_not_be_null() : Void {
		actual.zipWithIndex.isNotNull();
	}

	@Test
	public function when_zipWithIndex_on_nil__should_be_equal_to_nil() : Void {
		actual.zipWithIndex.areEqual(expected);
	}

	@Test
	public function when_productArity_on_nil__should_be_equal_to_0() : Void {
		actual.productArity.areEqual(0);
	}

	@Test
	public function when_calling_productElement_on_nil__should_throw_RangeError() : Void {
		var called = try {
			actual.productElement(0);
			false;
		} catch(e : RangeError) {
			true;
		}
		called.isTrue();
	}

	@Test
	public function when_calling_append_on_nil__should_not_be_null() : Void {
		actual.append(1).isNotNull();
	}

	@Test
	public function when_calling_append_on_nil__should_be_size_1() : Void {
		actual.append(1).size.areEqual(1);
	}

	@Test
	public function when_calling_appendIterable_on_nil__should_not_be_null() : Void {
		actual.appendIterable({iterator: filledList.productIterator}).isNotNull();
	}

	@Test
	public function when_calling_appendIterable_on_nil__should_be_size_4() : Void {
		actual.appendIterable({iterator: filledList.productIterator}).size.areEqual(4);
	}

	@Test
	public function when_calling_iterator_on_nil__should_not_be_null() : Void {
		actual.appendIterator(filledList.productIterator()).isNotNull();
	}

	@Test
	public function when_calling_iterator_on_nil__should_be_size_4() : Void {
		actual.appendIterator(filledList.productIterator()).size.areEqual(4);
	}

	@Test
	public function when_calling_appendAll_on_nil__should_not_be_null() : Void {
		actual.appendAll(other.prepend(1)).isNotNull();
	}

	@Test
	public function when_calling_prepend_on_nil__should_not_be_null() : Void {
		actual.prepend(1).isNotNull();
	}

	@Test
	public function when_calling_prepend_on_nil__should_be_size_1() : Void {
		actual.prepend(1).size.areEqual(1);
	}

	@Test
	public function when_calling_prependIterable_on_nil__should_not_be_null() : Void {
		actual.prependIterable({iterator: filledList.productIterator}).isNotNull();
	}

	@Test
	public function when_calling_prependIterable_on_nil__should_be_size_4() : Void {
		actual.prependIterable({iterator: filledList.productIterator}).size.areEqual(4);
	}

	@Test
	public function when_calling_prependIterator_on_nil__should_not_be_null() : Void {
		actual.prependIterator(filledList.productIterator()).isNotNull();
	}

	@Test
	public function when_calling_prependIterator_on_nil__should_be_size_4() : Void {
		actual.prependIterator(filledList.productIterator()).size.areEqual(4);
	}

	@Test
	public function when_calling_prependAll_on_nil__should_not_be_null() : Void {
		actual.prependAll(other.prepend(1)).isNotNull();
	}

	@Test
	public function when_calling_appendAll_on_nil__should_return_same_instance() : Void {
		var o = expected.prepend(1);
		actual.appendAll(o).areEqual(o);
	}

	@Test
	public function when_calling_toString_on_nil_should_return_Nil() : Void {
		actual.toString().areEqual('Nil');
	}

	@Test
	public function when_calling_productPrefix_on_nil_should_return_Nil() : Void {
		actual.productPrefix.areEqual('Nil');
	}

	@Test
	public function when_calling_productIterator_on_nil_is_not_null() : Void {
		actual.productIterator().isNotNull();
	}

	@Test
	public function when_calling_productIterator_on_nil_should_hasNext_be_false() : Void {
		actual.productIterator().hasNext().isFalse();
	}
	*/
}