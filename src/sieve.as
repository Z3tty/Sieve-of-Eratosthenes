function tracef(str:String, ... args):void {
	var newStr:String = "";
	if (str.search(/%[ions]/) != -1 && args.length > 0) { 
		var arr:Array = str.split(/(%[ions])/); 
		for (var i:int = 1; i < arr.length; i++) { 
			if (args.length > 0) { 
				var t:Object;
				switch(arr[i]) { 
					case "%i":
						for each (t in args) {
							if (t is int || t is uint) {
								arr[i] = t;
								args.splice(args.indexOf(t), 1);
								break;
							}
						} break;
					case "%s":
						for each (t in args) {
							if (t is String) {
								arr[i] = t;
								args.splice(args.indexOf(t), 1);
								break;
							}
						} break;
					case "%n":
						for each (t in args) {
							if (t is Number && !(t is int || t is uint)) {
								arr[i] = t;
								args.splice(args.indexOf(t), 1);
								break;
							}
						} break;
					case "%o":
						for each (t in args) {
							if (t is Object && !(t is int || t is uint || t is String)) {
								arr[i] = t;
								args.splice(args.indexOf(t), 1);
								break;
							}
						} break;
					default: break;
				}
			}
		}
		for each (var p:String in arr) newStr += p;
	}
	else newStr = str;
	trace(newStr);
	return;
}
function isPSquare(n:int):Boolean
{
	if(n == 0) return false;
	var i:int = 1;
	while(true) {
		if(n < 0) return false;
		if(n == 0) return true;
		n-=i; i+=2;
	} return false;
}
function eratosthenes(limit:int):Array
{
	var primes:Array = new Array();
	if (limit >= 2) {
		var sqrtlmt:int = int(Math.sqrt(limit) - 2);
		var nums:Array = new Array(); // start with an empty Array...
		for (var i:int = 2; i <= limit; i++) // and
			nums.push(i); // only initialize the Array once...
		for (var j:int = 0; j <= sqrtlmt; j++) {
			var p:int = nums[j]
			if (p)
				for (var t:int = p * p - 2; t < nums.length; t += p)
					nums[t] = 0;
		}
		for (var m:int = 0; m < nums.length; m++) {
			var r:int = nums[m];
			if (r)
				primes.push(r);
		}
	}
	return primes;
}
const PRIMES:uint = 10000000;
var time:int = getTimer();
var e:Array = eratosthenes(PRIMES);
trace(e);
var duration:Number = getTimer()-time;
tracef("Duration on primes upto %i: %ims", PRIMES, duration);
var sum:uint = 0;
time = getTimer();
for each(var prime:int in e) sum += prime;
duration = getTimer()-time;
tracef("Sum of these primes: %i :: computed in:%ims",sum, duration);
