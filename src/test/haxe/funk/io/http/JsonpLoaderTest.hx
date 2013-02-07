package funk.io.http;

import funk.collections.immutable.List;
import funk.io.http.JsonpLoader;
import funk.net.http.HttpHeader;
import funk.net.http.HttpMethod;
import funk.net.http.HttpStatusCode;
import funk.net.http.UriRequest;
import funk.reactive.Stream;
import funk.types.Promise;
import haxe.Http;

import massive.munit.async.AsyncFactory;
import massive.munit.util.Timer;

using funk.collections.immutable.extensions.Lists;
using funk.net.http.extensions.HttpHeaders;
using funk.net.http.extensions.HttpStatusCodes;
using funk.net.http.extensions.UriRequests;
using funk.net.http.extensions.Uris;
using massive.munit.Assert;
using unit.Asserts;

#if js
class JsonpLoaderTest {

	@Before
	public function setup() {
		
	}

	@AsyncTest
	public function when_creating_loader__should_not_be_null(asyncFactory : AsyncFactory) {
		var actual = null;
		var expected = "Hello, World!";

		var handler = asyncFactory.createHandler(this, function() {
			Assert.isNotNull(actual);
		}, 4000);

		var loader = new JsonpLoader(Request("http://jsfiddle.net/echo/jsonp/?message=" + expected));
		loader.start(Get).then(function(data) {
			actual = data;
			handler();
		});
	}

	@AsyncTest
	public function when_creating_loader__should_response_be_correct_message(asyncFactory : AsyncFactory) {
		var actual = "";
		var expected = "Hello, World!";

		var handler = asyncFactory.createHandler(this, function() {
			actual.areEqual(expected);
		}, 4000);

		var loader = new JsonpLoader(Request("http://jsfiddle.net/echo/jsonp/?message=" + expected));
		loader.start(Get).then(function(data) {
			actual = Reflect.field(data, "message");
			handler();
		});
	}
}
#end