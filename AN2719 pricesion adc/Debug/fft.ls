   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.6 - 08 Apr 2008
   3                     ; Optimizer V4.2.6 - 08 Apr 2008
   5                     .const:	section	.text
   6  0000               _rangeAD:
   7  0000               L7:
   8  0000 40200000      	dc.w	16416,0
   9  0004               _ADbits:
  10  0004 000a          	dc.w	10
  11  0006               _maxAD:
  12  0006 0400          	dc.w	1024
  13  0008               _multiplierU:
  14  0008               L71:
  15  0008 464ccccc      	dc.w	17996,-13108
  16  000c               _multiplierI:
  17  000c 464ccccc      	dc.w	17996,-13108
  18  0010               _multiplierEnaX:
  19  0010 00010000      	dc.l	65536
  20                     	switch	.data
  21  0000               _interpolation:
  22  0000 01            	dc.b	1
  82                     ; 70 unsigned int flipbits(unsigned int a)
  82                     ; 71 {
  84                     	switch	.text
  85  0000               _flipbits:
  87  0000 89            	pushw	x
  88  0001 5205          	subw	sp,#5
  89       00000005      OFST:	set	5
  92                     ; 76   powerExp=numsample >> 1;
  94  0003 ae0010        	ldw	x,#16
  95  0006 1f04          	ldw	(OFST-1,sp),x
  96                     ; 77   temp=0;
  98  0008 5f            	clrw	x
  99  0009 1f01          	ldw	(OFST-4,sp),x
 100                     ; 78   for (i=1;i<=nbit;i++)
 102  000b a601          	ld	a,#1
 103  000d 6b03          	ld	(OFST-2,sp),a
 105  000f 201c          	jra	L75
 106  0011               L35:
 107                     ; 80     temp+=(a%2)*powerExp;
 109  0011 7b07          	ld	a,(OFST+2,sp)
 110  0013 a401          	and	a,#1
 111  0015 5f            	clrw	x
 112  0016 02            	rlwa	x,a
 113  0017 1604          	ldw	y,(OFST-1,sp)
 114  0019 cd0000        	call	c_imul
 116  001c 72fb01        	addw	x,(OFST-4,sp)
 117  001f 1f01          	ldw	(OFST-4,sp),x
 118                     ; 81     powerExp >>= 1;
 120  0021 0404          	srl	(OFST-1,sp)
 121  0023 0605          	rrc	(OFST+0,sp)
 122                     ; 82     a >>= 1;
 124  0025 0406          	srl	(OFST+1,sp)
 125  0027 0607          	rrc	(OFST+2,sp)
 126                     ; 78   for (i=1;i<=nbit;i++)
 128  0029 0c03          	inc	(OFST-2,sp)
 129  002b 7b03          	ld	a,(OFST-2,sp)
 130  002d               L75:
 133  002d 5f            	clrw	x
 134  002e 97            	ld	xl,a
 135  002f c30002        	cpw	x,_nbit
 136  0032 23dd          	jrule	L35
 137                     ; 84   return(temp);
 139  0034 1e01          	ldw	x,(OFST-4,sp)
 142  0036 5b07          	addw	sp,#7
 143  0038 81            	ret	
 234                     ; 88 void FillExp(pointarraysamples arrayexp)
 234                     ; 89 {
 235                     	switch	.text
 236  0039               _FillExp:
 238  0039 89            	pushw	x
 239  003a 520c          	subw	sp,#12
 240       0000000c      OFST:	set	12
 243                     ; 91   i=0;
 245  003c 5f            	clrw	x
 246  003d 1f07          	ldw	(OFST-5,sp),x
 247                     ; 92   powr=1;
 249  003f 5c            	incw	x
 250  0040 1f09          	ldw	(OFST-3,sp),x
 251                     ; 93   for (m=1; m<=nbit;m++)
 253  0042 cc00d8        	jra	L721
 254  0045               L321:
 255                     ; 95     for (k=0;k<=(powr-1);k++)
 257  0045 5f            	clrw	x
 259  0046 207d          	jra	L731
 260  0048               L331:
 261                     ; 97       (*arrayexp)[i].r = (double)multiplierEnaX*cos(-M_PI*(double)k/powr);
 263  0048 1e09          	ldw	x,(OFST-3,sp)
 264  004a cd0000        	call	c_uitof
 266  004d 96            	ldw	x,sp
 267  004e 5c            	incw	x
 268  004f cd0000        	call	c_rtol
 270  0052 1e0b          	ldw	x,(OFST-1,sp)
 271  0054 cd0000        	call	c_uitof
 273  0057 ae014a        	ldw	x,#L741
 274  005a cd0000        	call	c_fmul
 276  005d 96            	ldw	x,sp
 277  005e 5c            	incw	x
 278  005f cd0000        	call	c_fdiv
 280  0062 be02          	ldw	x,c_lreg+2
 281  0064 89            	pushw	x
 282  0065 be00          	ldw	x,c_lreg
 283  0067 89            	pushw	x
 284  0068 cd0000        	call	_cos
 286  006b 5b04          	addw	sp,#4
 287  006d ae0152        	ldw	x,#L751
 288  0070 cd0000        	call	c_fmul
 290  0073 1e07          	ldw	x,(OFST-5,sp)
 291  0075 58            	sllw	x
 292  0076 58            	sllw	x
 293  0077 58            	sllw	x
 294  0078 72fb0d        	addw	x,(OFST+1,sp)
 295  007b cd0000        	call	c_ftol
 297  007e cd0000        	call	c_rtol
 299                     ; 98       (*arrayexp)[i].i = (double)multiplierEnaX*sin(-M_PI*(double)k/powr);
 301  0081 1e09          	ldw	x,(OFST-3,sp)
 302  0083 cd0000        	call	c_uitof
 304  0086 96            	ldw	x,sp
 305  0087 5c            	incw	x
 306  0088 cd0000        	call	c_rtol
 308  008b 1e0b          	ldw	x,(OFST-1,sp)
 309  008d cd0000        	call	c_uitof
 311  0090 ae014a        	ldw	x,#L741
 312  0093 cd0000        	call	c_fmul
 314  0096 96            	ldw	x,sp
 315  0097 5c            	incw	x
 316  0098 cd0000        	call	c_fdiv
 318  009b be02          	ldw	x,c_lreg+2
 319  009d 89            	pushw	x
 320  009e be00          	ldw	x,c_lreg
 321  00a0 89            	pushw	x
 322  00a1 cd0000        	call	_sin
 324  00a4 5b04          	addw	sp,#4
 325  00a6 ae0152        	ldw	x,#L751
 326  00a9 cd0000        	call	c_fmul
 328  00ac 1e07          	ldw	x,(OFST-5,sp)
 329  00ae 58            	sllw	x
 330  00af 58            	sllw	x
 331  00b0 58            	sllw	x
 332  00b1 72fb0d        	addw	x,(OFST+1,sp)
 333  00b4 cd0000        	call	c_ftol
 335  00b7 1c0004        	addw	x,#4
 336  00ba cd0000        	call	c_rtol
 338                     ; 99       i++;
 340  00bd 1e07          	ldw	x,(OFST-5,sp)
 341  00bf 5c            	incw	x
 342  00c0 1f07          	ldw	(OFST-5,sp),x
 343                     ; 95     for (k=0;k<=(powr-1);k++)
 345  00c2 1e0b          	ldw	x,(OFST-1,sp)
 346  00c4 5c            	incw	x
 347  00c5               L731:
 348  00c5 1f0b          	ldw	(OFST-1,sp),x
 351  00c7 1e09          	ldw	x,(OFST-3,sp)
 352  00c9 5a            	decw	x
 353  00ca 130b          	cpw	x,(OFST-1,sp)
 354  00cc 2503cc0048    	jruge	L331
 355                     ; 101     powr <<= 1;
 357  00d1 080a          	sll	(OFST-2,sp)
 358  00d3 0909          	rlc	(OFST-3,sp)
 359                     ; 93   for (m=1; m<=nbit;m++)
 361  00d5 1e05          	ldw	x,(OFST-7,sp)
 362  00d7 5c            	incw	x
 363  00d8               L721:
 365  00d8 1f05          	ldw	(OFST-7,sp),x
 368  00da c30002        	cpw	x,_nbit
 369  00dd 2203cc0045    	jrule	L321
 370                     ; 103 }/*FillExp*/
 373  00e2 5b0e          	addw	sp,#14
 374  00e4 81            	ret	
 418                     ; 106 void FillInv(pointarrayindex arrayinv)
 418                     ; 107 {
 419                     	switch	.text
 420  00e5               _FillInv:
 422  00e5 89            	pushw	x
 423  00e6 89            	pushw	x
 424       00000002      OFST:	set	2
 427                     ; 109    for (i=0;i<numsample;i++)
 429  00e7 5f            	clrw	x
 430  00e8 1f01          	ldw	(OFST-1,sp),x
 431  00ea               L302:
 432                     ; 111       (*arrayinv)[i]=flipbits(i);
 434  00ea cd0000        	call	_flipbits
 436  00ed 1601          	ldw	y,(OFST-1,sp)
 437  00ef 9058          	sllw	y
 438  00f1 72f903        	addw	y,(OFST+1,sp)
 439  00f4 90ff          	ldw	(y),x
 440                     ; 109    for (i=0;i<numsample;i++)
 442  00f6 1e01          	ldw	x,(OFST-1,sp)
 443  00f8 5c            	incw	x
 444  00f9 1f01          	ldw	(OFST-1,sp),x
 447  00fb a30020        	cpw	x,#32
 448  00fe 25ea          	jrult	L302
 449                     ; 113 }/*FillInv*/
 452  0100 5b04          	addw	sp,#4
 453  0102 81            	ret	
 552                     	switch	.const
 553  0014               L22:
 554  0014 00010000      	dc.l	65536
 555  0018               L42:
 556  0018 00000002      	dc.l	2
 557                     ; 116 void mulFFT(pointarraysamples psamples, unsigned int siz, unsigned int indexexponenta)
 557                     ; 117 {
 558                     	switch	.text
 559  0103               _mulFFT:
 561  0103 89            	pushw	x
 562  0104 5214          	subw	sp,#20
 563       00000014      OFST:	set	20
 566                     ; 121   siz2=siz >> 1;
 568  0106 1e19          	ldw	x,(OFST+5,sp)
 569  0108 54            	srlw	x
 570  0109 1f05          	ldw	(OFST-15,sp),x
 571                     ; 122   position=0;
 573  010b 5f            	clrw	x
 574  010c 1f0f          	ldw	(OFST-5,sp),x
 575                     ; 123   if (siz2>1)
 577  010e 1e05          	ldw	x,(OFST-15,sp)
 578  0110 a30002        	cpw	x,#2
 579  0113 2403cc01fd    	jrult	L352
 581  0118 1e0f          	ldw	x,(OFST-5,sp)
 582  011a cc01f5        	jra	L752
 583  011d               L552:
 584                     ; 127       indexexp=indexexponenta;
 586  011d 1e1b          	ldw	x,(OFST+7,sp)
 587  011f 1f11          	ldw	(OFST-3,sp),x
 588                     ; 128       for (i=(position+1+siz2);i<(position+siz);i++)
 590  0121 1e0f          	ldw	x,(OFST-5,sp)
 591  0123 72fb05        	addw	x,(OFST-15,sp)
 593  0126 cc01e4        	jra	L762
 594  0129               L362:
 595                     ; 130           a.r=((*arrayexp)[indexexp].r*(*psamples)[i].r-(*arrayexp)[indexexp].i*(*psamples)[i].i) / multiplierEnaX;
 597  0129 1e11          	ldw	x,(OFST-3,sp)
 598  012b 58            	sllw	x
 599  012c 58            	sllw	x
 600  012d 58            	sllw	x
 601  012e 72bb0008      	addw	x,_arrayexp
 602  0132 1c0004        	addw	x,#4
 603  0135 cd0000        	call	c_ltor
 605  0138 1e13          	ldw	x,(OFST-1,sp)
 606  013a 58            	sllw	x
 607  013b 58            	sllw	x
 608  013c 58            	sllw	x
 609  013d 72fb15        	addw	x,(OFST+1,sp)
 610  0140 1c0004        	addw	x,#4
 611  0143 cd0000        	call	c_lmul
 613  0146 96            	ldw	x,sp
 614  0147 5c            	incw	x
 615  0148 cd0000        	call	c_rtol
 617  014b 1e11          	ldw	x,(OFST-3,sp)
 618  014d 58            	sllw	x
 619  014e 58            	sllw	x
 620  014f 58            	sllw	x
 621  0150 72bb0008      	addw	x,_arrayexp
 622  0154 cd0000        	call	c_ltor
 624  0157 1e13          	ldw	x,(OFST-1,sp)
 625  0159 58            	sllw	x
 626  015a 58            	sllw	x
 627  015b 58            	sllw	x
 628  015c 72fb15        	addw	x,(OFST+1,sp)
 629  015f cd0000        	call	c_lmul
 631  0162 96            	ldw	x,sp
 632  0163 5c            	incw	x
 633  0164 cd0000        	call	c_lsub
 635  0167 ae0014        	ldw	x,#L22
 636  016a cd0000        	call	c_ldiv
 638  016d 96            	ldw	x,sp
 639  016e 1c0007        	addw	x,#OFST-13
 640  0171 cd0000        	call	c_rtol
 642                     ; 131           (*psamples)[i].i=((*arrayexp)[indexexp].r*(*psamples)[i].i+(*arrayexp)[indexexp].i*(*psamples)[i].r) / multiplierEnaX;
 644  0174 1e11          	ldw	x,(OFST-3,sp)
 645  0176 58            	sllw	x
 646  0177 58            	sllw	x
 647  0178 58            	sllw	x
 648  0179 72bb0008      	addw	x,_arrayexp
 649  017d 1c0004        	addw	x,#4
 650  0180 cd0000        	call	c_ltor
 652  0183 1e13          	ldw	x,(OFST-1,sp)
 653  0185 58            	sllw	x
 654  0186 58            	sllw	x
 655  0187 58            	sllw	x
 656  0188 72fb15        	addw	x,(OFST+1,sp)
 657  018b cd0000        	call	c_lmul
 659  018e 96            	ldw	x,sp
 660  018f 5c            	incw	x
 661  0190 cd0000        	call	c_rtol
 663  0193 1e11          	ldw	x,(OFST-3,sp)
 664  0195 58            	sllw	x
 665  0196 58            	sllw	x
 666  0197 58            	sllw	x
 667  0198 72bb0008      	addw	x,_arrayexp
 668  019c cd0000        	call	c_ltor
 670  019f 1e13          	ldw	x,(OFST-1,sp)
 671  01a1 58            	sllw	x
 672  01a2 58            	sllw	x
 673  01a3 58            	sllw	x
 674  01a4 72fb15        	addw	x,(OFST+1,sp)
 675  01a7 1c0004        	addw	x,#4
 676  01aa cd0000        	call	c_lmul
 678  01ad 96            	ldw	x,sp
 679  01ae 5c            	incw	x
 680  01af cd0000        	call	c_ladd
 682  01b2 ae0014        	ldw	x,#L22
 683  01b5 cd0000        	call	c_ldiv
 685  01b8 1e13          	ldw	x,(OFST-1,sp)
 686  01ba 58            	sllw	x
 687  01bb 58            	sllw	x
 688  01bc 58            	sllw	x
 689  01bd 72fb15        	addw	x,(OFST+1,sp)
 690  01c0 1c0004        	addw	x,#4
 691  01c3 cd0000        	call	c_rtol
 693                     ; 132           (*psamples)[i].r=a.r;
 695  01c6 1e13          	ldw	x,(OFST-1,sp)
 696  01c8 58            	sllw	x
 697  01c9 58            	sllw	x
 698  01ca 58            	sllw	x
 699  01cb 72fb15        	addw	x,(OFST+1,sp)
 700  01ce 7b0a          	ld	a,(OFST-10,sp)
 701  01d0 e703          	ld	(3,x),a
 702  01d2 7b09          	ld	a,(OFST-11,sp)
 703  01d4 e702          	ld	(2,x),a
 704  01d6 7b08          	ld	a,(OFST-12,sp)
 705  01d8 e701          	ld	(1,x),a
 706  01da 7b07          	ld	a,(OFST-13,sp)
 707  01dc f7            	ld	(x),a
 708                     ; 133           indexexp++;
 710  01dd 1e11          	ldw	x,(OFST-3,sp)
 711  01df 5c            	incw	x
 712  01e0 1f11          	ldw	(OFST-3,sp),x
 713                     ; 128       for (i=(position+1+siz2);i<(position+siz);i++)
 715  01e2 1e13          	ldw	x,(OFST-1,sp)
 716  01e4               L762:
 717  01e4 5c            	incw	x
 718  01e5 1f13          	ldw	(OFST-1,sp),x
 721  01e7 1e0f          	ldw	x,(OFST-5,sp)
 722  01e9 72fb19        	addw	x,(OFST+5,sp)
 723  01ec 1313          	cpw	x,(OFST-1,sp)
 724  01ee 2303cc0129    	jrugt	L362
 725                     ; 135       position+=siz;
 727  01f3 1f0f          	ldw	(OFST-5,sp),x
 728  01f5               L752:
 729                     ; 125      while (position< numsample)
 731  01f5 a30020        	cpw	x,#32
 732  01f8 2403cc011d    	jrult	L552
 733  01fd               L352:
 734                     ; 138   position=0;
 736  01fd 5f            	clrw	x
 737  01fe 1f0f          	ldw	(OFST-5,sp),x
 738                     ; 139   j=position+siz2;
 740  0200 1e05          	ldw	x,(OFST-15,sp)
 742  0202 cc02dd        	jra	L772
 743                     ; 142     for (i=position;i<(siz2+position);i++)
 745  0205               L303:
 746                     ; 144       a.r=((*psamples)[i].r+(*psamples)[j].r)/2;
 748  0205 1e11          	ldw	x,(OFST-3,sp)
 749  0207 58            	sllw	x
 750  0208 58            	sllw	x
 751  0209 58            	sllw	x
 752  020a 72fb15        	addw	x,(OFST+1,sp)
 753  020d cd0000        	call	c_ltor
 755  0210 1e13          	ldw	x,(OFST-1,sp)
 756  0212 58            	sllw	x
 757  0213 58            	sllw	x
 758  0214 58            	sllw	x
 759  0215 72fb15        	addw	x,(OFST+1,sp)
 760  0218 cd0000        	call	c_ladd
 762  021b ae0018        	ldw	x,#L42
 763  021e cd0000        	call	c_ldiv
 765  0221 96            	ldw	x,sp
 766  0222 1c0007        	addw	x,#OFST-13
 767  0225 cd0000        	call	c_rtol
 769                     ; 145       a.i=((*psamples)[i].i+(*psamples)[j].i)/2;
 771  0228 1e11          	ldw	x,(OFST-3,sp)
 772  022a 58            	sllw	x
 773  022b 58            	sllw	x
 774  022c 58            	sllw	x
 775  022d 72fb15        	addw	x,(OFST+1,sp)
 776  0230 1c0004        	addw	x,#4
 777  0233 cd0000        	call	c_ltor
 779  0236 1e13          	ldw	x,(OFST-1,sp)
 780  0238 58            	sllw	x
 781  0239 58            	sllw	x
 782  023a 58            	sllw	x
 783  023b 72fb15        	addw	x,(OFST+1,sp)
 784  023e 1c0004        	addw	x,#4
 785  0241 cd0000        	call	c_ladd
 787  0244 ae0018        	ldw	x,#L42
 788  0247 cd0000        	call	c_ldiv
 790  024a 96            	ldw	x,sp
 791  024b 1c000b        	addw	x,#OFST-9
 792  024e cd0000        	call	c_rtol
 794                     ; 146       (*psamples)[j].r=((*psamples)[i].r-(*psamples)[j].r)/2;
 796  0251 1e13          	ldw	x,(OFST-1,sp)
 797  0253 58            	sllw	x
 798  0254 58            	sllw	x
 799  0255 58            	sllw	x
 800  0256 72fb15        	addw	x,(OFST+1,sp)
 801  0259 cd0000        	call	c_ltor
 803  025c 1e11          	ldw	x,(OFST-3,sp)
 804  025e 58            	sllw	x
 805  025f 58            	sllw	x
 806  0260 58            	sllw	x
 807  0261 72fb15        	addw	x,(OFST+1,sp)
 808  0264 cd0000        	call	c_lsub
 810  0267 ae0018        	ldw	x,#L42
 811  026a cd0000        	call	c_ldiv
 813  026d 1e11          	ldw	x,(OFST-3,sp)
 814  026f 58            	sllw	x
 815  0270 58            	sllw	x
 816  0271 58            	sllw	x
 817  0272 72fb15        	addw	x,(OFST+1,sp)
 818  0275 cd0000        	call	c_rtol
 820                     ; 147       (*psamples)[j].i=((*psamples)[i].i-(*psamples)[j].i)/2;
 822  0278 1e13          	ldw	x,(OFST-1,sp)
 823  027a 58            	sllw	x
 824  027b 58            	sllw	x
 825  027c 58            	sllw	x
 826  027d 72fb15        	addw	x,(OFST+1,sp)
 827  0280 1c0004        	addw	x,#4
 828  0283 cd0000        	call	c_ltor
 830  0286 1e11          	ldw	x,(OFST-3,sp)
 831  0288 58            	sllw	x
 832  0289 58            	sllw	x
 833  028a 58            	sllw	x
 834  028b 72fb15        	addw	x,(OFST+1,sp)
 835  028e 1c0004        	addw	x,#4
 836  0291 cd0000        	call	c_lsub
 838  0294 ae0018        	ldw	x,#L42
 839  0297 cd0000        	call	c_ldiv
 841  029a 1e11          	ldw	x,(OFST-3,sp)
 842  029c 58            	sllw	x
 843  029d 58            	sllw	x
 844  029e 58            	sllw	x
 845  029f 72fb15        	addw	x,(OFST+1,sp)
 846  02a2 1c0004        	addw	x,#4
 847  02a5 cd0000        	call	c_rtol
 849                     ; 148       (*psamples)[i]=a;
 851  02a8 1e13          	ldw	x,(OFST-1,sp)
 852  02aa 58            	sllw	x
 853  02ab 58            	sllw	x
 854  02ac 58            	sllw	x
 855  02ad 72fb15        	addw	x,(OFST+1,sp)
 856  02b0 9096          	ldw	y,sp
 857  02b2 72a90007      	addw	y,#OFST-13
 858  02b6 a608          	ld	a,#8
 859  02b8 cd0000        	call	c_xymvx
 861                     ; 149       j++;
 863  02bb 1e11          	ldw	x,(OFST-3,sp)
 864  02bd 5c            	incw	x
 865  02be 1f11          	ldw	(OFST-3,sp),x
 866                     ; 142     for (i=position;i<(siz2+position);i++)
 868  02c0 1e13          	ldw	x,(OFST-1,sp)
 869  02c2 5c            	incw	x
 870  02c3               L703:
 872  02c3 1f13          	ldw	(OFST-1,sp),x
 875  02c5 1e05          	ldw	x,(OFST-15,sp)
 876  02c7 72fb0f        	addw	x,(OFST-5,sp)
 877  02ca 1313          	cpw	x,(OFST-1,sp)
 878  02cc 2303cc0205    	jrugt	L303
 879                     ; 151     position+=siz;
 881  02d1 1e0f          	ldw	x,(OFST-5,sp)
 882  02d3 72fb19        	addw	x,(OFST+5,sp)
 883  02d6 1f0f          	ldw	(OFST-5,sp),x
 884                     ; 152     j+=siz2;
 886  02d8 1e11          	ldw	x,(OFST-3,sp)
 887  02da 72fb05        	addw	x,(OFST-15,sp)
 888  02dd               L772:
 889  02dd 1f11          	ldw	(OFST-3,sp),x
 890                     ; 140   while (position< numsample)
 892  02df 1e0f          	ldw	x,(OFST-5,sp)
 893  02e1 a30020        	cpw	x,#32
 894  02e4 25dd          	jrult	L703
 895                     ; 154 }/*mulFFT*/
 898  02e6 5b16          	addw	sp,#22
 899  02e8 81            	ret	
 960                     ; 157 void FFT(pointarraysamples psamples)
 960                     ; 158 {
 961                     	switch	.text
 962  02e9               _FFT:
 964  02e9 89            	pushw	x
 965  02ea 5206          	subw	sp,#6
 966       00000006      OFST:	set	6
 969                     ; 162   siz2=1;
 971  02ec ae0001        	ldw	x,#1
 972  02ef 1f05          	ldw	(OFST-1,sp),x
 973                     ; 163   for (k=0;k<nbit;k++)
 975  02f1 5f            	clrw	x
 977  02f2 2016          	jra	L543
 978  02f4               L143:
 979                     ; 165     indexexp=siz2;   // index exp pola+1
 981  02f4 1e05          	ldw	x,(OFST-1,sp)
 982  02f6 1f01          	ldw	(OFST-5,sp),x
 983                     ; 166     siz2 <<= 1;      // blocks size
 985  02f8 0806          	sll	(OFST+0,sp)
 986  02fa 0905          	rlc	(OFST-1,sp)
 987                     ; 167     mulFFT(psamples,siz2,indexexp);
 989  02fc 89            	pushw	x
 990  02fd 1e07          	ldw	x,(OFST+1,sp)
 991  02ff 89            	pushw	x
 992  0300 1e0b          	ldw	x,(OFST+5,sp)
 993  0302 cd0103        	call	_mulFFT
 995  0305 5b04          	addw	sp,#4
 996                     ; 163   for (k=0;k<nbit;k++)
 998  0307 1e03          	ldw	x,(OFST-3,sp)
 999  0309 5c            	incw	x
1000  030a               L543:
1001  030a 1f03          	ldw	(OFST-3,sp),x
1004  030c c30002        	cpw	x,_nbit
1005  030f 25e3          	jrult	L143
1006                     ; 169 }/*FFT*/
1009  0311 5b08          	addw	sp,#8
1010  0313 81            	ret	
1267                     ; 172 long int FillSamplesInv(pointEvalBoardADCarray BufferEvalBoardADC, pointarraysamples samples, char channel, char channels,double samplingError)
1267                     ; 173 {
1268                     	switch	.text
1269  0314               _FillSamplesInv:
1271  0314 89            	pushw	x
1272  0315 523d          	subw	sp,#61
1273       0000003d      OFST:	set	61
1276                     ; 175   signed long error=-1;
1278  0317 aeffff        	ldw	x,#65535
1279  031a 1f2f          	ldw	(OFST-14,sp),x
1280  031c 1f2d          	ldw	(OFST-16,sp),x
1281                     ; 177   const signed long datamultiplier = 8;
1283  031e ae0008        	ldw	x,#8
1284  0321 1f33          	ldw	(OFST-10,sp),x
1285  0323 5f            	clrw	x
1286  0324 1f31          	ldw	(OFST-12,sp),x
1287                     ; 178   const signed long datamultiplier2 = datamultiplier*2;
1289  0326 96            	ldw	x,sp
1290  0327 1c0031        	addw	x,#OFST-12
1291  032a cd0000        	call	c_ltor
1293  032d 3803          	sll	c_lreg+3
1294  032f 3902          	rlc	c_lreg+2
1295  0331 3901          	rlc	c_lreg+1
1296  0333 96            	ldw	x,sp
1297  0334 3900          	rlc	c_lreg
1298  0336 1c0036        	addw	x,#OFST-7
1299  0339 cd0000        	call	c_rtol
1301  033c               L774:
1302                     ; 182      }while (ConvertInProgress(&param));     //   END OF ALL CONVERSIONS (=0 if all data transfered; =1 if data transfer in progress)
1304  033c ae0000        	ldw	x,#_param
1305  033f cd0000        	call	_ConvertInProgress
1307  0342 4d            	tnz	a
1308  0343 26f7          	jrne	L774
1309                     ; 185 if (interpolation == no_interpolation)
1311  0345 c60000        	ld	a,_interpolation
1312  0348 267b          	jrne	L305
1313                     ; 188   channeltemp=channel+1;
1315  034a 7b44          	ld	a,(OFST+7,sp)
1316  034c 4c            	inc	a
1317  034d 6b35          	ld	(OFST-8,sp),a
1318                     ; 189   for (i=0;i<numsample;i++)
1320  034f 5f            	clrw	x
1321  0350 1f3c          	ldw	(OFST-1,sp),x
1322  0352               L505:
1323                     ; 191     w = (*arrayinv)[i];
1325  0352 58            	sllw	x
1326  0353 72de0004      	ldw	x,([_arrayinv.w],x)
1327  0357 1f3a          	ldw	(OFST-3,sp),x
1328                     ; 192     (*samples)[i].r = ((((*BufferEvalBoardADC)[channel+channels*(w)]) >> 4))*(datamultiplier2);
1330  0359 5f            	clrw	x
1331  035a 7b45          	ld	a,(OFST+8,sp)
1332  035c 97            	ld	xl,a
1333  035d 163a          	ldw	y,(OFST-3,sp)
1334  035f cd0000        	call	c_imul
1336  0362 01            	rrwa	x,a
1337  0363 1b44          	add	a,(OFST+7,sp)
1338  0365 2401          	jrnc	L63
1339  0367 5c            	incw	x
1340  0368               L63:
1341  0368 02            	rlwa	x,a
1342  0369 58            	sllw	x
1343  036a 72fb3e        	addw	x,(OFST+1,sp)
1344  036d fe            	ldw	x,(x)
1345  036e 57            	sraw	x
1346  036f 57            	sraw	x
1347  0370 57            	sraw	x
1348  0371 57            	sraw	x
1349  0372 cd0000        	call	c_itolx
1351  0375 96            	ldw	x,sp
1352  0376 1c0036        	addw	x,#OFST-7
1353  0379 cd0000        	call	c_lmul
1355  037c 1e3c          	ldw	x,(OFST-1,sp)
1356  037e 58            	sllw	x
1357  037f 58            	sllw	x
1358  0380 58            	sllw	x
1359  0381 72fb42        	addw	x,(OFST+5,sp)
1360  0384 cd0000        	call	c_rtol
1362                     ; 193     (*samples)[i].i = ((((*BufferEvalBoardADC)[channeltemp+channels*(w)]) >> 4))*(datamultiplier2);
1364  0387 7b45          	ld	a,(OFST+8,sp)
1365  0389 5f            	clrw	x
1366  038a 97            	ld	xl,a
1367  038b 163a          	ldw	y,(OFST-3,sp)
1368  038d cd0000        	call	c_imul
1370  0390 01            	rrwa	x,a
1371  0391 1b35          	add	a,(OFST-8,sp)
1372  0393 2401          	jrnc	L04
1373  0395 5c            	incw	x
1374  0396               L04:
1375  0396 02            	rlwa	x,a
1376  0397 58            	sllw	x
1377  0398 72fb3e        	addw	x,(OFST+1,sp)
1378  039b fe            	ldw	x,(x)
1379  039c 57            	sraw	x
1380  039d 57            	sraw	x
1381  039e 57            	sraw	x
1382  039f 57            	sraw	x
1383  03a0 cd0000        	call	c_itolx
1385  03a3 96            	ldw	x,sp
1386  03a4 1c0036        	addw	x,#OFST-7
1387  03a7 cd0000        	call	c_lmul
1389  03aa 1e3c          	ldw	x,(OFST-1,sp)
1390  03ac 58            	sllw	x
1391  03ad 58            	sllw	x
1392  03ae 58            	sllw	x
1393  03af 72fb42        	addw	x,(OFST+5,sp)
1394  03b2 1c0004        	addw	x,#4
1395  03b5 cd0000        	call	c_rtol
1397                     ; 189   for (i=0;i<numsample;i++)
1399  03b8 1e3c          	ldw	x,(OFST-1,sp)
1400  03ba 5c            	incw	x
1401  03bb 1f3c          	ldw	(OFST-1,sp),x
1404  03bd a30020        	cpw	x,#32
1405  03c0 2590          	jrult	L505
1407  03c2 cc085f        	jra	L315
1408  03c5               L305:
1409                     ; 197 else if (interpolation==linear_interpolation)
1411  03c5 a101          	cp	a,#1
1412  03c7 2703cc0540    	jrne	L515
1413                     ; 202   signed long errorPrecision = 100000l;
1415  03cc ae86a0        	ldw	x,#34464
1416  03cf 1f23          	ldw	(OFST-26,sp),x
1417  03d1 ae0001        	ldw	x,#1
1418  03d4 1f21          	ldw	(OFST-28,sp),x
1419                     ; 203   signed long samplingerror2 = (samplingError*errorPrecision);
1421  03d6 96            	ldw	x,sp
1422  03d7 1c0046        	addw	x,#OFST+9
1423  03da cd0000        	call	c_ltor
1425  03dd ae0146        	ldw	x,#L325
1426  03e0 cd0000        	call	c_fmul
1428  03e3 cd0000        	call	c_ftol
1430  03e6 96            	ldw	x,sp
1431  03e7 1c0031        	addw	x,#OFST-12
1432  03ea cd0000        	call	c_rtol
1434                     ; 206   channeltemp=channel+1;
1436  03ed 7b44          	ld	a,(OFST+7,sp)
1437  03ef 4c            	inc	a
1438  03f0 6b35          	ld	(OFST-8,sp),a
1439                     ; 208   for (i=0;i<numsample;i++)
1441  03f2 5f            	clrw	x
1442  03f3 1f3c          	ldw	(OFST-1,sp),x
1443  03f5               L725:
1444                     ; 210     w = (*arrayinv)[i];
1446  03f5 58            	sllw	x
1447  03f6 72de0004      	ldw	x,([_arrayinv.w],x)
1448  03fa 1f3a          	ldw	(OFST-3,sp),x
1449                     ; 211     interp = (signed long)w * samplingerror2;
1451  03fc cd0000        	call	c_uitolx
1453  03ff 96            	ldw	x,sp
1454  0400 1c0031        	addw	x,#OFST-12
1455  0403 cd0000        	call	c_lmul
1457  0406 96            	ldw	x,sp
1458  0407 1c0029        	addw	x,#OFST-20
1459  040a cd0000        	call	c_rtol
1461                     ; 212     index = (interp/errorPrecision);
1463  040d 96            	ldw	x,sp
1464  040e 1c0029        	addw	x,#OFST-20
1465  0411 cd0000        	call	c_ltor
1467  0414 96            	ldw	x,sp
1468  0415 1c0021        	addw	x,#OFST-28
1469  0418 cd0000        	call	c_ldiv
1471  041b be02          	ldw	x,c_lreg+2
1472  041d 1f17          	ldw	(OFST-38,sp),x
1473                     ; 213     interp = interp % errorPrecision;
1475  041f 96            	ldw	x,sp
1476  0420 1c0029        	addw	x,#OFST-20
1477  0423 cd0000        	call	c_ltor
1479  0426 96            	ldw	x,sp
1480  0427 1c0021        	addw	x,#OFST-28
1481  042a cd0000        	call	c_lmod
1483  042d 96            	ldw	x,sp
1484  042e 1c0029        	addw	x,#OFST-20
1485  0431 cd0000        	call	c_rtol
1487                     ; 214     w -= index;
1489  0434 1e3a          	ldw	x,(OFST-3,sp)
1490  0436 72f017        	subw	x,(OFST-38,sp)
1491                     ; 216     sampleBuf0 = (((*BufferEvalBoardADC)[channel+(k=channels*(w--))]) >> 4);
1493  0439 5a            	decw	x
1494  043a 1f3a          	ldw	(OFST-3,sp),x
1495  043c 5c            	incw	x
1496  043d 7b45          	ld	a,(OFST+8,sp)
1497  043f 905f          	clrw	y
1498  0441 9097          	ld	yl,a
1499  0443 cd0000        	call	c_imul
1501  0446 1f19          	ldw	(OFST-36,sp),x
1502  0448 7b19          	ld	a,(OFST-36,sp)
1503  044a 97            	ld	xl,a
1504  044b 7b1a          	ld	a,(OFST-35,sp)
1505  044d 1b44          	add	a,(OFST+7,sp)
1506  044f 2401          	jrnc	L24
1507  0451 5c            	incw	x
1508  0452               L24:
1509  0452 02            	rlwa	x,a
1510  0453 58            	sllw	x
1511  0454 72fb3e        	addw	x,(OFST+1,sp)
1512  0457 fe            	ldw	x,(x)
1513  0458 57            	sraw	x
1514  0459 57            	sraw	x
1515  045a 57            	sraw	x
1516  045b 57            	sraw	x
1517  045c cd0000        	call	c_itolx
1519  045f 96            	ldw	x,sp
1520  0460 1c0025        	addw	x,#OFST-24
1521  0463 cd0000        	call	c_rtol
1523                     ; 217     sampleBuf1 = (((*BufferEvalBoardADC)[channel+(l=channels*(w))]) >> 4);
1525  0466 7b45          	ld	a,(OFST+8,sp)
1526  0468 5f            	clrw	x
1527  0469 97            	ld	xl,a
1528  046a 163a          	ldw	y,(OFST-3,sp)
1529  046c cd0000        	call	c_imul
1531  046f 1f1b          	ldw	(OFST-34,sp),x
1532  0471 7b1b          	ld	a,(OFST-34,sp)
1533  0473 97            	ld	xl,a
1534  0474 7b1c          	ld	a,(OFST-33,sp)
1535  0476 1b44          	add	a,(OFST+7,sp)
1536  0478 2401          	jrnc	L44
1537  047a 5c            	incw	x
1538  047b               L44:
1539  047b 02            	rlwa	x,a
1540  047c 58            	sllw	x
1541  047d 72fb3e        	addw	x,(OFST+1,sp)
1542  0480 fe            	ldw	x,(x)
1543  0481 57            	sraw	x
1544  0482 57            	sraw	x
1545  0483 57            	sraw	x
1546  0484 57            	sraw	x
1547  0485 cd0000        	call	c_itolx
1549  0488 96            	ldw	x,sp
1550  0489 1c001d        	addw	x,#OFST-32
1551  048c cd0000        	call	c_rtol
1553                     ; 218     (*samples)[i].r = ((sampleBuf0 + (interp * (sampleBuf1-sampleBuf0))/errorPrecision)) * datamultiplier2;
1555  048f 96            	ldw	x,sp
1556  0490 1c001d        	addw	x,#OFST-32
1557  0493 cd0000        	call	c_ltor
1559  0496 96            	ldw	x,sp
1560  0497 1c0025        	addw	x,#OFST-24
1561  049a cd0000        	call	c_lsub
1563  049d 96            	ldw	x,sp
1564  049e 1c0029        	addw	x,#OFST-20
1565  04a1 cd0000        	call	c_lmul
1567  04a4 96            	ldw	x,sp
1568  04a5 1c0021        	addw	x,#OFST-28
1569  04a8 cd0000        	call	c_ldiv
1571  04ab 96            	ldw	x,sp
1572  04ac 1c0025        	addw	x,#OFST-24
1573  04af cd0000        	call	c_ladd
1575  04b2 96            	ldw	x,sp
1576  04b3 1c0036        	addw	x,#OFST-7
1577  04b6 cd0000        	call	c_lmul
1579  04b9 1e3c          	ldw	x,(OFST-1,sp)
1580  04bb 58            	sllw	x
1581  04bc 58            	sllw	x
1582  04bd 58            	sllw	x
1583  04be 72fb42        	addw	x,(OFST+5,sp)
1584  04c1 cd0000        	call	c_rtol
1586                     ; 220     sampleBuf0 = (((*BufferEvalBoardADC)[channeltemp+k]) >> 4);
1588  04c4 7b35          	ld	a,(OFST-8,sp)
1589  04c6 5f            	clrw	x
1590  04c7 97            	ld	xl,a
1591  04c8 72fb19        	addw	x,(OFST-36,sp)
1592  04cb 58            	sllw	x
1593  04cc 72fb3e        	addw	x,(OFST+1,sp)
1594  04cf fe            	ldw	x,(x)
1595  04d0 57            	sraw	x
1596  04d1 57            	sraw	x
1597  04d2 57            	sraw	x
1598  04d3 57            	sraw	x
1599  04d4 cd0000        	call	c_itolx
1601  04d7 96            	ldw	x,sp
1602  04d8 1c0025        	addw	x,#OFST-24
1603  04db cd0000        	call	c_rtol
1605                     ; 221     sampleBuf1 = (((*BufferEvalBoardADC)[channeltemp+l]) >> 4);
1607  04de 7b35          	ld	a,(OFST-8,sp)
1608  04e0 5f            	clrw	x
1609  04e1 97            	ld	xl,a
1610  04e2 72fb1b        	addw	x,(OFST-34,sp)
1611  04e5 58            	sllw	x
1612  04e6 72fb3e        	addw	x,(OFST+1,sp)
1613  04e9 fe            	ldw	x,(x)
1614  04ea 57            	sraw	x
1615  04eb 57            	sraw	x
1616  04ec 57            	sraw	x
1617  04ed 57            	sraw	x
1618  04ee cd0000        	call	c_itolx
1620  04f1 96            	ldw	x,sp
1621  04f2 1c001d        	addw	x,#OFST-32
1622  04f5 cd0000        	call	c_rtol
1624                     ; 222     (*samples)[i].i = ((sampleBuf0 + (interp * (sampleBuf1-sampleBuf0))/errorPrecision)) * datamultiplier2;
1626  04f8 96            	ldw	x,sp
1627  04f9 1c001d        	addw	x,#OFST-32
1628  04fc cd0000        	call	c_ltor
1630  04ff 96            	ldw	x,sp
1631  0500 1c0025        	addw	x,#OFST-24
1632  0503 cd0000        	call	c_lsub
1634  0506 96            	ldw	x,sp
1635  0507 1c0029        	addw	x,#OFST-20
1636  050a cd0000        	call	c_lmul
1638  050d 96            	ldw	x,sp
1639  050e 1c0021        	addw	x,#OFST-28
1640  0511 cd0000        	call	c_ldiv
1642  0514 96            	ldw	x,sp
1643  0515 1c0025        	addw	x,#OFST-24
1644  0518 cd0000        	call	c_ladd
1646  051b 96            	ldw	x,sp
1647  051c 1c0036        	addw	x,#OFST-7
1648  051f cd0000        	call	c_lmul
1650  0522 1e3c          	ldw	x,(OFST-1,sp)
1651  0524 58            	sllw	x
1652  0525 58            	sllw	x
1653  0526 58            	sllw	x
1654  0527 72fb42        	addw	x,(OFST+5,sp)
1655  052a 1c0004        	addw	x,#4
1656  052d cd0000        	call	c_rtol
1658                     ; 208   for (i=0;i<numsample;i++)
1660  0530 1e3c          	ldw	x,(OFST-1,sp)
1661  0532 5c            	incw	x
1662  0533 1f3c          	ldw	(OFST-1,sp),x
1665  0535 a30020        	cpw	x,#32
1666  0538 2403cc03f5    	jrult	L725
1668  053d cc085f        	jra	L315
1669  0540               L515:
1670                     ; 226 else if (interpolation==kvadratic_interpolation)
1672  0540 a102          	cp	a,#2
1673  0542 26f9          	jrne	L315
1674                     ; 233   channeltemp=channel+1;
1676  0544 7b44          	ld	a,(OFST+7,sp)
1677  0546 4c            	inc	a
1678  0547 6b35          	ld	(OFST-8,sp),a
1679                     ; 234   for (i=0;i<numsample;i++)
1681  0549 5f            	clrw	x
1682  054a 1f3c          	ldw	(OFST-1,sp),x
1683  054c               L145:
1684                     ; 236     w = (*arrayinv)[i];
1686  054c 58            	sllw	x
1687  054d 72de0004      	ldw	x,([_arrayinv.w],x)
1688  0551 1f3a          	ldw	(OFST-3,sp),x
1689                     ; 237     interp = (samplingError*w);
1691  0553 cd0000        	call	c_uitof
1693  0556 96            	ldw	x,sp
1694  0557 1c0009        	addw	x,#OFST-52
1695  055a cd0000        	call	c_rtol
1697  055d 96            	ldw	x,sp
1698  055e 1c0046        	addw	x,#OFST+9
1699  0561 cd0000        	call	c_ltor
1701  0564 96            	ldw	x,sp
1702  0565 1c0009        	addw	x,#OFST-52
1703  0568 cd0000        	call	c_fmul
1705  056b 96            	ldw	x,sp
1706  056c 1c0029        	addw	x,#OFST-20
1707  056f cd0000        	call	c_rtol
1709                     ; 238     index = interp;
1711  0572 96            	ldw	x,sp
1712  0573 1c0029        	addw	x,#OFST-20
1713  0576 cd0000        	call	c_ltor
1715  0579 cd0000        	call	c_ftoi
1717  057c 1f13          	ldw	(OFST-42,sp),x
1718                     ; 239     interp = index-interp;
1720  057e cd0000        	call	c_uitof
1722  0581 96            	ldw	x,sp
1723  0582 1c0029        	addw	x,#OFST-20
1724  0585 cd0000        	call	c_fsub
1726  0588 96            	ldw	x,sp
1727  0589 1c0029        	addw	x,#OFST-20
1728  058c cd0000        	call	c_rtol
1730                     ; 240     w -= index;
1732  058f 1e3a          	ldw	x,(OFST-3,sp)
1733  0591 72f013        	subw	x,(OFST-42,sp)
1734                     ; 242     sampleBuf0 = (((*BufferEvalBoardADC)[channel+(k=channels*(w--))]) >> 4);
1736  0594 5a            	decw	x
1737  0595 1f3a          	ldw	(OFST-3,sp),x
1738  0597 5c            	incw	x
1739  0598 7b45          	ld	a,(OFST+8,sp)
1740  059a 905f          	clrw	y
1741  059c 9097          	ld	yl,a
1742  059e cd0000        	call	c_imul
1744  05a1 1f0d          	ldw	(OFST-48,sp),x
1745  05a3 7b0d          	ld	a,(OFST-48,sp)
1746  05a5 97            	ld	xl,a
1747  05a6 7b0e          	ld	a,(OFST-47,sp)
1748  05a8 1b44          	add	a,(OFST+7,sp)
1749  05aa 2401          	jrnc	L64
1750  05ac 5c            	incw	x
1751  05ad               L64:
1752  05ad 02            	rlwa	x,a
1753  05ae 58            	sllw	x
1754  05af 72fb3e        	addw	x,(OFST+1,sp)
1755  05b2 fe            	ldw	x,(x)
1756  05b3 57            	sraw	x
1757  05b4 57            	sraw	x
1758  05b5 57            	sraw	x
1759  05b6 57            	sraw	x
1760  05b7 cd0000        	call	c_itolx
1762  05ba 96            	ldw	x,sp
1763  05bb 1c0025        	addw	x,#OFST-24
1764  05be cd0000        	call	c_rtol
1766                     ; 243     sampleBuf1 = (((*BufferEvalBoardADC)[channel+(l=channels*(w--))]) >> 4);
1768  05c1 1e3a          	ldw	x,(OFST-3,sp)
1769  05c3 5a            	decw	x
1770  05c4 1f3a          	ldw	(OFST-3,sp),x
1771  05c6 5c            	incw	x
1772  05c7 7b45          	ld	a,(OFST+8,sp)
1773  05c9 905f          	clrw	y
1774  05cb 9097          	ld	yl,a
1775  05cd cd0000        	call	c_imul
1777  05d0 1f0f          	ldw	(OFST-46,sp),x
1778  05d2 7b0f          	ld	a,(OFST-46,sp)
1779  05d4 97            	ld	xl,a
1780  05d5 7b10          	ld	a,(OFST-45,sp)
1781  05d7 1b44          	add	a,(OFST+7,sp)
1782  05d9 2401          	jrnc	L05
1783  05db 5c            	incw	x
1784  05dc               L05:
1785  05dc 02            	rlwa	x,a
1786  05dd 58            	sllw	x
1787  05de 72fb3e        	addw	x,(OFST+1,sp)
1788  05e1 fe            	ldw	x,(x)
1789  05e2 57            	sraw	x
1790  05e3 57            	sraw	x
1791  05e4 57            	sraw	x
1792  05e5 57            	sraw	x
1793  05e6 cd0000        	call	c_itolx
1795  05e9 96            	ldw	x,sp
1796  05ea 1c0021        	addw	x,#OFST-28
1797  05ed cd0000        	call	c_rtol
1799                     ; 244     sampleBuf2 = (((*BufferEvalBoardADC)[channel+(m=channels*(w))]) >> 4);
1801  05f0 7b45          	ld	a,(OFST+8,sp)
1802  05f2 5f            	clrw	x
1803  05f3 97            	ld	xl,a
1804  05f4 163a          	ldw	y,(OFST-3,sp)
1805  05f6 cd0000        	call	c_imul
1807  05f9 1f11          	ldw	(OFST-44,sp),x
1808  05fb 7b11          	ld	a,(OFST-44,sp)
1809  05fd 97            	ld	xl,a
1810  05fe 7b12          	ld	a,(OFST-43,sp)
1811  0600 1b44          	add	a,(OFST+7,sp)
1812  0602 2401          	jrnc	L25
1813  0604 5c            	incw	x
1814  0605               L25:
1815  0605 02            	rlwa	x,a
1816  0606 58            	sllw	x
1817  0607 72fb3e        	addw	x,(OFST+1,sp)
1818  060a fe            	ldw	x,(x)
1819  060b 57            	sraw	x
1820  060c 57            	sraw	x
1821  060d 57            	sraw	x
1822  060e 57            	sraw	x
1823  060f cd0000        	call	c_itolx
1825  0612 96            	ldw	x,sp
1826  0613 1c0036        	addw	x,#OFST-7
1827  0616 cd0000        	call	c_rtol
1829                     ; 245     a=sampleBuf2-2*sampleBuf1+sampleBuf0;
1831  0619 96            	ldw	x,sp
1832  061a 1c0021        	addw	x,#OFST-28
1833  061d cd0000        	call	c_ltor
1835  0620 3803          	sll	c_lreg+3
1836  0622 3902          	rlc	c_lreg+2
1837  0624 3901          	rlc	c_lreg+1
1838  0626 96            	ldw	x,sp
1839  0627 3900          	rlc	c_lreg
1840  0629 1c0009        	addw	x,#OFST-52
1841  062c cd0000        	call	c_rtol
1843  062f 96            	ldw	x,sp
1844  0630 1c0036        	addw	x,#OFST-7
1845  0633 cd0000        	call	c_ltor
1847  0636 96            	ldw	x,sp
1848  0637 1c0009        	addw	x,#OFST-52
1849  063a cd0000        	call	c_lsub
1851  063d 96            	ldw	x,sp
1852  063e 1c0025        	addw	x,#OFST-24
1853  0641 cd0000        	call	c_ladd
1855  0644 96            	ldw	x,sp
1856  0645 1c0015        	addw	x,#OFST-40
1857  0648 cd0000        	call	c_rtol
1859                     ; 246     b=sampleBuf2-4*sampleBuf1+3*sampleBuf0;
1861  064b 96            	ldw	x,sp
1862  064c 1c0025        	addw	x,#OFST-24
1863  064f cd0000        	call	c_ltor
1865  0652 a603          	ld	a,#3
1866  0654 cd0000        	call	c_smul
1868  0657 96            	ldw	x,sp
1869  0658 1c0009        	addw	x,#OFST-52
1870  065b cd0000        	call	c_rtol
1872  065e 96            	ldw	x,sp
1873  065f 1c0021        	addw	x,#OFST-28
1874  0662 cd0000        	call	c_ltor
1876  0665 a602          	ld	a,#2
1877  0667 cd0000        	call	c_llsh
1879  066a 96            	ldw	x,sp
1880  066b 1c0005        	addw	x,#OFST-56
1881  066e cd0000        	call	c_rtol
1883  0671 96            	ldw	x,sp
1884  0672 1c0036        	addw	x,#OFST-7
1885  0675 cd0000        	call	c_ltor
1887  0678 96            	ldw	x,sp
1888  0679 1c0005        	addw	x,#OFST-56
1889  067c cd0000        	call	c_lsub
1891  067f 96            	ldw	x,sp
1892  0680 1c0009        	addw	x,#OFST-52
1893  0683 cd0000        	call	c_ladd
1895  0686 96            	ldw	x,sp
1896  0687 1c0019        	addw	x,#OFST-36
1897  068a cd0000        	call	c_rtol
1899                     ; 247     c=2*sampleBuf0;
1901  068d 96            	ldw	x,sp
1902  068e 1c0025        	addw	x,#OFST-24
1903  0691 cd0000        	call	c_ltor
1905  0694 3803          	sll	c_lreg+3
1906  0696 3902          	rlc	c_lreg+2
1907  0698 3901          	rlc	c_lreg+1
1908  069a 96            	ldw	x,sp
1909  069b 3900          	rlc	c_lreg
1910  069d 1c001d        	addw	x,#OFST-32
1911  06a0 cd0000        	call	c_rtol
1913                     ; 248     (*samples)[i].r = (((a*interp+b)*interp+c))*datamultiplier;
1915  06a3 96            	ldw	x,sp
1916  06a4 1c0031        	addw	x,#OFST-12
1917  06a7 cd0000        	call	c_ltor
1919  06aa cd0000        	call	c_ltof
1921  06ad 96            	ldw	x,sp
1922  06ae 1c0009        	addw	x,#OFST-52
1923  06b1 cd0000        	call	c_rtol
1925  06b4 96            	ldw	x,sp
1926  06b5 1c001d        	addw	x,#OFST-32
1927  06b8 cd0000        	call	c_ltor
1929  06bb cd0000        	call	c_ltof
1931  06be 96            	ldw	x,sp
1932  06bf 1c0005        	addw	x,#OFST-56
1933  06c2 cd0000        	call	c_rtol
1935  06c5 96            	ldw	x,sp
1936  06c6 1c0019        	addw	x,#OFST-36
1937  06c9 cd0000        	call	c_ltor
1939  06cc cd0000        	call	c_ltof
1941  06cf 96            	ldw	x,sp
1942  06d0 5c            	incw	x
1943  06d1 cd0000        	call	c_rtol
1945  06d4 96            	ldw	x,sp
1946  06d5 1c0015        	addw	x,#OFST-40
1947  06d8 cd0000        	call	c_ltor
1949  06db cd0000        	call	c_ltof
1951  06de 96            	ldw	x,sp
1952  06df 1c0029        	addw	x,#OFST-20
1953  06e2 cd0000        	call	c_fmul
1955  06e5 96            	ldw	x,sp
1956  06e6 5c            	incw	x
1957  06e7 cd0000        	call	c_fadd
1959  06ea 96            	ldw	x,sp
1960  06eb 1c0029        	addw	x,#OFST-20
1961  06ee cd0000        	call	c_fmul
1963  06f1 96            	ldw	x,sp
1964  06f2 1c0005        	addw	x,#OFST-56
1965  06f5 cd0000        	call	c_fadd
1967  06f8 96            	ldw	x,sp
1968  06f9 1c0009        	addw	x,#OFST-52
1969  06fc cd0000        	call	c_fmul
1971  06ff 1e3c          	ldw	x,(OFST-1,sp)
1972  0701 58            	sllw	x
1973  0702 58            	sllw	x
1974  0703 58            	sllw	x
1975  0704 72fb42        	addw	x,(OFST+5,sp)
1976  0707 cd0000        	call	c_ftol
1978  070a cd0000        	call	c_rtol
1980                     ; 250     sampleBuf0 = (((*BufferEvalBoardADC)[channeltemp+k]) >> 4);
1982  070d 7b35          	ld	a,(OFST-8,sp)
1983  070f 5f            	clrw	x
1984  0710 97            	ld	xl,a
1985  0711 72fb0d        	addw	x,(OFST-48,sp)
1986  0714 58            	sllw	x
1987  0715 72fb3e        	addw	x,(OFST+1,sp)
1988  0718 fe            	ldw	x,(x)
1989  0719 57            	sraw	x
1990  071a 57            	sraw	x
1991  071b 57            	sraw	x
1992  071c 57            	sraw	x
1993  071d cd0000        	call	c_itolx
1995  0720 96            	ldw	x,sp
1996  0721 1c0025        	addw	x,#OFST-24
1997  0724 cd0000        	call	c_rtol
1999                     ; 251     sampleBuf1 = (((*BufferEvalBoardADC)[channeltemp+l]) >> 4);
2001  0727 7b35          	ld	a,(OFST-8,sp)
2002  0729 5f            	clrw	x
2003  072a 97            	ld	xl,a
2004  072b 72fb0f        	addw	x,(OFST-46,sp)
2005  072e 58            	sllw	x
2006  072f 72fb3e        	addw	x,(OFST+1,sp)
2007  0732 fe            	ldw	x,(x)
2008  0733 57            	sraw	x
2009  0734 57            	sraw	x
2010  0735 57            	sraw	x
2011  0736 57            	sraw	x
2012  0737 cd0000        	call	c_itolx
2014  073a 96            	ldw	x,sp
2015  073b 1c0021        	addw	x,#OFST-28
2016  073e cd0000        	call	c_rtol
2018                     ; 252     sampleBuf2 = (((*BufferEvalBoardADC)[channeltemp+m]) >> 4);
2020  0741 7b35          	ld	a,(OFST-8,sp)
2021  0743 5f            	clrw	x
2022  0744 97            	ld	xl,a
2023  0745 72fb11        	addw	x,(OFST-44,sp)
2024  0748 58            	sllw	x
2025  0749 72fb3e        	addw	x,(OFST+1,sp)
2026  074c fe            	ldw	x,(x)
2027  074d 57            	sraw	x
2028  074e 57            	sraw	x
2029  074f 57            	sraw	x
2030  0750 57            	sraw	x
2031  0751 cd0000        	call	c_itolx
2033  0754 96            	ldw	x,sp
2034  0755 1c0036        	addw	x,#OFST-7
2035  0758 cd0000        	call	c_rtol
2037                     ; 253     a=sampleBuf2-2*sampleBuf1+sampleBuf0;
2039  075b 96            	ldw	x,sp
2040  075c 1c0021        	addw	x,#OFST-28
2041  075f cd0000        	call	c_ltor
2043  0762 3803          	sll	c_lreg+3
2044  0764 3902          	rlc	c_lreg+2
2045  0766 3901          	rlc	c_lreg+1
2046  0768 96            	ldw	x,sp
2047  0769 3900          	rlc	c_lreg
2048  076b 1c0009        	addw	x,#OFST-52
2049  076e cd0000        	call	c_rtol
2051  0771 96            	ldw	x,sp
2052  0772 1c0036        	addw	x,#OFST-7
2053  0775 cd0000        	call	c_ltor
2055  0778 96            	ldw	x,sp
2056  0779 1c0009        	addw	x,#OFST-52
2057  077c cd0000        	call	c_lsub
2059  077f 96            	ldw	x,sp
2060  0780 1c0025        	addw	x,#OFST-24
2061  0783 cd0000        	call	c_ladd
2063  0786 96            	ldw	x,sp
2064  0787 1c0015        	addw	x,#OFST-40
2065  078a cd0000        	call	c_rtol
2067                     ; 254     b=sampleBuf2-4*sampleBuf1+3*sampleBuf0;
2069  078d 96            	ldw	x,sp
2070  078e 1c0025        	addw	x,#OFST-24
2071  0791 cd0000        	call	c_ltor
2073  0794 a603          	ld	a,#3
2074  0796 cd0000        	call	c_smul
2076  0799 96            	ldw	x,sp
2077  079a 1c0009        	addw	x,#OFST-52
2078  079d cd0000        	call	c_rtol
2080  07a0 96            	ldw	x,sp
2081  07a1 1c0021        	addw	x,#OFST-28
2082  07a4 cd0000        	call	c_ltor
2084  07a7 a602          	ld	a,#2
2085  07a9 cd0000        	call	c_llsh
2087  07ac 96            	ldw	x,sp
2088  07ad 1c0005        	addw	x,#OFST-56
2089  07b0 cd0000        	call	c_rtol
2091  07b3 96            	ldw	x,sp
2092  07b4 1c0036        	addw	x,#OFST-7
2093  07b7 cd0000        	call	c_ltor
2095  07ba 96            	ldw	x,sp
2096  07bb 1c0005        	addw	x,#OFST-56
2097  07be cd0000        	call	c_lsub
2099  07c1 96            	ldw	x,sp
2100  07c2 1c0009        	addw	x,#OFST-52
2101  07c5 cd0000        	call	c_ladd
2103  07c8 96            	ldw	x,sp
2104  07c9 1c0019        	addw	x,#OFST-36
2105  07cc cd0000        	call	c_rtol
2107                     ; 255     c=2*sampleBuf0;
2109  07cf 96            	ldw	x,sp
2110  07d0 1c0025        	addw	x,#OFST-24
2111  07d3 cd0000        	call	c_ltor
2113  07d6 3803          	sll	c_lreg+3
2114  07d8 3902          	rlc	c_lreg+2
2115  07da 3901          	rlc	c_lreg+1
2116  07dc 96            	ldw	x,sp
2117  07dd 3900          	rlc	c_lreg
2118  07df 1c001d        	addw	x,#OFST-32
2119  07e2 cd0000        	call	c_rtol
2121                     ; 256     (*samples)[i].i = (((a*interp+b)*interp+c))*datamultiplier;
2123  07e5 96            	ldw	x,sp
2124  07e6 1c0031        	addw	x,#OFST-12
2125  07e9 cd0000        	call	c_ltor
2127  07ec cd0000        	call	c_ltof
2129  07ef 96            	ldw	x,sp
2130  07f0 1c0009        	addw	x,#OFST-52
2131  07f3 cd0000        	call	c_rtol
2133  07f6 96            	ldw	x,sp
2134  07f7 1c001d        	addw	x,#OFST-32
2135  07fa cd0000        	call	c_ltor
2137  07fd cd0000        	call	c_ltof
2139  0800 96            	ldw	x,sp
2140  0801 1c0005        	addw	x,#OFST-56
2141  0804 cd0000        	call	c_rtol
2143  0807 96            	ldw	x,sp
2144  0808 1c0019        	addw	x,#OFST-36
2145  080b cd0000        	call	c_ltor
2147  080e cd0000        	call	c_ltof
2149  0811 96            	ldw	x,sp
2150  0812 5c            	incw	x
2151  0813 cd0000        	call	c_rtol
2153  0816 96            	ldw	x,sp
2154  0817 1c0015        	addw	x,#OFST-40
2155  081a cd0000        	call	c_ltor
2157  081d cd0000        	call	c_ltof
2159  0820 96            	ldw	x,sp
2160  0821 1c0029        	addw	x,#OFST-20
2161  0824 cd0000        	call	c_fmul
2163  0827 96            	ldw	x,sp
2164  0828 5c            	incw	x
2165  0829 cd0000        	call	c_fadd
2167  082c 96            	ldw	x,sp
2168  082d 1c0029        	addw	x,#OFST-20
2169  0830 cd0000        	call	c_fmul
2171  0833 96            	ldw	x,sp
2172  0834 1c0005        	addw	x,#OFST-56
2173  0837 cd0000        	call	c_fadd
2175  083a 96            	ldw	x,sp
2176  083b 1c0009        	addw	x,#OFST-52
2177  083e cd0000        	call	c_fmul
2179  0841 1e3c          	ldw	x,(OFST-1,sp)
2180  0843 58            	sllw	x
2181  0844 58            	sllw	x
2182  0845 58            	sllw	x
2183  0846 72fb42        	addw	x,(OFST+5,sp)
2184  0849 cd0000        	call	c_ftol
2186  084c 1c0004        	addw	x,#4
2187  084f cd0000        	call	c_rtol
2189                     ; 234   for (i=0;i<numsample;i++)
2191  0852 1e3c          	ldw	x,(OFST-1,sp)
2192  0854 5c            	incw	x
2193  0855 1f3c          	ldw	(OFST-1,sp),x
2196  0857 a30020        	cpw	x,#32
2197  085a 2403cc054c    	jrult	L145
2198  085f               L315:
2199                     ; 260   return(error);
2201  085f 96            	ldw	x,sp
2202  0860 1c002d        	addw	x,#OFST-16
2203  0863 cd0000        	call	c_ltor
2207  0866 5b3f          	addw	sp,#63
2208  0868 81            	ret	
2247                     ; 287 void InitFFT(void)
2247                     ; 288 {
2248                     	switch	.text
2249  0869               _InitFFT:
2251  0869 5208          	subw	sp,#8
2252       00000008      OFST:	set	8
2255                     ; 289   nbit=floor(log(numsample)/log(2)+0.2);
2257  086b ce0140        	ldw	x,L375+2
2258  086e 89            	pushw	x
2259  086f ce013e        	ldw	x,L375
2260  0872 89            	pushw	x
2261  0873 cd0000        	call	_log
2263  0876 5b04          	addw	sp,#4
2264  0878 96            	ldw	x,sp
2265  0879 1c0005        	addw	x,#OFST-3
2266  087c cd0000        	call	c_rtol
2268  087f ce0144        	ldw	x,L365+2
2269  0882 89            	pushw	x
2270  0883 ce0142        	ldw	x,L365
2271  0886 89            	pushw	x
2272  0887 cd0000        	call	_log
2274  088a 5b04          	addw	sp,#4
2275  088c 96            	ldw	x,sp
2276  088d 1c0005        	addw	x,#OFST-3
2277  0890 cd0000        	call	c_fdiv
2279  0893 ae013a        	ldw	x,#L306
2280  0896 cd0000        	call	c_fadd
2282  0899 be02          	ldw	x,c_lreg+2
2283  089b 89            	pushw	x
2284  089c be00          	ldw	x,c_lreg
2285  089e 89            	pushw	x
2286  089f cd0000        	call	_floor
2288  08a2 5b04          	addw	sp,#4
2289  08a4 cd0000        	call	c_ftoi
2291  08a7 cf0002        	ldw	_nbit,x
2292                     ; 291   arrayexp=(pointarraysamples) malloc(sizeof(arraysamples));
2294  08aa ae0100        	ldw	x,#256
2295  08ad cd0000        	call	_malloc
2297  08b0 cf0008        	ldw	_arrayexp,x
2298                     ; 292   arrayinv=(pointarrayindex) malloc(sizeof(arrayindex));
2300  08b3 ae0040        	ldw	x,#64
2301  08b6 cd0000        	call	_malloc
2303  08b9 cf0004        	ldw	_arrayinv,x
2304                     ; 293   smpl=(pointarraysamples) malloc(sizeof(arraysamples));
2306  08bc ae0100        	ldw	x,#256
2307  08bf cd0000        	call	_malloc
2309  08c2 cf0006        	ldw	_smpl,x
2310                     ; 294   BufferEvalBoardADC=(pointEvalBoardADCarray) AllocateEvalBoardBuffer(&param);
2312  08c5 ae0000        	ldw	x,#_param
2313  08c8 cd0000        	call	_AllocateEvalBoardBuffer
2315  08cb cf000a        	ldw	_BufferEvalBoardADC,x
2316                     ; 295   AnaResults=(pointResults) malloc(sizeof(Results));
2318  08ce ae0348        	ldw	x,#840
2319  08d1 cd0000        	call	_malloc
2321  08d4 cf000c        	ldw	_AnaResults,x
2322                     ; 297   if((arrayexp==NULL) | (arrayinv==NULL) | (smpl==NULL) | (BufferEvalBoardADC==NULL) | (AnaResults==NULL))
2324  08d7 2603          	jrne	L67
2325  08d9 5c            	incw	x
2326  08da 2001          	jra	L001
2327  08dc               L67:
2328  08dc 5f            	clrw	x
2329  08dd               L001:
2330  08dd 1f07          	ldw	(OFST-1,sp),x
2331  08df ce000a        	ldw	x,_BufferEvalBoardADC
2332  08e2 2603          	jrne	L201
2333  08e4 5c            	incw	x
2334  08e5 2001          	jra	L401
2335  08e7               L201:
2336  08e7 5f            	clrw	x
2337  08e8               L401:
2338  08e8 1f05          	ldw	(OFST-3,sp),x
2339  08ea ce0006        	ldw	x,_smpl
2340  08ed 2603          	jrne	L601
2341  08ef 5c            	incw	x
2342  08f0 2001          	jra	L011
2343  08f2               L601:
2344  08f2 5f            	clrw	x
2345  08f3               L011:
2346  08f3 1f03          	ldw	(OFST-5,sp),x
2347  08f5 ce0004        	ldw	x,_arrayinv
2348  08f8 2603          	jrne	L211
2349  08fa 5c            	incw	x
2350  08fb 2001          	jra	L411
2351  08fd               L211:
2352  08fd 5f            	clrw	x
2353  08fe               L411:
2354  08fe 1f01          	ldw	(OFST-7,sp),x
2355  0900 ce0008        	ldw	x,_arrayexp
2356  0903 2603          	jrne	L611
2357  0905 5c            	incw	x
2358  0906 2001          	jra	L021
2359  0908               L611:
2360  0908 5f            	clrw	x
2361  0909               L021:
2362  0909 01            	rrwa	x,a
2363  090a 1a02          	or	a,(OFST-6,sp)
2364  090c 01            	rrwa	x,a
2365  090d 1a01          	or	a,(OFST-7,sp)
2366  090f 02            	rlwa	x,a
2367  0910 1a04          	or	a,(OFST-4,sp)
2368  0912 01            	rrwa	x,a
2369  0913 1a03          	or	a,(OFST-5,sp)
2370  0915 02            	rlwa	x,a
2371  0916 1a06          	or	a,(OFST-2,sp)
2372  0918 01            	rrwa	x,a
2373  0919 1a05          	or	a,(OFST-3,sp)
2374  091b 02            	rlwa	x,a
2375  091c 1a08          	or	a,(OFST+0,sp)
2376  091e 01            	rrwa	x,a
2377  091f 1a07          	or	a,(OFST-1,sp)
2378  0921 01            	rrwa	x,a
2379  0922 5d            	tnzw	x
2380  0923 270c          	jreq	L706
2381                     ; 299      sprintf(DEBUG_STRING, "Not enough memory for FFT\n");
2383  0925 ae011f        	ldw	x,#L116
2384  0928 89            	pushw	x
2385  0929 ce0000        	ldw	x,_DEBUG_STRING
2386  092c cd0000        	call	_sprintf
2388  092f 85            	popw	x
2389                     ; 300      _asm("trap\n");
2392  0930 83            	trap	
2394  0931               L706:
2395                     ; 302   FillExp(arrayexp);
2398  0931 ce0008        	ldw	x,_arrayexp
2399  0934 cd0039        	call	_FillExp
2401                     ; 303   FillInv(arrayinv);
2403  0937 ce0004        	ldw	x,_arrayinv
2404  093a cd00e5        	call	_FillInv
2406                     ; 304 }/*InitFFT;*/
2409  093d 5b08          	addw	sp,#8
2410  093f 81            	ret	
2440                     ; 308 void CloseFFT(void)
2440                     ; 309 {
2441                     	switch	.text
2442  0940               _CloseFFT:
2446                     ; 310   free(smpl);
2448  0940 ce0006        	ldw	x,_smpl
2449  0943 cd0000        	call	_free
2451                     ; 311   free(arrayexp);
2453  0946 ce0008        	ldw	x,_arrayexp
2454  0949 cd0000        	call	_free
2456                     ; 312   free(arrayinv);
2458  094c ce0004        	ldw	x,_arrayinv
2459  094f cd0000        	call	_free
2461                     ; 313   UnAllocateDataBuffer(&param);
2463  0952 ae0000        	ldw	x,#_param
2464  0955 cd0000        	call	_UnAllocateDataBuffer
2466                     ; 314   free(AnaResults);
2468  0958 ce000c        	ldw	x,_AnaResults
2470                     ; 315 }/*CloseFFT;*/
2473  095b cc0000        	jp	_free
2511                     ; 320 void PrintFFTAll(void)
2511                     ; 321 {
2512                     	switch	.text
2513  095e               _PrintFFTAll:
2515  095e 89            	pushw	x
2516       00000002      OFST:	set	2
2519                     ; 323   for(x=0;x<3;x++)
2521  095f 5f            	clrw	x
2522  0960 1f01          	ldw	(OFST-1,sp),x
2523  0962               L736:
2524                     ; 335     sprintf(DEBUG_STRING, "channel%u : Ue= %4.2fV, Ie= %4.2fA, Pe= %4.2fW, fi= %4.2f deg, dU= %4.2f%, dI= %4.2f%"
2524                     ; 336     ,x
2524                     ; 337     ,(* AnaResults).BasicResults[x][0]/multiplierU
2524                     ; 338     ,(* AnaResults).BasicResults[x][1]/multiplierI
2524                     ; 339     ,(* AnaResults).BasicResults[x][4]/(multiplierU*multiplierI)
2524                     ; 340     ,(* AnaResults).BasicResults[x][5]*180/M_PI
2524                     ; 341     ,(* AnaResults).BasicResults[x][2]
2524                     ; 342     ,(* AnaResults).BasicResults[x][3]);
2526  0962 90ae0018      	ldw	y,#24
2527  0966 cd0000        	call	c_imul
2529  0969 72bb000c      	addw	x,_AnaResults
2530  096d 9093          	ldw	y,x
2531  096f ee0e          	ldw	x,(14,x)
2532  0971 89            	pushw	x
2533  0972 93            	ldw	x,y
2534  0973 ee0c          	ldw	x,(12,x)
2535  0975 89            	pushw	x
2536  0976 1e05          	ldw	x,(OFST+3,sp)
2537  0978 90ae0018      	ldw	y,#24
2538  097c cd0000        	call	c_imul
2540  097f 72bb000c      	addw	x,_AnaResults
2541  0983 9093          	ldw	y,x
2542  0985 ee0a          	ldw	x,(10,x)
2543  0987 89            	pushw	x
2544  0988 93            	ldw	x,y
2545  0989 ee08          	ldw	x,(8,x)
2546  098b 89            	pushw	x
2547  098c 1e09          	ldw	x,(OFST+7,sp)
2548  098e 90ae0018      	ldw	y,#24
2549  0992 cd0000        	call	c_imul
2551  0995 72bb000c      	addw	x,_AnaResults
2552  0999 1c0014        	addw	x,#20
2553  099c cd0000        	call	c_ltor
2555  099f ae00c1        	ldw	x,#L366
2556  09a2 cd0000        	call	c_fmul
2558  09a5 ae014e        	ldw	x,#L376
2559  09a8 cd0000        	call	c_fdiv
2561  09ab be02          	ldw	x,c_lreg+2
2562  09ad 89            	pushw	x
2563  09ae be00          	ldw	x,c_lreg
2564  09b0 89            	pushw	x
2565  09b1 1e0d          	ldw	x,(OFST+11,sp)
2566  09b3 90ae0018      	ldw	y,#24
2567  09b7 cd0000        	call	c_imul
2569  09ba 72bb000c      	addw	x,_AnaResults
2570  09be 1c0010        	addw	x,#16
2571  09c1 cd0000        	call	c_ltor
2573  09c4 ae00c5        	ldw	x,#L356
2574  09c7 cd0000        	call	c_fdiv
2576  09ca be02          	ldw	x,c_lreg+2
2577  09cc 89            	pushw	x
2578  09cd be00          	ldw	x,c_lreg
2579  09cf 89            	pushw	x
2580  09d0 1e11          	ldw	x,(OFST+15,sp)
2581  09d2 90ae0018      	ldw	y,#24
2582  09d6 cd0000        	call	c_imul
2584  09d9 72bb000c      	addw	x,_AnaResults
2585  09dd 1c0004        	addw	x,#4
2586  09e0 cd0000        	call	c_ltor
2588  09e3 ae0008        	ldw	x,#L71
2589  09e6 cd0000        	call	c_fdiv
2591  09e9 be02          	ldw	x,c_lreg+2
2592  09eb 89            	pushw	x
2593  09ec be00          	ldw	x,c_lreg
2594  09ee 89            	pushw	x
2595  09ef 1e15          	ldw	x,(OFST+19,sp)
2596  09f1 90ae0018      	ldw	y,#24
2597  09f5 cd0000        	call	c_imul
2599  09f8 72bb000c      	addw	x,_AnaResults
2600  09fc cd0000        	call	c_ltor
2602  09ff ae0008        	ldw	x,#L71
2603  0a02 cd0000        	call	c_fdiv
2605  0a05 be02          	ldw	x,c_lreg+2
2606  0a07 89            	pushw	x
2607  0a08 be00          	ldw	x,c_lreg
2608  0a0a 89            	pushw	x
2609  0a0b 1e19          	ldw	x,(OFST+23,sp)
2610  0a0d 89            	pushw	x
2611  0a0e ae00c9        	ldw	x,#L546
2612  0a11 89            	pushw	x
2613  0a12 ce0000        	ldw	x,_DEBUG_STRING
2614  0a15 cd0000        	call	_sprintf
2616  0a18 5b1c          	addw	sp,#28
2617                     ; 345     LCD_RollString(LCD_LINE2, DEBUG_STRING, 600);
2619  0a1a ae0258        	ldw	x,#600
2620  0a1d 89            	pushw	x
2621  0a1e ce0000        	ldw	x,_DEBUG_STRING
2622  0a21 89            	pushw	x
2623  0a22 a690          	ld	a,#144
2624  0a24 cd0000        	call	_LCD_RollString
2626  0a27 5b04          	addw	sp,#4
2627                     ; 323   for(x=0;x<3;x++)
2629  0a29 1e01          	ldw	x,(OFST-1,sp)
2630  0a2b 5c            	incw	x
2631  0a2c 1f01          	ldw	(OFST-1,sp),x
2634  0a2e a30003        	cpw	x,#3
2635  0a31 2403cc0962    	jrult	L736
2636                     ; 347   sprintf(DEBUG_STRING, "\nHarmonics:\n");
2638  0a36 ae00b4        	ldw	x,#L776
2639  0a39 89            	pushw	x
2640  0a3a ce0000        	ldw	x,_DEBUG_STRING
2641  0a3d cd0000        	call	_sprintf
2643  0a40 85            	popw	x
2644                     ; 348   for (x=0;x<numsample/2;x++)
2646  0a41 5f            	clrw	x
2647  0a42 1f01          	ldw	(OFST-1,sp),x
2648  0a44               L107:
2649                     ; 350     sprintf(DEBUG_STRING, "%+10.6eV %+10.6ei   %+10.6eA %+10.6ei  |  "
2649                     ; 351       "%+10.6eV %+10.6ei   %+10.6eA %+10.6ei  |  "
2649                     ; 352       "%+10.6eV %+10.6ei   %+10.6eA %+10.6ei  |  "
2649                     ; 353       "\n",
2649                     ; 354       (* AnaResults).Harmonics[0][0][x].r*M_SQRT_2/multiplierU, (* AnaResults).Harmonics[0][0][x].i*M_SQRT_2/multiplierU, (* AnaResults).Harmonics[0][1][x].r*M_SQRT_2/multiplierI, (* AnaResults).Harmonics[0][1][x].i*M_SQRT_2/multiplierI,
2649                     ; 355       (* AnaResults).Harmonics[1][0][x].r*M_SQRT_2/multiplierU, (* AnaResults).Harmonics[1][0][x].i*M_SQRT_2/multiplierU, (* AnaResults).Harmonics[1][1][x].r*M_SQRT_2/multiplierI, (* AnaResults).Harmonics[1][1][x].i*M_SQRT_2/multiplierI,
2649                     ; 356       (* AnaResults).Harmonics[2][0][x].r*M_SQRT_2/multiplierU, (* AnaResults).Harmonics[2][0][x].i*M_SQRT_2/multiplierU, (* AnaResults).Harmonics[2][1][x].r*M_SQRT_2/multiplierI, (* AnaResults).Harmonics[2][1][x].i*M_SQRT_2/multiplierI
2649                     ; 357     );
2651  0a44 58            	sllw	x
2652  0a45 58            	sllw	x
2653  0a46 58            	sllw	x
2654  0a47 72bb000c      	addw	x,_AnaResults
2655  0a4b 1c02cc        	addw	x,#716
2656  0a4e cd0000        	call	c_ltor
2658  0a51 cd0000        	call	c_ltof
2660  0a54 ae0030        	ldw	x,#L517
2661  0a57 cd0000        	call	c_fmul
2663  0a5a ae0008        	ldw	x,#L71
2664  0a5d cd0000        	call	c_fdiv
2666  0a60 be02          	ldw	x,c_lreg+2
2667  0a62 89            	pushw	x
2668  0a63 be00          	ldw	x,c_lreg
2669  0a65 89            	pushw	x
2670  0a66 1e05          	ldw	x,(OFST+3,sp)
2671  0a68 58            	sllw	x
2672  0a69 58            	sllw	x
2673  0a6a 58            	sllw	x
2674  0a6b 72bb000c      	addw	x,_AnaResults
2675  0a6f 1c02c8        	addw	x,#712
2676  0a72 cd0000        	call	c_ltor
2678  0a75 cd0000        	call	c_ltof
2680  0a78 ae0030        	ldw	x,#L517
2681  0a7b cd0000        	call	c_fmul
2683  0a7e ae0008        	ldw	x,#L71
2684  0a81 cd0000        	call	c_fdiv
2686  0a84 be02          	ldw	x,c_lreg+2
2687  0a86 89            	pushw	x
2688  0a87 be00          	ldw	x,c_lreg
2689  0a89 89            	pushw	x
2690  0a8a 1e09          	ldw	x,(OFST+7,sp)
2691  0a8c 58            	sllw	x
2692  0a8d 58            	sllw	x
2693  0a8e 58            	sllw	x
2694  0a8f 72bb000c      	addw	x,_AnaResults
2695  0a93 1c024c        	addw	x,#588
2696  0a96 cd0000        	call	c_ltor
2698  0a99 cd0000        	call	c_ltof
2700  0a9c ae0030        	ldw	x,#L517
2701  0a9f cd0000        	call	c_fmul
2703  0aa2 ae0008        	ldw	x,#L71
2704  0aa5 cd0000        	call	c_fdiv
2706  0aa8 be02          	ldw	x,c_lreg+2
2707  0aaa 89            	pushw	x
2708  0aab be00          	ldw	x,c_lreg
2709  0aad 89            	pushw	x
2710  0aae 1e0d          	ldw	x,(OFST+11,sp)
2711  0ab0 58            	sllw	x
2712  0ab1 58            	sllw	x
2713  0ab2 58            	sllw	x
2714  0ab3 72bb000c      	addw	x,_AnaResults
2715  0ab7 1c0248        	addw	x,#584
2716  0aba cd0000        	call	c_ltor
2718  0abd cd0000        	call	c_ltof
2720  0ac0 ae0030        	ldw	x,#L517
2721  0ac3 cd0000        	call	c_fmul
2723  0ac6 ae0008        	ldw	x,#L71
2724  0ac9 cd0000        	call	c_fdiv
2726  0acc be02          	ldw	x,c_lreg+2
2727  0ace 89            	pushw	x
2728  0acf be00          	ldw	x,c_lreg
2729  0ad1 89            	pushw	x
2730  0ad2 1e11          	ldw	x,(OFST+15,sp)
2731  0ad4 58            	sllw	x
2732  0ad5 58            	sllw	x
2733  0ad6 58            	sllw	x
2734  0ad7 72bb000c      	addw	x,_AnaResults
2735  0adb 1c01cc        	addw	x,#460
2736  0ade cd0000        	call	c_ltor
2738  0ae1 cd0000        	call	c_ltof
2740  0ae4 ae0030        	ldw	x,#L517
2741  0ae7 cd0000        	call	c_fmul
2743  0aea ae0008        	ldw	x,#L71
2744  0aed cd0000        	call	c_fdiv
2746  0af0 be02          	ldw	x,c_lreg+2
2747  0af2 89            	pushw	x
2748  0af3 be00          	ldw	x,c_lreg
2749  0af5 89            	pushw	x
2750  0af6 1e15          	ldw	x,(OFST+19,sp)
2751  0af8 58            	sllw	x
2752  0af9 58            	sllw	x
2753  0afa 58            	sllw	x
2754  0afb 72bb000c      	addw	x,_AnaResults
2755  0aff 1c01c8        	addw	x,#456
2756  0b02 cd0000        	call	c_ltor
2758  0b05 cd0000        	call	c_ltof
2760  0b08 ae0030        	ldw	x,#L517
2761  0b0b cd0000        	call	c_fmul
2763  0b0e ae0008        	ldw	x,#L71
2764  0b11 cd0000        	call	c_fdiv
2766  0b14 be02          	ldw	x,c_lreg+2
2767  0b16 89            	pushw	x
2768  0b17 be00          	ldw	x,c_lreg
2769  0b19 89            	pushw	x
2770  0b1a 1e19          	ldw	x,(OFST+23,sp)
2771  0b1c 58            	sllw	x
2772  0b1d 58            	sllw	x
2773  0b1e 58            	sllw	x
2774  0b1f 72bb000c      	addw	x,_AnaResults
2775  0b23 1c014c        	addw	x,#332
2776  0b26 cd0000        	call	c_ltor
2778  0b29 cd0000        	call	c_ltof
2780  0b2c ae0030        	ldw	x,#L517
2781  0b2f cd0000        	call	c_fmul
2783  0b32 ae0008        	ldw	x,#L71
2784  0b35 cd0000        	call	c_fdiv
2786  0b38 be02          	ldw	x,c_lreg+2
2787  0b3a 89            	pushw	x
2788  0b3b be00          	ldw	x,c_lreg
2789  0b3d 89            	pushw	x
2790  0b3e 1e1d          	ldw	x,(OFST+27,sp)
2791  0b40 58            	sllw	x
2792  0b41 58            	sllw	x
2793  0b42 58            	sllw	x
2794  0b43 72bb000c      	addw	x,_AnaResults
2795  0b47 1c0148        	addw	x,#328
2796  0b4a cd0000        	call	c_ltor
2798  0b4d cd0000        	call	c_ltof
2800  0b50 ae0030        	ldw	x,#L517
2801  0b53 cd0000        	call	c_fmul
2803  0b56 ae0008        	ldw	x,#L71
2804  0b59 cd0000        	call	c_fdiv
2806  0b5c be02          	ldw	x,c_lreg+2
2807  0b5e 89            	pushw	x
2808  0b5f be00          	ldw	x,c_lreg
2809  0b61 89            	pushw	x
2810  0b62 1e21          	ldw	x,(OFST+31,sp)
2811  0b64 58            	sllw	x
2812  0b65 58            	sllw	x
2813  0b66 58            	sllw	x
2814  0b67 72bb000c      	addw	x,_AnaResults
2815  0b6b 1c00cc        	addw	x,#204
2816  0b6e cd0000        	call	c_ltor
2818  0b71 cd0000        	call	c_ltof
2820  0b74 ae0030        	ldw	x,#L517
2821  0b77 cd0000        	call	c_fmul
2823  0b7a ae0008        	ldw	x,#L71
2824  0b7d cd0000        	call	c_fdiv
2826  0b80 be02          	ldw	x,c_lreg+2
2827  0b82 89            	pushw	x
2828  0b83 be00          	ldw	x,c_lreg
2829  0b85 89            	pushw	x
2830  0b86 1e25          	ldw	x,(OFST+35,sp)
2831  0b88 58            	sllw	x
2832  0b89 58            	sllw	x
2833  0b8a 58            	sllw	x
2834  0b8b 72bb000c      	addw	x,_AnaResults
2835  0b8f 1c00c8        	addw	x,#200
2836  0b92 cd0000        	call	c_ltor
2838  0b95 cd0000        	call	c_ltof
2840  0b98 ae0030        	ldw	x,#L517
2841  0b9b cd0000        	call	c_fmul
2843  0b9e ae0008        	ldw	x,#L71
2844  0ba1 cd0000        	call	c_fdiv
2846  0ba4 be02          	ldw	x,c_lreg+2
2847  0ba6 89            	pushw	x
2848  0ba7 be00          	ldw	x,c_lreg
2849  0ba9 89            	pushw	x
2850  0baa 1e29          	ldw	x,(OFST+39,sp)
2851  0bac 58            	sllw	x
2852  0bad 58            	sllw	x
2853  0bae 58            	sllw	x
2854  0baf 72bb000c      	addw	x,_AnaResults
2855  0bb3 1c004c        	addw	x,#76
2856  0bb6 cd0000        	call	c_ltor
2858  0bb9 cd0000        	call	c_ltof
2860  0bbc ae0030        	ldw	x,#L517
2861  0bbf cd0000        	call	c_fmul
2863  0bc2 ae0008        	ldw	x,#L71
2864  0bc5 cd0000        	call	c_fdiv
2866  0bc8 be02          	ldw	x,c_lreg+2
2867  0bca 89            	pushw	x
2868  0bcb be00          	ldw	x,c_lreg
2869  0bcd 89            	pushw	x
2870  0bce 1e2d          	ldw	x,(OFST+43,sp)
2871  0bd0 58            	sllw	x
2872  0bd1 58            	sllw	x
2873  0bd2 58            	sllw	x
2874  0bd3 72bb000c      	addw	x,_AnaResults
2875  0bd7 1c0048        	addw	x,#72
2876  0bda cd0000        	call	c_ltor
2878  0bdd cd0000        	call	c_ltof
2880  0be0 ae0030        	ldw	x,#L517
2881  0be3 cd0000        	call	c_fmul
2883  0be6 ae0008        	ldw	x,#L71
2884  0be9 cd0000        	call	c_fdiv
2886  0bec be02          	ldw	x,c_lreg+2
2887  0bee 89            	pushw	x
2888  0bef be00          	ldw	x,c_lreg
2889  0bf1 89            	pushw	x
2890  0bf2 ae0034        	ldw	x,#L707
2891  0bf5 89            	pushw	x
2892  0bf6 ce0000        	ldw	x,_DEBUG_STRING
2893  0bf9 cd0000        	call	_sprintf
2895  0bfc 5b32          	addw	sp,#50
2896                     ; 348   for (x=0;x<numsample/2;x++)
2898  0bfe 1e01          	ldw	x,(OFST-1,sp)
2899  0c00 5c            	incw	x
2900  0c01 1f01          	ldw	(OFST-1,sp),x
2903  0c03 a30010        	cpw	x,#16
2904  0c06 2403cc0a44    	jrult	L107
2905                     ; 359 } /*PrintFFTAll*/
2908  0c0b 85            	popw	x
2909  0c0c 81            	ret	
3107                     ; 363 unsigned int getHarmonicPower(pointarraysamples smpl, unsigned int periods,unsigned int channels,
3107                     ; 364         double *U,double *I,
3107                     ; 365         double *DistortionU,double *DistortionI,
3107                     ; 366         double *power,double *PhaseBasicHarm)
3107                     ; 367 {
3108                     	switch	.text
3109  0c0d               _getHarmonicPower:
3111  0c0d 89            	pushw	x
3112  0c0e 523a          	subw	sp,#58
3113       0000003a      OFST:	set	58
3116                     ; 373   unsigned int polovica = numsample>>1;
3118  0c10 ae0010        	ldw	x,#16
3119  0c13 1f0d          	ldw	(OFST-45,sp),x
3120                     ; 375   double posuvfazy = 2*M_PI/(numsample*channels);// phase correction between U and I due to different sampling time
3122  0c15 1e41          	ldw	x,(OFST+7,sp)
3123  0c17 58            	sllw	x
3124  0c18 58            	sllw	x
3125  0c19 58            	sllw	x
3126  0c1a 58            	sllw	x
3127  0c1b 58            	sllw	x
3128  0c1c cd0000        	call	c_uitof
3130  0c1f 96            	ldw	x,sp
3131  0c20 1c0009        	addw	x,#OFST-49
3132  0c23 cd0000        	call	c_rtol
3134  0c26 ae002c        	ldw	x,#L3301
3135  0c29 cd0000        	call	c_ltor
3137  0c2c 96            	ldw	x,sp
3138  0c2d 1c0009        	addw	x,#OFST-49
3139  0c30 cd0000        	call	c_fdiv
3141  0c33 96            	ldw	x,sp
3142  0c34 1c0017        	addw	x,#OFST-35
3143  0c37 cd0000        	call	c_rtol
3145                     ; 379   integerDistortionU=0;
3147  0c3a 5f            	clrw	x
3148  0c3b 1f1d          	ldw	(OFST-29,sp),x
3149  0c3d 1f1b          	ldw	(OFST-31,sp),x
3150                     ; 380   integerDistortionI=0;
3152  0c3f 1f21          	ldw	(OFST-25,sp),x
3153  0c41 1f1f          	ldw	(OFST-27,sp),x
3154                     ; 381   * power=0.0;
3156  0c43 1e4b          	ldw	x,(OFST+17,sp)
3157  0c45 c6002b        	ld	a,L3401+3
3158  0c48 e703          	ld	(3,x),a
3159  0c4a c6002a        	ld	a,L3401+2
3160  0c4d e702          	ld	(2,x),a
3161  0c4f c60029        	ld	a,L3401+1
3162  0c52 e701          	ld	(1,x),a
3163  0c54 c60028        	ld	a,L3401
3164  0c57 f7            	ld	(x),a
3165                     ; 382           (*smpl)[0].r = 2 * (*smpl)[0].r;
3167  0c58 1e3b          	ldw	x,(OFST+1,sp)
3168  0c5a 6803          	sll	(3,x)
3169  0c5c 6902          	rlc	(2,x)
3170  0c5e 6901          	rlc	(1,x)
3171  0c60 79            	rlc	(x)
3172                     ; 383           (*smpl)[polovica].r = 2 * (*smpl)[0].i;
3174  0c61 1c0004        	addw	x,#4
3175  0c64 cd0000        	call	c_ltor
3177  0c67 3803          	sll	c_lreg+3
3178  0c69 3902          	rlc	c_lreg+2
3179  0c6b 3901          	rlc	c_lreg+1
3180  0c6d 3900          	rlc	c_lreg
3181  0c6f 1e3b          	ldw	x,(OFST+1,sp)
3182  0c71 1c0080        	addw	x,#128
3183  0c74 cd0000        	call	c_rtol
3185                     ; 384           (*smpl)[0].i = 0;
3187  0c77 1e3b          	ldw	x,(OFST+1,sp)
3188  0c79 4f            	clr	a
3189  0c7a e707          	ld	(7,x),a
3190  0c7c e706          	ld	(6,x),a
3191  0c7e e705          	ld	(5,x),a
3192  0c80 e704          	ld	(4,x),a
3193                     ; 385           (*smpl)[polovica].i = 0;
3195  0c82 e787          	ld	(135,x),a
3196  0c84 e786          	ld	(134,x),a
3197  0c86 e785          	ld	(133,x),a
3198  0c88 e784          	ld	(132,x),a
3199                     ; 386   numsampleindex = numsample;
3201  0c8a ae0020        	ldw	x,#32
3202  0c8d 1f27          	ldw	(OFST-19,sp),x
3203                     ; 387   for (i=1;i<polovica;i++)
3205  0c8f ae0001        	ldw	x,#1
3207  0c92 cc1063        	jra	L3501
3208  0c95               L7401:
3209                     ; 389      numsampleindex--;
3211  0c95 1e27          	ldw	x,(OFST-19,sp)
3212  0c97 5a            	decw	x
3213  0c98 1f27          	ldw	(OFST-19,sp),x
3214                     ; 390      Ismpl.r = ((*smpl)[i].i) + ((*smpl)[numsampleindex].i);
3216  0c9a 58            	sllw	x
3217  0c9b 58            	sllw	x
3218  0c9c 58            	sllw	x
3219  0c9d 72fb3b        	addw	x,(OFST+1,sp)
3220  0ca0 1c0004        	addw	x,#4
3221  0ca3 cd0000        	call	c_ltor
3223  0ca6 1e29          	ldw	x,(OFST-17,sp)
3224  0ca8 58            	sllw	x
3225  0ca9 58            	sllw	x
3226  0caa 58            	sllw	x
3227  0cab 72fb3b        	addw	x,(OFST+1,sp)
3228  0cae 1c0004        	addw	x,#4
3229  0cb1 cd0000        	call	c_ladd
3231  0cb4 96            	ldw	x,sp
3232  0cb5 1c0033        	addw	x,#OFST-7
3233  0cb8 cd0000        	call	c_rtol
3235                     ; 391      Ismpl.i = ((*smpl)[numsampleindex].r) - ((*smpl)[i].r);
3237  0cbb 1e27          	ldw	x,(OFST-19,sp)
3238  0cbd 58            	sllw	x
3239  0cbe 58            	sllw	x
3240  0cbf 58            	sllw	x
3241  0cc0 72fb3b        	addw	x,(OFST+1,sp)
3242  0cc3 cd0000        	call	c_ltor
3244  0cc6 1e29          	ldw	x,(OFST-17,sp)
3245  0cc8 58            	sllw	x
3246  0cc9 58            	sllw	x
3247  0cca 58            	sllw	x
3248  0ccb 72fb3b        	addw	x,(OFST+1,sp)
3249  0cce cd0000        	call	c_lsub
3251  0cd1 96            	ldw	x,sp
3252  0cd2 1c0037        	addw	x,#OFST-3
3253  0cd5 cd0000        	call	c_rtol
3255                     ; 393      Usmpl.r = ((*smpl)[i].r) + ((*smpl)[numsampleindex].r);
3257  0cd8 1e27          	ldw	x,(OFST-19,sp)
3258  0cda 58            	sllw	x
3259  0cdb 58            	sllw	x
3260  0cdc 58            	sllw	x
3261  0cdd 72fb3b        	addw	x,(OFST+1,sp)
3262  0ce0 cd0000        	call	c_ltor
3264  0ce3 1e29          	ldw	x,(OFST-17,sp)
3265  0ce5 58            	sllw	x
3266  0ce6 58            	sllw	x
3267  0ce7 58            	sllw	x
3268  0ce8 72fb3b        	addw	x,(OFST+1,sp)
3269  0ceb cd0000        	call	c_ladd
3271  0cee 96            	ldw	x,sp
3272  0cef 1c002b        	addw	x,#OFST-15
3273  0cf2 cd0000        	call	c_rtol
3275                     ; 394      Usmpl.i = ((*smpl)[i].i) - ((*smpl)[numsampleindex].i);
3277  0cf5 1e29          	ldw	x,(OFST-17,sp)
3278  0cf7 58            	sllw	x
3279  0cf8 58            	sllw	x
3280  0cf9 58            	sllw	x
3281  0cfa 72fb3b        	addw	x,(OFST+1,sp)
3282  0cfd 1c0004        	addw	x,#4
3283  0d00 cd0000        	call	c_ltor
3285  0d03 1e27          	ldw	x,(OFST-19,sp)
3286  0d05 58            	sllw	x
3287  0d06 58            	sllw	x
3288  0d07 58            	sllw	x
3289  0d08 72fb3b        	addw	x,(OFST+1,sp)
3290  0d0b 1c0004        	addw	x,#4
3291  0d0e cd0000        	call	c_lsub
3293  0d11 96            	ldw	x,sp
3294  0d12 1c002f        	addw	x,#OFST-11
3295  0d15 cd0000        	call	c_rtol
3297                     ; 396      (*smpl)[i].r = Usmpl.r;
3299  0d18 1e29          	ldw	x,(OFST-17,sp)
3300  0d1a 58            	sllw	x
3301  0d1b 58            	sllw	x
3302  0d1c 58            	sllw	x
3303  0d1d 72fb3b        	addw	x,(OFST+1,sp)
3304  0d20 7b2e          	ld	a,(OFST-12,sp)
3305  0d22 e703          	ld	(3,x),a
3306  0d24 7b2d          	ld	a,(OFST-13,sp)
3307  0d26 e702          	ld	(2,x),a
3308  0d28 7b2c          	ld	a,(OFST-14,sp)
3309  0d2a e701          	ld	(1,x),a
3310  0d2c 7b2b          	ld	a,(OFST-15,sp)
3311  0d2e f7            	ld	(x),a
3312                     ; 397      (*smpl)[i].i = Usmpl.i;
3314  0d2f 7b32          	ld	a,(OFST-8,sp)
3315  0d31 e707          	ld	(7,x),a
3316  0d33 7b31          	ld	a,(OFST-9,sp)
3317  0d35 e706          	ld	(6,x),a
3318  0d37 7b30          	ld	a,(OFST-10,sp)
3319  0d39 e705          	ld	(5,x),a
3320  0d3b 7b2f          	ld	a,(OFST-11,sp)
3321  0d3d e704          	ld	(4,x),a
3322                     ; 399      (*smpl)[numsampleindex].r = Ismpl.r;
3324  0d3f 1e27          	ldw	x,(OFST-19,sp)
3325  0d41 58            	sllw	x
3326  0d42 58            	sllw	x
3327  0d43 58            	sllw	x
3328  0d44 72fb3b        	addw	x,(OFST+1,sp)
3329  0d47 7b36          	ld	a,(OFST-4,sp)
3330  0d49 e703          	ld	(3,x),a
3331  0d4b 7b35          	ld	a,(OFST-5,sp)
3332  0d4d e702          	ld	(2,x),a
3333  0d4f 7b34          	ld	a,(OFST-6,sp)
3334  0d51 e701          	ld	(1,x),a
3335  0d53 7b33          	ld	a,(OFST-7,sp)
3336  0d55 f7            	ld	(x),a
3337                     ; 400      (*smpl)[numsampleindex].i = Ismpl.i;
3339  0d56 7b3a          	ld	a,(OFST+0,sp)
3340  0d58 e707          	ld	(7,x),a
3341  0d5a 7b39          	ld	a,(OFST-1,sp)
3342  0d5c e706          	ld	(6,x),a
3343  0d5e 7b38          	ld	a,(OFST-2,sp)
3344  0d60 e705          	ld	(5,x),a
3345  0d62 7b37          	ld	a,(OFST-3,sp)
3346  0d64 e704          	ld	(4,x),a
3347                     ; 403      if (i==periods)
3349  0d66 1e29          	ldw	x,(OFST-17,sp)
3350  0d68 133f          	cpw	x,(OFST+5,sp)
3351  0d6a 96            	ldw	x,sp
3352  0d6b 2703cc0ed6    	jrne	L7501
3353                     ; 405        if ((Ismpl.i+Ismpl.r) & (Usmpl.i+Usmpl.r))
3355  0d70 1c002f        	addw	x,#OFST-11
3356  0d73 cd0000        	call	c_ltor
3358  0d76 96            	ldw	x,sp
3359  0d77 1c002b        	addw	x,#OFST-15
3360  0d7a cd0000        	call	c_ladd
3362  0d7d 96            	ldw	x,sp
3363  0d7e 1c0009        	addw	x,#OFST-49
3364  0d81 cd0000        	call	c_rtol
3366  0d84 96            	ldw	x,sp
3367  0d85 1c0037        	addw	x,#OFST-3
3368  0d88 cd0000        	call	c_ltor
3370  0d8b 96            	ldw	x,sp
3371  0d8c 1c0033        	addw	x,#OFST-7
3372  0d8f cd0000        	call	c_ladd
3374  0d92 96            	ldw	x,sp
3375  0d93 1c0009        	addw	x,#OFST-49
3376  0d96 cd0000        	call	c_land
3378  0d99 cd0000        	call	c_lrzmp
3380  0d9c 2603cc0e36    	jreq	L1601
3381                     ; 406          * PhaseBasicHarm = Phase = atan2(Ismpl.i,Ismpl.r) - atan2(Usmpl.i,Usmpl.r) - posuvfazy*i;
3383  0da1 1e29          	ldw	x,(OFST-17,sp)
3384  0da3 cd0000        	call	c_uitof
3386  0da6 96            	ldw	x,sp
3387  0da7 1c0009        	addw	x,#OFST-49
3388  0daa cd0000        	call	c_rtol
3390  0dad 96            	ldw	x,sp
3391  0dae 1c0017        	addw	x,#OFST-35
3392  0db1 cd0000        	call	c_ltor
3394  0db4 96            	ldw	x,sp
3395  0db5 1c0009        	addw	x,#OFST-49
3396  0db8 cd0000        	call	c_fmul
3398  0dbb 96            	ldw	x,sp
3399  0dbc 1c0005        	addw	x,#OFST-53
3400  0dbf cd0000        	call	c_rtol
3402  0dc2 96            	ldw	x,sp
3403  0dc3 1c002b        	addw	x,#OFST-15
3404  0dc6 cd0000        	call	c_ltor
3406  0dc9 cd0000        	call	c_ltof
3408  0dcc be02          	ldw	x,c_lreg+2
3409  0dce 89            	pushw	x
3410  0dcf be00          	ldw	x,c_lreg
3411  0dd1 89            	pushw	x
3412  0dd2 96            	ldw	x,sp
3413  0dd3 1c0033        	addw	x,#OFST-7
3414  0dd6 cd0000        	call	c_ltor
3416  0dd9 cd0000        	call	c_ltof
3418  0ddc be02          	ldw	x,c_lreg+2
3419  0dde 89            	pushw	x
3420  0ddf be00          	ldw	x,c_lreg
3421  0de1 89            	pushw	x
3422  0de2 cd0000        	call	_atan2
3424  0de5 5b08          	addw	sp,#8
3425  0de7 96            	ldw	x,sp
3426  0de8 5c            	incw	x
3427  0de9 cd0000        	call	c_rtol
3429  0dec 96            	ldw	x,sp
3430  0ded 1c0033        	addw	x,#OFST-7
3431  0df0 cd0000        	call	c_ltor
3433  0df3 cd0000        	call	c_ltof
3435  0df6 be02          	ldw	x,c_lreg+2
3436  0df8 89            	pushw	x
3437  0df9 be00          	ldw	x,c_lreg
3438  0dfb 89            	pushw	x
3439  0dfc 96            	ldw	x,sp
3440  0dfd 1c003b        	addw	x,#OFST+1
3441  0e00 cd0000        	call	c_ltor
3443  0e03 cd0000        	call	c_ltof
3445  0e06 be02          	ldw	x,c_lreg+2
3446  0e08 89            	pushw	x
3447  0e09 be00          	ldw	x,c_lreg
3448  0e0b 89            	pushw	x
3449  0e0c cd0000        	call	_atan2
3451  0e0f 5b08          	addw	sp,#8
3452  0e11 96            	ldw	x,sp
3453  0e12 5c            	incw	x
3454  0e13 cd0000        	call	c_fsub
3456  0e16 96            	ldw	x,sp
3457  0e17 1c0005        	addw	x,#OFST-53
3458  0e1a cd0000        	call	c_fsub
3460  0e1d 96            	ldw	x,sp
3461  0e1e 1c0023        	addw	x,#OFST-23
3462  0e21 cd0000        	call	c_rtol
3464  0e24 1e4d          	ldw	x,(OFST+19,sp)
3465  0e26 7b26          	ld	a,(OFST-20,sp)
3466  0e28 e703          	ld	(3,x),a
3467  0e2a 7b25          	ld	a,(OFST-21,sp)
3468  0e2c e702          	ld	(2,x),a
3469  0e2e 7b24          	ld	a,(OFST-22,sp)
3470  0e30 e701          	ld	(1,x),a
3471  0e32 7b23          	ld	a,(OFST-23,sp)
3473  0e34 200e          	jra	L3601
3474  0e36               L1601:
3475                     ; 408          * PhaseBasicHarm = Phase = 0;
3477  0e36 5f            	clrw	x
3478  0e37 1f25          	ldw	(OFST-21,sp),x
3479  0e39 1f23          	ldw	(OFST-23,sp),x
3480  0e3b 1e4d          	ldw	x,(OFST+19,sp)
3481  0e3d 4f            	clr	a
3482  0e3e e703          	ld	(3,x),a
3483  0e40 e702          	ld	(2,x),a
3484  0e42 e701          	ld	(1,x),a
3485  0e44               L3601:
3486  0e44 f7            	ld	(x),a
3487                     ; 409        integerDistortionU += Usmpl.r=Usmpl.r * Usmpl.r + Usmpl.i * Usmpl.i;
3489  0e45 96            	ldw	x,sp
3490  0e46 1c002f        	addw	x,#OFST-11
3491  0e49 cd0000        	call	c_ltor
3493  0e4c 96            	ldw	x,sp
3494  0e4d 1c002f        	addw	x,#OFST-11
3495  0e50 cd0000        	call	c_lmul
3497  0e53 96            	ldw	x,sp
3498  0e54 1c0009        	addw	x,#OFST-49
3499  0e57 cd0000        	call	c_rtol
3501  0e5a 96            	ldw	x,sp
3502  0e5b 1c002b        	addw	x,#OFST-15
3503  0e5e cd0000        	call	c_ltor
3505  0e61 96            	ldw	x,sp
3506  0e62 1c002b        	addw	x,#OFST-15
3507  0e65 cd0000        	call	c_lmul
3509  0e68 96            	ldw	x,sp
3510  0e69 1c0009        	addw	x,#OFST-49
3511  0e6c cd0000        	call	c_ladd
3513  0e6f 96            	ldw	x,sp
3514  0e70 1c002b        	addw	x,#OFST-15
3515  0e73 cd0000        	call	c_rtol
3517  0e76 96            	ldw	x,sp
3518  0e77 1c002b        	addw	x,#OFST-15
3519  0e7a cd0000        	call	c_ltor
3521  0e7d 96            	ldw	x,sp
3522  0e7e 1c001b        	addw	x,#OFST-31
3523  0e81 cd0000        	call	c_lgadd
3525                     ; 410        integerDistortionI += Ismpl.r=Ismpl.r * Ismpl.r + Ismpl.i * Ismpl.i;
3527  0e84 96            	ldw	x,sp
3528  0e85 1c0037        	addw	x,#OFST-3
3529  0e88 cd0000        	call	c_ltor
3531  0e8b 96            	ldw	x,sp
3532  0e8c 1c0037        	addw	x,#OFST-3
3533  0e8f cd0000        	call	c_lmul
3535  0e92 96            	ldw	x,sp
3536  0e93 1c0009        	addw	x,#OFST-49
3537  0e96 cd0000        	call	c_rtol
3539  0e99 96            	ldw	x,sp
3540  0e9a 1c0033        	addw	x,#OFST-7
3541  0e9d cd0000        	call	c_ltor
3543  0ea0 96            	ldw	x,sp
3544  0ea1 1c0033        	addw	x,#OFST-7
3545  0ea4 cd0000        	call	c_lmul
3547  0ea7 96            	ldw	x,sp
3548  0ea8 1c0009        	addw	x,#OFST-49
3549  0eab cd0000        	call	c_ladd
3551  0eae 96            	ldw	x,sp
3552  0eaf 1c0033        	addw	x,#OFST-7
3553  0eb2 cd0000        	call	c_rtol
3555  0eb5 96            	ldw	x,sp
3556  0eb6 1c0033        	addw	x,#OFST-7
3557  0eb9 cd0000        	call	c_ltor
3559  0ebc 96            	ldw	x,sp
3560  0ebd 1c001f        	addw	x,#OFST-27
3561  0ec0 cd0000        	call	c_lgadd
3563                     ; 411        BasicHarmU = Usmpl.r;
3565  0ec3 1e2d          	ldw	x,(OFST-13,sp)
3566  0ec5 1f11          	ldw	(OFST-41,sp),x
3567  0ec7 1e2b          	ldw	x,(OFST-15,sp)
3568  0ec9 1f0f          	ldw	(OFST-43,sp),x
3569                     ; 412        BasicHarmI = Ismpl.r;
3571  0ecb 1e35          	ldw	x,(OFST-5,sp)
3572  0ecd 1f15          	ldw	(OFST-37,sp),x
3573  0ecf 1e33          	ldw	x,(OFST-7,sp)
3574  0ed1 1f13          	ldw	(OFST-39,sp),x
3576  0ed3 cc100f        	jra	L5601
3577  0ed6               L7501:
3578                     ; 416        if ((Ismpl.i+Ismpl.r) & (Usmpl.i+Usmpl.r))
3580  0ed6 1c002f        	addw	x,#OFST-11
3581  0ed9 cd0000        	call	c_ltor
3583  0edc 96            	ldw	x,sp
3584  0edd 1c002b        	addw	x,#OFST-15
3585  0ee0 cd0000        	call	c_ladd
3587  0ee3 96            	ldw	x,sp
3588  0ee4 1c0009        	addw	x,#OFST-49
3589  0ee7 cd0000        	call	c_rtol
3591  0eea 96            	ldw	x,sp
3592  0eeb 1c0037        	addw	x,#OFST-3
3593  0eee cd0000        	call	c_ltor
3595  0ef1 96            	ldw	x,sp
3596  0ef2 1c0033        	addw	x,#OFST-7
3597  0ef5 cd0000        	call	c_ladd
3599  0ef8 96            	ldw	x,sp
3600  0ef9 1c0009        	addw	x,#OFST-49
3601  0efc cd0000        	call	c_land
3603  0eff cd0000        	call	c_lrzmp
3605  0f02 2603cc0f8c    	jreq	L7601
3606                     ; 417          Phase = atan2(Ismpl.i,Ismpl.r) - atan2(Usmpl.i,Usmpl.r) - posuvfazy*i;
3608  0f07 1e29          	ldw	x,(OFST-17,sp)
3609  0f09 cd0000        	call	c_uitof
3611  0f0c 96            	ldw	x,sp
3612  0f0d 1c0009        	addw	x,#OFST-49
3613  0f10 cd0000        	call	c_rtol
3615  0f13 96            	ldw	x,sp
3616  0f14 1c0017        	addw	x,#OFST-35
3617  0f17 cd0000        	call	c_ltor
3619  0f1a 96            	ldw	x,sp
3620  0f1b 1c0009        	addw	x,#OFST-49
3621  0f1e cd0000        	call	c_fmul
3623  0f21 96            	ldw	x,sp
3624  0f22 1c0005        	addw	x,#OFST-53
3625  0f25 cd0000        	call	c_rtol
3627  0f28 96            	ldw	x,sp
3628  0f29 1c002b        	addw	x,#OFST-15
3629  0f2c cd0000        	call	c_ltor
3631  0f2f cd0000        	call	c_ltof
3633  0f32 be02          	ldw	x,c_lreg+2
3634  0f34 89            	pushw	x
3635  0f35 be00          	ldw	x,c_lreg
3636  0f37 89            	pushw	x
3637  0f38 96            	ldw	x,sp
3638  0f39 1c0033        	addw	x,#OFST-7
3639  0f3c cd0000        	call	c_ltor
3641  0f3f cd0000        	call	c_ltof
3643  0f42 be02          	ldw	x,c_lreg+2
3644  0f44 89            	pushw	x
3645  0f45 be00          	ldw	x,c_lreg
3646  0f47 89            	pushw	x
3647  0f48 cd0000        	call	_atan2
3649  0f4b 5b08          	addw	sp,#8
3650  0f4d 96            	ldw	x,sp
3651  0f4e 5c            	incw	x
3652  0f4f cd0000        	call	c_rtol
3654  0f52 96            	ldw	x,sp
3655  0f53 1c0033        	addw	x,#OFST-7
3656  0f56 cd0000        	call	c_ltor
3658  0f59 cd0000        	call	c_ltof
3660  0f5c be02          	ldw	x,c_lreg+2
3661  0f5e 89            	pushw	x
3662  0f5f be00          	ldw	x,c_lreg
3663  0f61 89            	pushw	x
3664  0f62 96            	ldw	x,sp
3665  0f63 1c003b        	addw	x,#OFST+1
3666  0f66 cd0000        	call	c_ltor
3668  0f69 cd0000        	call	c_ltof
3670  0f6c be02          	ldw	x,c_lreg+2
3671  0f6e 89            	pushw	x
3672  0f6f be00          	ldw	x,c_lreg
3673  0f71 89            	pushw	x
3674  0f72 cd0000        	call	_atan2
3676  0f75 5b08          	addw	sp,#8
3677  0f77 96            	ldw	x,sp
3678  0f78 5c            	incw	x
3679  0f79 cd0000        	call	c_fsub
3681  0f7c 96            	ldw	x,sp
3682  0f7d 1c0005        	addw	x,#OFST-53
3683  0f80 cd0000        	call	c_fsub
3685  0f83 96            	ldw	x,sp
3686  0f84 1c0023        	addw	x,#OFST-23
3687  0f87 cd0000        	call	c_rtol
3690  0f8a 2005          	jra	L1701
3691  0f8c               L7601:
3692                     ; 419          Phase = 0;
3694  0f8c 5f            	clrw	x
3695  0f8d 1f25          	ldw	(OFST-21,sp),x
3696  0f8f 1f23          	ldw	(OFST-23,sp),x
3697  0f91               L1701:
3698                     ; 420        integerDistortionU += Usmpl.r=Usmpl.r * Usmpl.r + Usmpl.i * Usmpl.i;
3700  0f91 96            	ldw	x,sp
3701  0f92 1c002f        	addw	x,#OFST-11
3702  0f95 cd0000        	call	c_ltor
3704  0f98 96            	ldw	x,sp
3705  0f99 1c002f        	addw	x,#OFST-11
3706  0f9c cd0000        	call	c_lmul
3708  0f9f 96            	ldw	x,sp
3709  0fa0 1c0009        	addw	x,#OFST-49
3710  0fa3 cd0000        	call	c_rtol
3712  0fa6 96            	ldw	x,sp
3713  0fa7 1c002b        	addw	x,#OFST-15
3714  0faa cd0000        	call	c_ltor
3716  0fad 96            	ldw	x,sp
3717  0fae 1c002b        	addw	x,#OFST-15
3718  0fb1 cd0000        	call	c_lmul
3720  0fb4 96            	ldw	x,sp
3721  0fb5 1c0009        	addw	x,#OFST-49
3722  0fb8 cd0000        	call	c_ladd
3724  0fbb 96            	ldw	x,sp
3725  0fbc 1c002b        	addw	x,#OFST-15
3726  0fbf cd0000        	call	c_rtol
3728  0fc2 96            	ldw	x,sp
3729  0fc3 1c002b        	addw	x,#OFST-15
3730  0fc6 cd0000        	call	c_ltor
3732  0fc9 96            	ldw	x,sp
3733  0fca 1c001b        	addw	x,#OFST-31
3734  0fcd cd0000        	call	c_lgadd
3736                     ; 421        integerDistortionI += Ismpl.r=Ismpl.r * Ismpl.r + Ismpl.i * Ismpl.i;
3738  0fd0 96            	ldw	x,sp
3739  0fd1 1c0037        	addw	x,#OFST-3
3740  0fd4 cd0000        	call	c_ltor
3742  0fd7 96            	ldw	x,sp
3743  0fd8 1c0037        	addw	x,#OFST-3
3744  0fdb cd0000        	call	c_lmul
3746  0fde 96            	ldw	x,sp
3747  0fdf 1c0009        	addw	x,#OFST-49
3748  0fe2 cd0000        	call	c_rtol
3750  0fe5 96            	ldw	x,sp
3751  0fe6 1c0033        	addw	x,#OFST-7
3752  0fe9 cd0000        	call	c_ltor
3754  0fec 96            	ldw	x,sp
3755  0fed 1c0033        	addw	x,#OFST-7
3756  0ff0 cd0000        	call	c_lmul
3758  0ff3 96            	ldw	x,sp
3759  0ff4 1c0009        	addw	x,#OFST-49
3760  0ff7 cd0000        	call	c_ladd
3762  0ffa 96            	ldw	x,sp
3763  0ffb 1c0033        	addw	x,#OFST-7
3764  0ffe cd0000        	call	c_rtol
3766  1001 96            	ldw	x,sp
3767  1002 1c0033        	addw	x,#OFST-7
3768  1005 cd0000        	call	c_ltor
3770  1008 96            	ldw	x,sp
3771  1009 1c001f        	addw	x,#OFST-27
3772  100c cd0000        	call	c_lgadd
3774  100f               L5601:
3775                     ; 423      * power += cos(Phase) * 0.5 * sqrt((double)(unsigned long)Usmpl.r * (double)(unsigned long)Ismpl.r);
3777  100f 96            	ldw	x,sp
3778  1010 1c0033        	addw	x,#OFST-7
3779  1013 cd0000        	call	c_ltor
3781  1016 cd0000        	call	c_ultof
3783  1019 96            	ldw	x,sp
3784  101a 1c0009        	addw	x,#OFST-49
3785  101d cd0000        	call	c_rtol
3787  1020 96            	ldw	x,sp
3788  1021 1c002b        	addw	x,#OFST-15
3789  1024 cd0000        	call	c_ltor
3791  1027 cd0000        	call	c_ultof
3793  102a 96            	ldw	x,sp
3794  102b 1c0009        	addw	x,#OFST-49
3795  102e cd0000        	call	c_fmul
3797  1031 be02          	ldw	x,c_lreg+2
3798  1033 89            	pushw	x
3799  1034 be00          	ldw	x,c_lreg
3800  1036 89            	pushw	x
3801  1037 cd0000        	call	_sqrt
3803  103a 5b04          	addw	sp,#4
3804  103c 96            	ldw	x,sp
3805  103d 1c0005        	addw	x,#OFST-53
3806  1040 cd0000        	call	c_rtol
3808  1043 1e25          	ldw	x,(OFST-21,sp)
3809  1045 89            	pushw	x
3810  1046 1e25          	ldw	x,(OFST-21,sp)
3811  1048 89            	pushw	x
3812  1049 cd0000        	call	_cos
3814  104c 5b04          	addw	sp,#4
3815  104e ae0024        	ldw	x,#L7701
3816  1051 cd0000        	call	c_fmul
3818  1054 96            	ldw	x,sp
3819  1055 1c0005        	addw	x,#OFST-53
3820  1058 cd0000        	call	c_fmul
3822  105b 1e4b          	ldw	x,(OFST+17,sp)
3823  105d cd0000        	call	c_fgadd
3825                     ; 387   for (i=1;i<polovica;i++)
3827  1060 1e29          	ldw	x,(OFST-17,sp)
3828  1062 5c            	incw	x
3829  1063               L3501:
3830  1063 1f29          	ldw	(OFST-17,sp),x
3833  1065 130d          	cpw	x,(OFST-45,sp)
3834  1067 2403cc0c95    	jrult	L7401
3835                     ; 425   * U = sqrt(0.5*integerDistortionU) ;
3837  106c 96            	ldw	x,sp
3838  106d 1c001b        	addw	x,#OFST-31
3839  1070 cd0000        	call	c_ltor
3841  1073 cd0000        	call	c_ultof
3843  1076 ae0024        	ldw	x,#L7701
3844  1079 cd0000        	call	c_fmul
3846  107c be02          	ldw	x,c_lreg+2
3847  107e 89            	pushw	x
3848  107f be00          	ldw	x,c_lreg
3849  1081 89            	pushw	x
3850  1082 cd0000        	call	_sqrt
3852  1085 5b04          	addw	sp,#4
3853  1087 1e43          	ldw	x,(OFST+9,sp)
3854  1089 cd0000        	call	c_rtol
3856                     ; 426   * I = sqrt(0.5*integerDistortionI) ;
3858  108c 96            	ldw	x,sp
3859  108d 1c001f        	addw	x,#OFST-27
3860  1090 cd0000        	call	c_ltor
3862  1093 cd0000        	call	c_ultof
3864  1096 ae0024        	ldw	x,#L7701
3865  1099 cd0000        	call	c_fmul
3867  109c be02          	ldw	x,c_lreg+2
3868  109e 89            	pushw	x
3869  109f be00          	ldw	x,c_lreg
3870  10a1 89            	pushw	x
3871  10a2 cd0000        	call	_sqrt
3873  10a5 5b04          	addw	sp,#4
3874  10a7 1e45          	ldw	x,(OFST+11,sp)
3875  10a9 cd0000        	call	c_rtol
3877                     ; 427   if (BasicHarmU)
3879  10ac 96            	ldw	x,sp
3880  10ad 1c000f        	addw	x,#OFST-43
3881  10b0 cd0000        	call	c_lzmp
3883  10b3 2741          	jreq	L3011
3884                     ; 428     * DistortionU = 100*sqrt((double)(integerDistortionU-BasicHarmU)/(double)BasicHarmU);
3886  10b5 96            	ldw	x,sp
3887  10b6 1c000f        	addw	x,#OFST-43
3888  10b9 cd0000        	call	c_ltor
3890  10bc cd0000        	call	c_ultof
3892  10bf 96            	ldw	x,sp
3893  10c0 1c0009        	addw	x,#OFST-49
3894  10c3 cd0000        	call	c_rtol
3896  10c6 96            	ldw	x,sp
3897  10c7 1c001b        	addw	x,#OFST-31
3898  10ca cd0000        	call	c_ltor
3900  10cd 96            	ldw	x,sp
3901  10ce 1c000f        	addw	x,#OFST-43
3902  10d1 cd0000        	call	c_lsub
3904  10d4 cd0000        	call	c_ultof
3906  10d7 96            	ldw	x,sp
3907  10d8 1c0009        	addw	x,#OFST-49
3908  10db cd0000        	call	c_fdiv
3910  10de be02          	ldw	x,c_lreg+2
3911  10e0 89            	pushw	x
3912  10e1 be00          	ldw	x,c_lreg
3913  10e3 89            	pushw	x
3914  10e4 cd0000        	call	_sqrt
3916  10e7 5b04          	addw	sp,#4
3917  10e9 ae0020        	ldw	x,#L1111
3918  10ec cd0000        	call	c_fmul
3920  10ef 1e47          	ldw	x,(OFST+13,sp)
3921  10f1 cd0000        	call	c_rtol
3924  10f4 200a          	jra	L5111
3925  10f6               L3011:
3926                     ; 429   else * DistortionU = 0;
3928  10f6 1e47          	ldw	x,(OFST+13,sp)
3929  10f8 4f            	clr	a
3930  10f9 e703          	ld	(3,x),a
3931  10fb e702          	ld	(2,x),a
3932  10fd e701          	ld	(1,x),a
3933  10ff f7            	ld	(x),a
3934  1100               L5111:
3935                     ; 430   if (BasicHarmI)
3937  1100 96            	ldw	x,sp
3938  1101 1c0013        	addw	x,#OFST-39
3939  1104 cd0000        	call	c_lzmp
3941  1107 2741          	jreq	L7111
3942                     ; 431     * DistortionI = 100*sqrt((double)(integerDistortionI-BasicHarmI)/(double)BasicHarmI);
3944  1109 96            	ldw	x,sp
3945  110a 1c0013        	addw	x,#OFST-39
3946  110d cd0000        	call	c_ltor
3948  1110 cd0000        	call	c_ultof
3950  1113 96            	ldw	x,sp
3951  1114 1c0009        	addw	x,#OFST-49
3952  1117 cd0000        	call	c_rtol
3954  111a 96            	ldw	x,sp
3955  111b 1c001f        	addw	x,#OFST-27
3956  111e cd0000        	call	c_ltor
3958  1121 96            	ldw	x,sp
3959  1122 1c0013        	addw	x,#OFST-39
3960  1125 cd0000        	call	c_lsub
3962  1128 cd0000        	call	c_ultof
3964  112b 96            	ldw	x,sp
3965  112c 1c0009        	addw	x,#OFST-49
3966  112f cd0000        	call	c_fdiv
3968  1132 be02          	ldw	x,c_lreg+2
3969  1134 89            	pushw	x
3970  1135 be00          	ldw	x,c_lreg
3971  1137 89            	pushw	x
3972  1138 cd0000        	call	_sqrt
3974  113b 5b04          	addw	sp,#4
3975  113d ae0020        	ldw	x,#L1111
3976  1140 cd0000        	call	c_fmul
3978  1143 1e49          	ldw	x,(OFST+15,sp)
3979  1145 cd0000        	call	c_rtol
3982  1148 200a          	jra	L1211
3983  114a               L7111:
3984                     ; 432   else * DistortionI = 0;
3986  114a 1e49          	ldw	x,(OFST+15,sp)
3987  114c 4f            	clr	a
3988  114d e703          	ld	(3,x),a
3989  114f e702          	ld	(2,x),a
3990  1151 e701          	ld	(1,x),a
3991  1153 f7            	ld	(x),a
3992  1154               L1211:
3993                     ; 434 return(((numsample-1)>>1)/periods); // returns number of calculated harmonics
3995  1154 ae000f        	ldw	x,#15
3996  1157 163f          	ldw	y,(OFST+5,sp)
3997  1159 65            	divw	x,y
4000  115a 5b3c          	addw	sp,#60
4001  115c 81            	ret	
4087                     ; 439 void FFTall(pointarraysamples smpl, unsigned int channels,unsigned int periods,double samplingError)
4087                     ; 440 {
4088                     	switch	.text
4089  115d               _FFTall:
4091  115d 89            	pushw	x
4092  115e 5208          	subw	sp,#8
4093       00000008      OFST:	set	8
4096                     ; 442   for (i=0;i < (channels>>1);i++)
4098  1160 5f            	clrw	x
4100  1161 cc1281        	jra	L3611
4101  1164               L7511:
4102                     ; 444     FillSamplesInv(BufferEvalBoardADC,smpl,i<<1,channels,samplingError);
4104  1164 1e13          	ldw	x,(OFST+11,sp)
4105  1166 89            	pushw	x
4106  1167 1e13          	ldw	x,(OFST+11,sp)
4107  1169 89            	pushw	x
4108  116a 7b12          	ld	a,(OFST+10,sp)
4109  116c 88            	push	a
4110  116d 7b0d          	ld	a,(OFST+5,sp)
4111  116f 48            	sll	a
4112  1170 88            	push	a
4113  1171 1e0f          	ldw	x,(OFST+7,sp)
4114  1173 89            	pushw	x
4115  1174 ce000a        	ldw	x,_BufferEvalBoardADC
4116  1177 cd0314        	call	_FillSamplesInv
4118  117a 5b08          	addw	sp,#8
4119                     ; 445     FFT(smpl);
4121  117c 1e09          	ldw	x,(OFST+1,sp)
4122  117e cd02e9        	call	_FFT
4124                     ; 446     getHarmonicPower(smpl,periods,channels,
4124                     ; 447      &(* AnaResults).BasicResults[i][0],
4124                     ; 448      &(* AnaResults).BasicResults[i][1],
4124                     ; 449      &(* AnaResults).BasicResults[i][2],
4124                     ; 450      &(* AnaResults).BasicResults[i][3],
4124                     ; 451      &(* AnaResults).BasicResults[i][4],
4124                     ; 452      &(* AnaResults).BasicResults[i][5]);
4126  1181 1e07          	ldw	x,(OFST-1,sp)
4127  1183 90ae0018      	ldw	y,#24
4128  1187 cd0000        	call	c_imul
4130  118a 72bb000c      	addw	x,_AnaResults
4131  118e 1c0014        	addw	x,#20
4132  1191 89            	pushw	x
4133  1192 1e09          	ldw	x,(OFST+1,sp)
4134  1194 90ae0018      	ldw	y,#24
4135  1198 cd0000        	call	c_imul
4137  119b 72bb000c      	addw	x,_AnaResults
4138  119f 1c0010        	addw	x,#16
4139  11a2 89            	pushw	x
4140  11a3 1e0b          	ldw	x,(OFST+3,sp)
4141  11a5 90ae0018      	ldw	y,#24
4142  11a9 cd0000        	call	c_imul
4144  11ac 72bb000c      	addw	x,_AnaResults
4145  11b0 1c000c        	addw	x,#12
4146  11b3 89            	pushw	x
4147  11b4 1e0d          	ldw	x,(OFST+5,sp)
4148  11b6 90ae0018      	ldw	y,#24
4149  11ba cd0000        	call	c_imul
4151  11bd 72bb000c      	addw	x,_AnaResults
4152  11c1 1c0008        	addw	x,#8
4153  11c4 89            	pushw	x
4154  11c5 1e0f          	ldw	x,(OFST+7,sp)
4155  11c7 90ae0018      	ldw	y,#24
4156  11cb cd0000        	call	c_imul
4158  11ce 72bb000c      	addw	x,_AnaResults
4159  11d2 1c0004        	addw	x,#4
4160  11d5 89            	pushw	x
4161  11d6 1e11          	ldw	x,(OFST+9,sp)
4162  11d8 90ae0018      	ldw	y,#24
4163  11dc cd0000        	call	c_imul
4165  11df 72bb000c      	addw	x,_AnaResults
4166  11e3 89            	pushw	x
4167  11e4 1e19          	ldw	x,(OFST+17,sp)
4168  11e6 89            	pushw	x
4169  11e7 1e1d          	ldw	x,(OFST+21,sp)
4170  11e9 89            	pushw	x
4171  11ea 1e19          	ldw	x,(OFST+17,sp)
4172  11ec cd0c0d        	call	_getHarmonicPower
4174  11ef 5b10          	addw	sp,#16
4175                     ; 453     memcpy((* AnaResults).Harmonics[i][0], &(*smpl), numsample/2*sizeof(complex));
4177  11f1 1e07          	ldw	x,(OFST-1,sp)
4178  11f3 4f            	clr	a
4179  11f4 02            	rlwa	x,a
4180  11f5 72bb000c      	addw	x,_AnaResults
4181  11f9 1c0048        	addw	x,#72
4182  11fc bf00          	ldw	c_x,x
4183  11fe 1609          	ldw	y,(OFST+1,sp)
4184  1200 90bf00        	ldw	c_y,y
4185  1203 ae0080        	ldw	x,#128
4186  1206               L412:
4187  1206 5a            	decw	x
4188  1207 92d600        	ld	a,([c_y.w],x)
4189  120a 92d700        	ld	([c_x.w],x),a
4190  120d 5d            	tnzw	x
4191  120e 26f6          	jrne	L412
4192                     ; 454     memcpy((* AnaResults).Harmonics[i][1], &((*smpl)[numsample>>1]), sizeof(complex));
4194  1210 1e07          	ldw	x,(OFST-1,sp)
4195  1212 4f            	clr	a
4196  1213 02            	rlwa	x,a
4197  1214 72bb000c      	addw	x,_AnaResults
4198  1218 1c00c8        	addw	x,#200
4199  121b bf00          	ldw	c_x,x
4200  121d 72a90080      	addw	y,#128
4201  1221 90bf00        	ldw	c_y,y
4202  1224 ae0008        	ldw	x,#8
4203  1227               L612:
4204  1227 5a            	decw	x
4205  1228 92d600        	ld	a,([c_y.w],x)
4206  122b 92d700        	ld	([c_x.w],x),a
4207  122e 5d            	tnzw	x
4208  122f 26f6          	jrne	L612
4209                     ; 455     for(j=(numsample>>1)+1,k=(numsample>>1)-1; j<numsample; j++,k--)
4211  1231 ae0011        	ldw	x,#17
4212  1234 1f05          	ldw	(OFST-3,sp),x
4213  1236 ae000f        	ldw	x,#15
4215  1239 203a          	jra	L3711
4216  123b               L7611:
4217                     ; 456       memcpy(&((* AnaResults).Harmonics[i][1][k]), &((*smpl)[j]), sizeof(complex));
4219  123b 1e03          	ldw	x,(OFST-5,sp)
4220  123d 58            	sllw	x
4221  123e 58            	sllw	x
4222  123f 58            	sllw	x
4223  1240 1f01          	ldw	(OFST-7,sp),x
4224  1242 4f            	clr	a
4225  1243 1e07          	ldw	x,(OFST-1,sp)
4226  1245 02            	rlwa	x,a
4227  1246 72bb000c      	addw	x,_AnaResults
4228  124a 72fb01        	addw	x,(OFST-7,sp)
4229  124d 1c00c8        	addw	x,#200
4230  1250 bf00          	ldw	c_x,x
4231  1252 1605          	ldw	y,(OFST-3,sp)
4232  1254 9058          	sllw	y
4233  1256 9058          	sllw	y
4234  1258 9058          	sllw	y
4235  125a 72f909        	addw	y,(OFST+1,sp)
4236  125d 90bf00        	ldw	c_y,y
4237  1260 ae0008        	ldw	x,#8
4238  1263               L022:
4239  1263 5a            	decw	x
4240  1264 92d600        	ld	a,([c_y.w],x)
4241  1267 92d700        	ld	([c_x.w],x),a
4242  126a 5d            	tnzw	x
4243  126b 26f6          	jrne	L022
4244                     ; 455     for(j=(numsample>>1)+1,k=(numsample>>1)-1; j<numsample; j++,k--)
4246  126d 1e05          	ldw	x,(OFST-3,sp)
4247  126f 5c            	incw	x
4248  1270 1f05          	ldw	(OFST-3,sp),x
4249  1272 1e03          	ldw	x,(OFST-5,sp)
4250  1274 5a            	decw	x
4251  1275               L3711:
4252  1275 1f03          	ldw	(OFST-5,sp),x
4255  1277 1e05          	ldw	x,(OFST-3,sp)
4256  1279 a30020        	cpw	x,#32
4257  127c 25bd          	jrult	L7611
4258                     ; 442   for (i=0;i < (channels>>1);i++)
4260  127e 1e07          	ldw	x,(OFST-1,sp)
4261  1280 5c            	incw	x
4262  1281               L3611:
4263  1281 1f07          	ldw	(OFST-1,sp),x
4266  1283 1e0d          	ldw	x,(OFST+5,sp)
4267  1285 54            	srlw	x
4268  1286 1307          	cpw	x,(OFST-1,sp)
4269  1288 2303cc1164    	jrugt	L7511
4270                     ; 458 }/*FFTall*/
4273  128d 5b0a          	addw	sp,#10
4274  128f 81            	ret	
4329                     ; 461 void InitEvalBoard(unsigned int numsamples, unsigned int channels, double signalfrequency, unsigned int periods)
4329                     ; 462 {
4330                     	switch	.text
4331  1290               _InitEvalBoard:
4333  1290 89            	pushw	x
4334       00000000      OFST:	set	0
4337                     ; 463   InitEvalBoardparam(&param, numsamples, channels, signalfrequency, periods);
4339  1291 1e0b          	ldw	x,(OFST+11,sp)
4340  1293 89            	pushw	x
4341  1294 1e0b          	ldw	x,(OFST+11,sp)
4342  1296 89            	pushw	x
4343  1297 1e0b          	ldw	x,(OFST+11,sp)
4344  1299 89            	pushw	x
4345  129a 1e0b          	ldw	x,(OFST+11,sp)
4346  129c 89            	pushw	x
4347  129d 1e09          	ldw	x,(OFST+9,sp)
4348  129f 89            	pushw	x
4349  12a0 ae0000        	ldw	x,#_param
4350  12a3 cd0000        	call	_InitEvalBoardparam
4352  12a6 5b0a          	addw	sp,#10
4353                     ; 464 }/*InitEvalBoard*/
4356  12a8 85            	popw	x
4357  12a9 81            	ret	
4410                     ; 468 void * GetFFTResults(unsigned int channels, unsigned int periods)
4410                     ; 469 {
4411                     	switch	.text
4412  12aa               _GetFFTResults:
4414  12aa 89            	pushw	x
4415  12ab 5204          	subw	sp,#4
4416       00000004      OFST:	set	4
4419                     ; 472   periods=InitEvalBoardcard(&param, channels,numsample,&smplerr); // 50Hz signal; 6channels ; returns number of calculated periods
4421  12ad 96            	ldw	x,sp
4422  12ae 5c            	incw	x
4423  12af 89            	pushw	x
4424  12b0 ae0020        	ldw	x,#32
4425  12b3 89            	pushw	x
4426  12b4 1e09          	ldw	x,(OFST+5,sp)
4427  12b6 89            	pushw	x
4428  12b7 ae0000        	ldw	x,#_param
4429  12ba cd0000        	call	_InitEvalBoardcard
4431  12bd 5b06          	addw	sp,#6
4432  12bf 1f09          	ldw	(OFST+5,sp),x
4433                     ; 476   GetDataFromEvalBoard(&param);
4435  12c1 ae0000        	ldw	x,#_param
4436  12c4 cd0000        	call	_GetDataFromEvalBoard
4438                     ; 478   FFTall(smpl,channels,periods,smplerr);  /* 6kanalov */
4440  12c7 1e03          	ldw	x,(OFST-1,sp)
4441  12c9 89            	pushw	x
4442  12ca 1e03          	ldw	x,(OFST-1,sp)
4443  12cc 89            	pushw	x
4444  12cd 1e0d          	ldw	x,(OFST+9,sp)
4445  12cf 89            	pushw	x
4446  12d0 1e0b          	ldw	x,(OFST+7,sp)
4447  12d2 89            	pushw	x
4448  12d3 ce0006        	ldw	x,_smpl
4449  12d6 cd115d        	call	_FFTall
4451  12d9 5b08          	addw	sp,#8
4452                     ; 479 return(AnaResults);
4454  12db ce000c        	ldw	x,_AnaResults
4457  12de 5b06          	addw	sp,#6
4458  12e0 81            	ret	
4499                     ; 484 double GetSignalfrequency(double frequencyIn)
4499                     ; 485 {
4500                     	switch	.text
4501  12e1               _GetSignalfrequency:
4503  12e1 5204          	subw	sp,#4
4504       00000004      OFST:	set	4
4507                     ; 490   frequencyOut = GetDataFromEvalBoardfrequency(&param,frequencyIn,param.FreqvChannel);
4509  12e3 c60008        	ld	a,_param+8
4510  12e6 5f            	clrw	x
4511  12e7 97            	ld	xl,a
4512  12e8 89            	pushw	x
4513  12e9 1e0b          	ldw	x,(OFST+7,sp)
4514  12eb 89            	pushw	x
4515  12ec 1e0b          	ldw	x,(OFST+7,sp)
4516  12ee 89            	pushw	x
4517  12ef ae0000        	ldw	x,#_param
4518  12f2 cd0000        	call	_GetDataFromEvalBoardfrequency
4520  12f5 5b06          	addw	sp,#6
4521  12f7 96            	ldw	x,sp
4522  12f8 5c            	incw	x
4523  12f9 cd0000        	call	c_rtol
4525                     ; 492 return(frequencyOut);
4527  12fc 96            	ldw	x,sp
4528  12fd 5c            	incw	x
4529  12fe cd0000        	call	c_ltor
4533  1301 5b04          	addw	sp,#4
4534  1303 81            	ret	
4591                     ; 496 void TestADCFFT(void)
4591                     ; 497 {
4592                     	switch	.text
4593  1304               _TestADCFFT:
4595  1304 5208          	subw	sp,#8
4596       00000008      OFST:	set	8
4599                     ; 499 unsigned int periods=1;
4601  1306 ae0001        	ldw	x,#1
4602  1309 1f01          	ldw	(OFST-7,sp),x
4603                     ; 500 unsigned int channels=6;
4605  130b ae0006        	ldw	x,#6
4606  130e 1f03          	ldw	(OFST-5,sp),x
4607                     ; 501 double signalfrequency=50.000;
4609  1310 ce001e        	ldw	x,L3031+2
4610  1313 1f07          	ldw	(OFST-1,sp),x
4611  1315 ce001c        	ldw	x,L3031
4612  1318 1f05          	ldw	(OFST-3,sp),x
4613                     ; 504   if ((DEBUG_STRING = malloc(255)) == NULL)
4615  131a ae00ff        	ldw	x,#255
4616  131d cd0000        	call	_malloc
4618  1320 cf0000        	ldw	_DEBUG_STRING,x
4619  1323 2601          	jrne	L7031
4620                     ; 505     _asm("trap\n");
4623  1325 83            	trap	
4625  1326               L7031:
4626                     ; 508   SetCPUClock(ENABLE_EXTERNAL_FRQ); //XTALL - must be present 16MHz
4628  1326 4f            	clr	a
4629  1327 cd0000        	call	_SetCPUClock
4631                     ; 512   InitEvalBoard(numsample,channels,signalfrequency,periods);
4633  132a 1e01          	ldw	x,(OFST-7,sp)
4634  132c 89            	pushw	x
4635  132d 1e09          	ldw	x,(OFST+1,sp)
4636  132f 89            	pushw	x
4637  1330 1e09          	ldw	x,(OFST+1,sp)
4638  1332 89            	pushw	x
4639  1333 1e09          	ldw	x,(OFST+1,sp)
4640  1335 89            	pushw	x
4641  1336 ae0020        	ldw	x,#32
4642  1339 cd1290        	call	_InitEvalBoard
4644  133c 5b08          	addw	sp,#8
4645                     ; 514   InitFFT();
4647  133e cd0869        	call	_InitFFT
4649                     ; 516   signalfrequency = GetSignalfrequency(signalfrequency); // sampling length longer that expected
4651  1341 1e07          	ldw	x,(OFST-1,sp)
4652  1343 89            	pushw	x
4653  1344 1e07          	ldw	x,(OFST-1,sp)
4654  1346 89            	pushw	x
4655  1347 ad98          	call	_GetSignalfrequency
4657  1349 5b04          	addw	sp,#4
4658  134b 96            	ldw	x,sp
4659  134c 1c0005        	addw	x,#OFST-3
4660  134f cd0000        	call	c_rtol
4662                     ; 521     InitEvalBoard(numsample,channels,signalfrequency,periods);
4664  1352 1e01          	ldw	x,(OFST-7,sp)
4665  1354 89            	pushw	x
4666  1355 1e09          	ldw	x,(OFST+1,sp)
4667  1357 89            	pushw	x
4668  1358 1e09          	ldw	x,(OFST+1,sp)
4669  135a 89            	pushw	x
4670  135b 1e09          	ldw	x,(OFST+1,sp)
4671  135d 89            	pushw	x
4672  135e ae0020        	ldw	x,#32
4673  1361 cd1290        	call	_InitEvalBoard
4675  1364 5b08          	addw	sp,#8
4676                     ; 523     GetFFTResults(channels, periods);
4678  1366 1e01          	ldw	x,(OFST-7,sp)
4679  1368 89            	pushw	x
4680  1369 1e05          	ldw	x,(OFST-3,sp)
4681  136b cd12aa        	call	_GetFFTResults
4683  136e 85            	popw	x
4684                     ; 527   PrintFFTAll();
4686  136f cd095e        	call	_PrintFFTAll
4688                     ; 529   CloseFFT();
4690  1372 cd0940        	call	_CloseFFT
4692                     ; 531   free(DEBUG_STRING);
4694  1375 ce0000        	ldw	x,_DEBUG_STRING
4695  1378 cd0000        	call	_free
4697                     ; 532 }/*TestADCFFT*/
4700  137b 5b08          	addw	sp,#8
4701  137d 81            	ret	
4918                     	xdef	_TestADCFFT
4919                     	xdef	_GetSignalfrequency
4920                     	xdef	_GetFFTResults
4921                     	xdef	_InitEvalBoard
4922                     	xdef	_FFTall
4923                     	xdef	_getHarmonicPower
4924                     	xdef	_PrintFFTAll
4925                     	xdef	_CloseFFT
4926                     	xdef	_InitFFT
4927                     	xdef	_FillSamplesInv
4928                     	xdef	_FFT
4929                     	xdef	_mulFFT
4930                     	xdef	_FillInv
4931                     	xdef	_FillExp
4932                     	xdef	_flipbits
4933                     	switch	.bss
4934  0000               _DEBUG_STRING:
4935  0000 0000          	ds.b	2
4936                     	xdef	_DEBUG_STRING
4937  0002               _nbit:
4938  0002 0000          	ds.b	2
4939                     	xdef	_nbit
4940                     	xdef	_interpolation
4941  0004               _arrayinv:
4942  0004 0000          	ds.b	2
4943                     	xdef	_arrayinv
4944  0006               _smpl:
4945  0006 0000          	ds.b	2
4946                     	xdef	_smpl
4947  0008               _arrayexp:
4948  0008 0000          	ds.b	2
4949                     	xdef	_arrayexp
4950  000a               _BufferEvalBoardADC:
4951  000a 0000          	ds.b	2
4952                     	xdef	_BufferEvalBoardADC
4953  000c               _AnaResults:
4954  000c 0000          	ds.b	2
4955                     	xdef	_AnaResults
4956                     	xdef	_multiplierEnaX
4957                     	xdef	_multiplierI
4958                     	xdef	_multiplierU
4959                     	xdef	_maxAD
4960                     	xdef	_ADbits
4961                     	xdef	_rangeAD
4962                     	xref	_LCD_RollString
4963                     	xref	_GetDataFromEvalBoardfrequency
4964                     	xref	_GetDataFromEvalBoard
4965                     	xref	_InitEvalBoardparam
4966                     	xref	_InitEvalBoardcard
4967                     	xref	_ConvertInProgress
4968                     	xref	_AllocateEvalBoardBuffer
4969                     	xref	_UnAllocateDataBuffer
4970                     	xref	_SetCPUClock
4971                     	xref	_param
4972                     	xref	_memcpy
4973                     	xref	_sqrt
4974                     	xref	_sin
4975                     	xref	_log
4976                     	xref	_floor
4977                     	xref	_cos
4978                     	xref	_atan2
4979                     	xref	_malloc
4980                     	xref	_free
4981                     	xref	_sprintf
4982                     	switch	.const
4983  001c               L3031:
4984  001c 42480000      	dc.w	16968,0
4985  0020               L1111:
4986  0020 42c80000      	dc.w	17096,0
4987  0024               L7701:
4988  0024 3f000000      	dc.w	16128,0
4989  0028               L3401:
4990  0028 00000000      	dc.w	0,0
4991  002c               L3301:
4992  002c 40c90fda      	dc.w	16585,4058
4993  0030               L517:
4994  0030 3f3504f3      	dc.w	16181,1267
4995  0034               L707:
4996  0034 252b31302e36  	dc.b	"%+10.6eV %+10.6ei "
4997  0046 2020252b3130  	dc.b	"  %+10.6eA %+10.6e"
4998  0058 6920207c2020  	dc.b	"i  |  %+10.6eV %+1"
4999  006a 302e36656920  	dc.b	"0.6ei   %+10.6eA %"
5000  007c 2b31302e3665  	dc.b	"+10.6ei  |  %+10.6"
5001  008e 655620252b31  	dc.b	"eV %+10.6ei   %+10"
5002  00a0 2e3665412025  	dc.b	".6eA %+10.6ei  |  "
5003  00b2 0a00          	dc.b	10,0
5004  00b4               L776:
5005  00b4 0a4861726d6f  	dc.b	10,72,97,114,109,111
5006  00ba 6e6963733a0a  	dc.b	"nics:",10,0
5007  00c1               L366:
5008  00c1 43340000      	dc.w	17204,0
5009  00c5               L356:
5010  00c5 4d23d70a      	dc.w	19747,-10486
5011  00c9               L546:
5012  00c9 6368616e6e65  	dc.b	"channel%u : Ue= %4"
5013  00db 2e3266562c20  	dc.b	".2fV, Ie= %4.2fA, "
5014  00ed 50653d202534  	dc.b	"Pe= %4.2fW, fi= %4"
5015  00ff 2e3266206465  	dc.b	".2f deg, dU= %4.2f"
5016  0111 252c2064493d  	dc.b	"%, dI= %4.2f%",0
5017  011f               L116:
5018  011f 4e6f7420656e  	dc.b	"Not enough memory "
5019  0131 666f72204646  	dc.b	"for FFT",10,0
5020  013a               L306:
5021  013a 3e4ccccc      	dc.w	15948,-13108
5022  013e               L375:
5023  013e 40000000      	dc.w	16384,0
5024  0142               L365:
5025  0142 42000000      	dc.w	16896,0
5026  0146               L325:
5027  0146 47c35000      	dc.w	18371,20480
5028  014a               L741:
5029  014a c0490fda      	dc.w	-16311,4058
5030  014e               L376:
5031  014e 40490fda      	dc.w	16457,4058
5032  0152               L751:
5033  0152 47800000      	dc.w	18304,0
5034                     	xref.b	c_lreg
5035                     	xref.b	c_x
5036                     	xref.b	c_y
5056                     	xref	c_lzmp
5057                     	xref	c_fgadd
5058                     	xref	c_ultof
5059                     	xref	c_lgadd
5060                     	xref	c_lrzmp
5061                     	xref	c_land
5062                     	xref	c_fadd
5063                     	xref	c_ltof
5064                     	xref	c_smul
5065                     	xref	c_llsh
5066                     	xref	c_fsub
5067                     	xref	c_ftoi
5068                     	xref	c_lmod
5069                     	xref	c_uitolx
5070                     	xref	c_itolx
5071                     	xref	c_xymvx
5072                     	xref	c_ladd
5073                     	xref	c_ldiv
5074                     	xref	c_lsub
5075                     	xref	c_lmul
5076                     	xref	c_ltor
5077                     	xref	c_ftol
5078                     	xref	c_fdiv
5079                     	xref	c_rtol
5080                     	xref	c_fmul
5081                     	xref	c_uitof
5082                     	xref	c_imul
5083                     	end
