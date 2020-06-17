decimal(x) = {
r = 0; 
for (i=1, matsize(x)[2], r = r + 2^(i-1)*x[matsize(x)[2]-i+1]); 
return(r)
}

rns_reverse(n, p, R) = {
tR1 = concat(concat(binary(R[1]), binary(R[1])), concat(binary(R[1]), binary(R[1])));
	eR1 = decimal(tR1);
	xR2 = R[2] - 2^n*max(matsize(binary(R[2]))[2]-n, 0);
tR2 = concat(concat(binary(xR2), binary(bitneg(xR2))), concat(binary(xR2), binary(bitneg(xR2))));
eR2 = decimal(tR2);
	xR3 = R[3] - 2^(2*n)*max(matsize(binary(R[3]))[2]-2*n, 0);
tR4 = decimal(concat(binary(2^(n-p-2)-1), binary(bitneg(R[4])))) << n+2;
eR4 = tR4;
k1 = concat(binary(bittest(R[3], 2*n)), binary(bitneg(R[2], n)));
k2 = concat(binary(bitand(bittest(R[2], n), bitneg(bittest(R[3], 2*n)))), binary(bitneg(bitxor(bittest(R[2], n), bittest(R[3], 2*n)))));
k3 = concat(binary((2^(n-1)-1)*bittest(R[3], 2*n)), bitneg(bittest(R[2], n)));
k4 = binary(bittest(R[2], n));
k = decimal(k1)+decimal(k2)+decimal(k3)+decimal(k4);
xR = 2^(n-p-2)*(eR1+eR2+eR3+eR4+k);
return((1/xR)%(2^(4*n)-1));
}

