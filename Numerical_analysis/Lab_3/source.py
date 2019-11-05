import math

func_glob =  lambda x: 8.215*x**3-49.185*x**2-73.8*x+442.815
def half_divide_method(a, b, f, theor, e):
	x = (a + b) / 2
	ind = 1
	while math.fabs(theor - x) >= e:
		x = (a + b) / 2
		a, b = (a, x) if f(a) * f(x) < 0 else (x, b)
		print('\n',ind,"a_" + str(ind) + " =",a,
		 "b_" + str(ind), " =" , b,
		 "x_" + str(ind) + " =",x, "epsilon =", math.fabs(theor - x), '\n')
		ind += 1
	return (a + b) / 2

a = 2
b = 4
theor = 3.00378
e = 0.001
half_divide_method(a, b, func_glob, theor, e)