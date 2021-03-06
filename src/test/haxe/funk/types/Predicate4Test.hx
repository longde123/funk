package funk.types;

using Type;
using funk.types.Predicate4;
using massive.munit.Assert;

class Predicate4Test {

    @Test
    public function when_calling_and_same_result__should_return_true() : Void {
        var a = function (value0, value1, value2, value3) return true;
        var b = function (value0, value1, value2, value3) return true;
        a.and(b)(true, true, true, true).isTrue();
    }

    @Test
    public function when_calling_and_with_different_result__should_return_false() : Void {
        var a = function (value0, value1, value2, value3) return true;
        var b = function (value0, value1, value2, value3) return false;
        a.and(b)(true, true, true, true).isFalse();
    }

    @Test
    public function when_calling_and__should_return_function() : Void {
        var a = function (value0, value1, value2, value3) return true;
        var b = function (value0, value1, value2, value3) return true;
        a.and(b).typeof().areEqual(TFunction);
    }


    @Test
    public function when_calling_not_with_false_result__should_be_true() : Void {
        var a = function (value0, value1, value2, value3) return false;
        a.not()(true, true, true, true).isTrue();
    }

    @Test
    public function when_calling_not_with_true_result__should_be_false() : Void {
        var a = function (value0, value1, value2, value3) return false;
        a.not()(true, true, true, true).isTrue();
    }

    @Test
    public function when_calling_not__should_return_function() : Void {
        var a = function (value0, value1, value2, value3) return true;
        a.not().typeof().areEqual(TFunction);
    }


    @Test
    public function when_calling_or_same_result__should_return_true() : Void {
        var a = function (value0, value1, value2, value3) return true;
        var b = function (value0, value1, value2, value3) return true;
        a.or(b)(true, true, true, true).isTrue();
    }

    @Test
    public function when_calling_or_with_different_result__should_return_true() : Void {
        var a = function (value0, value1, value2, value3) return true;
        var b = function (value0, value1, value2, value3) return false;
        a.or(b)(true, true, true, true).isTrue();
    }

    @Test
    public function when_calling_or_with_different_2_result__should_return_true() : Void {
        var a = function (value0, value1, value2, value3) return false;
        var b = function (value0, value1, value2, value3) return true;
        a.or(b)(true, true, true, true).isTrue();
    }

    @Test
    public function when_calling_or_with_same_false_result__should_return_false() : Void {
        var a = function (value0, value1, value2, value3) return false;
        var b = function (value0, value1, value2, value3) return false;
        a.or(b)(true, true, true, true).isFalse();
    }

    @Test
    public function when_calling_or__should_return_function() : Void {
        var a = function (value0, value1, value2, value3) return true;
        var b = function (value0, value1, value2, value3) return true;
        a.or(b).typeof().areEqual(TFunction);
    }


    @Test
    public function when_calling_if_with_true_result__should_call_if_branch() : Void {
        var called = false;

        var a = function (value0, value1, value2, value3) return true;
        a.ifElse(function () {
            called = true;
        }, function () {
            Assert.fail("fail if called");
        })(true, true, true, true);

        called.isTrue();
    }

    @Test
    public function when_calling_if_with_false_result__should_call_else_branch() : Void {
        var called = false;

        var a = function (value0, value1, value2, value3) return false;
        a.ifElse(function () {
            Assert.fail("fail if called");
        }, function () {
            called = true;
        })(true, true, true, true);

        called.isTrue();
    }
}
