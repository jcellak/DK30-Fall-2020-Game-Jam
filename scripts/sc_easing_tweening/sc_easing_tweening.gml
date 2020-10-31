
function EaseLinear(inputvalue, outputmin, outputmax, inputmax)
{
	return outputmax * inputvalue / inputmax + outputmin;
}

function EaseInQuad(inputvalue, outputmin, outputmax, inputmax)
{
	inputvalue /= inputmax;
	return outputmax * inputvalue * inputvalue + outputmin;
}

function EaseOutQuad(inputvalue,outputmin,outputmax,inputmax)
{
	inputvalue /= inputmax;
	return -outputmax * inputvalue * (inputvalue - 2) + outputmin;
}

function EaseInOutQuad(inputvalue,outputmin,outputmax,inputmax)
{
	inputvalue /= inputmax * 0.5;

	if (inputvalue < 1) {
	    return outputmax * 0.5 * inputvalue * inputvalue + outputmin;
	}

	return outputmax * -0.5 * (--inputvalue * (inputvalue - 2) - 1) + outputmin;
}

function EaseInCubic(inputvalue,outputmin,outputmax,inputmax) {
	return outputmax * power(inputvalue/inputmax, 3) + outputmin;
}

function EaseOutCubic(inputvalue,outputmin,outputmax,inputmax)
{
	return outputmax * (power(inputvalue/inputmax - 1, 3) + 1) + outputmin;
}

function EaseInOutCubic(inputvalue,outputmin,outputmax,inputmax)
{
	inputvalue /= inputmax * 0.5;

	if (inputvalue < 1)
	{
	   return outputmax * 0.5 * power(inputvalue, 3) + outputmin;
	}

	return outputmax * 0.5 * (power(inputvalue - 2, 3) + 2) + outputmin;
}

function EaseInQuart(inputvalue,outputmin,outputmax,inputmax)
{
	return outputmax * power(inputvalue / inputmax, 4) + outputmin;
}

function EaseOutQuart(inputvalue,outputmin,outputmax,inputmax) {
	return -outputmax * (power(inputvalue / inputmax - 1, 4) - 1) + outputmin;
}

function EaseInOutQuart(inputvalue,outputmin,outputmax,inputmax)
{
	inputvalue /= inputmax * 0.5;

	if (inputvalue < 1) {
	    return outputmax * 0.5 * power(inputvalue, 4) + outputmin;
	}

	return outputmax * -0.5 * (power(inputvalue - 2, 4) - 2) + outputmin;
}

function EaseInQuint(inputvalue,outputmin,outputmax,inputmax)
{
	return outputmax * power(inputvalue / inputmax, 5) + outputmin;
}

function EaseOutQuint(inputvalue,outputmin,outputmax,inputmax)
{
	return outputmax * (power(inputvalue / inputmax - 1, 5) + 1) + outputmin;
}

function EaseInOutQuint(inputvalue,outputmin,outputmax,inputmax)
{
	inputvalue /= inputmax * 0.5;

	if (inputvalue < 1)
	{
	    return outputmax * 0.5 * power(inputvalue, 5) + outputmin;
	}

	return outputmax * 0.5 * (power(inputvalue - 2, 5) + 2) + outputmin;
}

function EaseInSine(inputvalue,outputmin,outputmax,inputmax)
{
	return outputmax * (1 - cos(inputvalue / inputmax * (pi / 2))) + outputmin;
}

function EaseOutSine(inputvalue,outputmin,outputmax,inputmax)
{
	return outputmax * sin(inputvalue / inputmax * (pi / 2)) + outputmin;
}

function EaseInOutSine(inputvalue,outputmin,outputmax,inputmax)
{
	return outputmax * 0.5 * (1 - cos(pi * inputvalue / inputmax)) + outputmin;
}

function EaseInCirc(inputvalue,outputmin,outputmax,inputmax)
{
	inputvalue /= inputmax;
	return outputmax * (1 - sqrt(1 - inputvalue * inputvalue)) + outputmin;
}

function EaseOutCirc(inputvalue,outputmin,outputmax,inputmax)
{
	inputvalue = inputvalue / inputmax - 1;
	return outputmax * sqrt(1 - inputvalue * inputvalue) + outputmin;
}

function EaseInOutCirc(inputvalue,outputmin,outputmax,inputmax)
{
	inputvalue /= inputmax * 0.5;

	if (inputvalue < 1)
	{
	    return outputmax * 0.5 * (1 - sqrt(1 - inputvalue * inputvalue)) + outputmin;
	}

	inputvalue -= 2;
	return outputmax * 0.5 * (sqrt(1 - inputvalue * inputvalue) + 1) + outputmin;
}

function EaseInExpo(inputvalue,outputmin,outputmax,inputmax)
{
	return outputmax * power(2, 10 * (inputvalue / inputmax - 1)) + outputmin;
}

function EaseOutExpo(inputvalue,outputmin,outputmax,inputmax)
{
	return outputmax * (-power(2, -10 * inputvalue / inputmax) + 1) + outputmin;
}

function EaseInOutExpo(inputvalue,outputmin,outputmax,inputmax)
{
	inputvalue /= inputmax * 0.5;

	if (inputvalue < 1) 
	{
	    return outputmax * 0.5 * power(2, 10 * --inputvalue) + outputmin;
	}

	return outputmax * 0.5 * (-power(2, -10 * --inputvalue) + 2) + outputmin;
}

function EaseInElastic(inputvalue,outputmin,outputmax,inputmax)
{
	var _s = 1.70158;
	var _p = 0;
	var _a = outputmax;

	if (inputvalue == 0 || _a == 0) 
	{
	    return outputmin; 
	}

	inputvalue /= inputmax;

	if (inputvalue == 1) 
	{
	    return outputmin+outputmax; 
	}

	if (_p == 0) 
	{
	    _p = inputmax*0.3;
	}

	if (_a < abs(outputmax)) 
	{ 
	    _a = outputmax; 
	    _s = _p*0.25; 
	}
	else
	{
	    _s = _p / (2 * pi) * arcsin (outputmax / _a);
	}

	return -(_a * power(2,10 * (--inputvalue)) * sin((inputvalue * inputmax - _s) * (2 * pi) / _p)) + outputmin;
}

function EaseOutElastic(inputvalue,outputmin,outputmax,inputmax)
{
	var _s = 1.70158;
	var _p = 0;
	var _a = outputmax;

	if (inputvalue == 0 || _a == 0)
	{
	    return outputmin;
	}

	inputvalue /= inputmax;

	if (inputvalue == 1)
	{
	    return outputmin + outputmax;
	}

	if (_p == 0)
	{
	    _p = inputmax * 0.3;
	}

	if (_a < abs(outputmax)) 
	{ 
	    _a = outputmax;
	    _s = _p * 0.25; 
	}
	else 
	{
	    _s = _p / (2 * pi) * arcsin (outputmax / _a);
	}

	return _a * power(2, -10 * inputvalue) * sin((inputvalue * inputmax - _s) * (2 * pi) / _p ) + outputmax + outputmin;
}

function EaseInOutElastic(inputvalue,outputmin,outputmax,inputmax)
{
	var _s = 1.70158;
	var _p = 0;
	var _a = outputmax;

	if (inputvalue == 0 || _a == 0)
	{
	    return outputmin;
	}

	inputvalue /= inputmax*0.5;

	if (inputvalue == 2)
	{
	    return outputmin+outputmax; 
	}

	if (_p == 0)
	{
	    _p = inputmax * (0.3 * 1.5);
	}

	if (_a < abs(outputmax)) 
	{ 
	    _a = outputmax; 
	    _s = _p * 0.25; 
	}
	else
	{
	    _s = _p / (2 * pi) * arcsin (outputmax / _a);
	}

	if (inputvalue < 1)
	{
	    return -0.5 * (_a * power(2, 10 * (--inputvalue)) * sin((inputvalue * inputmax - _s) * (2 * pi) / _p)) + outputmin;
	}

	return _a * power(2, -10 * (--inputvalue)) * sin((inputvalue * inputmax - _s) * (2 * pi) / _p) * 0.5 + outputmax + outputmin;
}

function EaseInBack(inputvalue,outputmin,outputmax,inputmax)
{
	var _s = 1.70158;

	inputvalue /= inputmax;
	return outputmax * inputvalue * inputvalue * ((_s + 1) * inputvalue - _s) + outputmin;
}

function EaseOutBack(inputvalue,outputmin,outputmax,inputmax)
{
	var _s = 1.70158;

	inputvalue = inputvalue/inputmax - 1;
	return outputmax * (inputvalue * inputvalue * ((_s + 1) * inputvalue + _s) + 1) + outputmin;
}

function EaseInOutBack(inputvalue,outputmin,outputmax,inputmax)
{
	var _s = 1.70158;

	inputvalue = inputvalue/inputmax*2

	if (inputvalue < 1) {
	    _s *= 1.525;
	    return outputmax * 0.5 * (inputvalue * inputvalue * ((_s + 1) * inputvalue - _s)) + outputmin;
	}

	inputvalue -= 2;
	_s *= 1.525

	return outputmax * 0.5 * (inputvalue * inputvalue * ((_s + 1) * inputvalue + _s) + 2) + outputmin;
}

function EaseInBounce(inputvalue,outputmin,outputmax,inputmax)
{
	return outputmax - EaseOutBounce(inputmax - inputvalue, 0, outputmax, inputmax) + outputmin
}

function EaseOutBounce(inputvalue,outputmin,outputmax,inputmax)
{
	inputvalue /= inputmax;

	if (inputvalue < 1/2.75)
	{
	    return outputmax * 7.5625 * inputvalue * inputvalue + outputmin;
	}
	else
	if (inputvalue < 2/2.75) {
	    inputvalue -= 1.5/2.75;
	    return outputmax * (7.5625 * inputvalue * inputvalue + 0.75) + outputmin;
	} else if (inputvalue < 2.5/2.75) {
	    inputvalue -= 2.25/2.75;
	    return outputmax * (7.5625 * inputvalue * inputvalue + 0.9375) + outputmin;
	} else {
	    inputvalue -= 2.625/2.75;
	    return outputmax * (7.5625 * inputvalue * inputvalue + 0.984375) + outputmin;
	}
}

function EaseInOutBounce(inputvalue,outputmin,outputmax,inputmax)
{
	if (inputvalue < inputmax*0.5) {
	    return (EaseInBounce(inputvalue*2, 0, outputmax, inputmax)*0.5 + outputmin);
	}

	return (EaseOutBounce(inputvalue*2 - inputmax, 0, outputmax, inputmax)*0.5 + outputmax*0.5 + outputmin);
}