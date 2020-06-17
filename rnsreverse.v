// n = 7
// p = 3

module FA (  input a,
                  input b,
                  input c_in,
                  output c_out,
                  output sum
);

 	wire xx, o1, o2;
	xor(xx, a, b);
	xor (sum, xx, c_in);
	and (o1, xx, c_in);
	and (o2, a, b);
	or (c_out, o1, o2);
  
endmodule

module CSA_28bit(
	input [27:0] r1, input [27:0] r2, input [27:0] r3,
	output [28:1] c, output [27:0] s
);
	FA fa;
	for(i=0; i<28;++i)
		fa (r1[i], r2[i], r3[i], c[i+1], s[i]);

endmodule

module eR1(
	input [6:0] r1,
	output [27:0] er1
);
	assign er1[6:0] = r1;
	assign er1[13:7] = r1;
	assign er1[20:14] = r1;
	assign er1[27:21] = r1;
endmodule

module eR2(
	input [7:0] r2,
	output [27:0] er2
);
	wire tR2, ntR2;
	assign tR2 = r2[6:0];
	not(ntR2, tR2);
	assign er2 = {tR2, ntR2, tR2, ntR2};

endmodule
	
module eR3(
	input [14:0] r3,
	output [27:0] er3
);
	wire tR3, ntR3;
	assign tR3 = r3[13:0];
	not(ntR3, tR3);
	assign er3 = {{ntR3, tR3}[19:0], {ntR3, tR3}[27:20]};
endmodule

module eR4(
	input [16:0] r4,
	output [27:0] eR4
);
	wire nr4;
	not(nr4, r4);
	assign eR4 = {1, 1, nr4, 0,0,0,0,0,0,0,0,0};
endmodule

module K(
	input [7:0] r2,
	input [14:0] r3,
	output [27:0] k
);
	wire xn, an, nr2, nr3;
	not(nr2, r2[7]);
	not(nr3, r3[14]);
	xnor(xn, r2[7], r3[14]);
	and(an, r2[7], nr3);
	assign k = {0,0,0,0,0,r3[14], nr2, 0,0,0,0,0,an,xn,r3[14],r3[14],r3[14],r3[14],r3[14],r3[14],nr2,0,0,0,0,0,0,r2[7]};
endmodule

module rns_reverse(
	input [6:0] r1,
	input [7:0] r2,
	input [14:0] r3,
	input [16:0] r4,
	output [27:0] result
);
	wire [27:0] er1, er2, er3, er4, k;
	CSA_28bit csa;
	eR1(r1, er1);
	eR2(r2, er2);
	eR3(r3, er3);
	eR4(r4, er4);
	K(r2, r3, k);
	wire [27:0] csa_res1, csa_res2, csa_res3;
	wire [28:1] csa_c1, csa_c2, csa_c3;
	csa(er1, er2, er3, csa_c1, csa_res1);
	csa(csa_res1, csa_c1, er4, csa_c2, csa_res2);
	csa(csa_res2, csa_c2, k, csa_c3, csa_res3);
	assign result = csa_res3;
	
endmodule