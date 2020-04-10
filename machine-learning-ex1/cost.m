x = [ 2; 2; 2];

for i = 1:3
 	for j = 1:3
		a2(i) = a2(i) + x(j)*[1 2 3;2 3 4; 5 6 7](i,j);
	end
	a2(i) = 1 / (1+e^(-a2(i)));
end
