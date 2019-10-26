import math

func_glob =  lambda x: 15.215*x**3-303.985*x**2-1520*x+30400.015
def half_divide_method(a, b, f, theor, e):
	x = (a + b) / 2
	ind = 1
	while math.fabs(theor - x) >= e:
		x = (a + b) / 2
		a, b = (a, x) if f(a) * f(x) < 0 else (x, b)
		print('\n',ind,"a_" + str(ind) + " = ",a,
		 "\\quad b_" + str(ind), " = " , b, 
		 "\\quad x_" + str(ind) + " = ",x, "\\quad
		  \\varepsilon = ", math.fabs(theor - x), "\\\\", '\n')
	ind += 1
	return (a + b) / 2

a = 9
b = 11
theor = 10.00544265
e = 0.001
half_divide_method(a, b, func_glob, theor, e)