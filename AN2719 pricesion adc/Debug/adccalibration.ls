   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.6 - 08 Apr 2008
   3                     ; Optimizer V4.2.6 - 08 Apr 2008
  42                     ; 24 static void delay(unsigned long cycles)
  42                     ; 25 {
  44                     	switch	.text
  45  0000               L3_delay:
  47       00000000      OFST:	set	0
  50  0000               L13:
  51                     ; 26   while (cycles--);
  53  0000 96            	ldw	x,sp
  54  0001 1c0003        	addw	x,#OFST+3
  55  0004 cd0000        	call	c_ltor
  57  0007 96            	ldw	x,sp
  58  0008 1c0003        	addw	x,#OFST+3
  59  000b a601          	ld	a,#1
  60  000d cd0000        	call	c_lgsbc
  62  0010 cd0000        	call	c_lrzmp
  64  0013 26eb          	jrne	L13
  65                     ; 27 }
  68  0015 81            	ret	
 197                     ; 31 static unsigned int ADCCollectDataCalib(unsigned int * ADCBuffer, double * ADCRealValues)
 197                     ; 32 {
 198                     	switch	.text
 199  0016               L53_ADCCollectDataCalib:
 201  0016 89            	pushw	x
 202  0017 520d          	subw	sp,#13
 203       0000000d      OFST:	set	13
 206                     ; 37   unsigned char ArrowChar = '^';
 208  0019 a65e          	ld	a,#94
 209  001b 6b02          	ld	(OFST-11,sp),a
 210                     ; 41   ADC2_ITConfig(DISABLE);
 212  001d 4f            	clr	a
 213  001e cd0000        	call	_ADC2_ITConfig
 215                     ; 43   ADC2_Init(ADC2_CONVERSIONMODE_SINGLE, ADC2_CHANNEL_12, ADC2_PRESSEL_FCPU_D6, ADC2_EXTTRIG_TIM, DISABLE, ADC2_ALIGN_RIGHT, ADC2_SCHMITTTRIG_CHANNEL12, DISABLE);
 217  0021 4b00          	push	#0
 218  0023 4b0c          	push	#12
 219  0025 4b08          	push	#8
 220  0027 4b00          	push	#0
 221  0029 4b00          	push	#0
 222  002b 4b30          	push	#48
 223  002d ae000c        	ldw	x,#12
 224  0030 4f            	clr	a
 225  0031 95            	ld	xh,a
 226  0032 cd0000        	call	_ADC2_Init
 228  0035 5b06          	addw	sp,#6
 229                     ; 45   ADC2_ClearFlag();
 231  0037 cd0000        	call	_ADC2_ClearFlag
 233                     ; 49   GPIOB->CR1 |= 0xF0;
 235  003a c65008        	ld	a,20488
 236  003d aaf0          	or	a,#240
 237  003f c75008        	ld	20488,a
 238                     ; 50   GPIOD->CR1 |= 0x80;
 240                     ; 51   Voltage = 0;
 242  0042 5f            	clrw	x
 243  0043 721e5012      	bset	20498,#7
 244  0047 1f0b          	ldw	(OFST-2,sp),x
 245                     ; 52   multiplier = 1000;
 247  0049 ae03e8        	ldw	x,#1000
 248  004c 1f09          	ldw	(OFST-4,sp),x
 249                     ; 53   cursorPos = 2;
 251  004e a602          	ld	a,#2
 252  0050 6b0d          	ld	(OFST+0,sp),a
 253                     ; 55   LCD_Clear();
 255  0052 cd0000        	call	_LCD_Clear
 257                     ; 56   LCD_SetCursorPos(LCD_LINE1, 1);
 259  0055 ae0001        	ldw	x,#1
 260  0058 a680          	ld	a,#128
 261  005a 95            	ld	xh,a
 262  005b cd0000        	call	_LCD_SetCursorPos
 264                     ; 57   LCD_PrintDec4(Voltage);
 266  005e 1e0b          	ldw	x,(OFST-2,sp)
 267  0060 cd0000        	call	_LCD_PrintDec4
 269                     ; 58   LCD_PrintString(LCD_LINE1, DISABLE, ENABLE, "  =Real U");
 271  0063 ae0035        	ldw	x,#L501
 272  0066 89            	pushw	x
 273  0067 4b01          	push	#1
 274  0069 5f            	clrw	x
 275  006a a680          	ld	a,#128
 276  006c 95            	ld	xh,a
 277  006d cd0000        	call	_LCD_PrintString
 279  0070 5b03          	addw	sp,#3
 280                     ; 59   LCD_SetCursorPos(LCD_LINE2, cursorPos/2);
 282  0072 7b0d          	ld	a,(OFST+0,sp)
 283  0074 44            	srl	a
 284  0075 97            	ld	xl,a
 285  0076 a690          	ld	a,#144
 286  0078 95            	ld	xh,a
 287  0079 cd0000        	call	_LCD_SetCursorPos
 289                     ; 60   LCD_PrintChar(ArrowChar); 
 291  007c 7b02          	ld	a,(OFST-11,sp)
 292  007e cd0000        	call	_LCD_PrintChar
 294                     ; 65   for(i=0; i<ADC_BUFFER_SIZE; i++)
 296  0081 5f            	clrw	x
 297  0082 1f07          	ldw	(OFST-6,sp),x
 298  0084               L701:
 299                     ; 67     LCD_SetCursorPos(LCD_LINE2, 0);
 301  0084 5f            	clrw	x
 302  0085 a690          	ld	a,#144
 303  0087 95            	ld	xh,a
 304  0088 cd0000        	call	_LCD_SetCursorPos
 306                     ; 68     LCD_PrintDec2(i);
 308  008b 7b08          	ld	a,(OFST-5,sp)
 309  008d cd0000        	call	_LCD_PrintDec2
 312  0090               L711:
 313                     ; 69     while(JOY_SEL);
 315  0090 720f5010fb    	btjf	20496,#7,L711
 317  0095 cc01df        	jra	L521
 318  0098               L321:
 319                     ; 72       if(BUTTON_LOW)
 321  0098 7200500b0d    	btjt	20491,#0,L131
 322                     ; 73         break;
 323  009d               L721:
 324                     ; 145     if(BUTTON_LOW)
 326  009d 7201500b03cc  	btjt	20491,#0,L112
 327                     ; 147       break;
 328  00a5 1e07          	ldw	x,(OFST-6,sp)
 329  00a7               L311:
 330                     ; 163   return i;
 334  00a7 5b0f          	addw	sp,#15
 335  00a9 81            	ret	
 336  00aa               L131:
 337                     ; 74       JoyUp   = JOY_UP;
 339  00aa 720c500604    	btjt	20486,#6,L63
 340  00af a601          	ld	a,#1
 341  00b1 2001          	jra	L04
 342  00b3               L63:
 343  00b3 4f            	clr	a
 344  00b4               L04:
 345  00b4 6b03          	ld	(OFST-10,sp),a
 346                     ; 75       JoyDown = JOY_DOWN;
 348  00b6 720e500604    	btjt	20486,#7,L24
 349  00bb a601          	ld	a,#1
 350  00bd 2001          	jra	L44
 351  00bf               L24:
 352  00bf 4f            	clr	a
 353  00c0               L44:
 354  00c0 6b04          	ld	(OFST-9,sp),a
 355                     ; 76       JoyLeft = JOY_LEFT;
 357  00c2 7208500604    	btjt	20486,#4,L64
 358  00c7 a601          	ld	a,#1
 359  00c9 2001          	jra	L05
 360  00cb               L64:
 361  00cb 4f            	clr	a
 362  00cc               L05:
 363  00cc 6b05          	ld	(OFST-8,sp),a
 364                     ; 77       JoyRight= JOY_RIGHT;
 366  00ce 720a500604    	btjt	20486,#5,L25
 367  00d3 a601          	ld	a,#1
 368  00d5 2001          	jra	L45
 369  00d7               L25:
 370  00d7 4f            	clr	a
 371  00d8               L45:
 372  00d8 6b06          	ld	(OFST-7,sp),a
 373                     ; 78       JoySel  = JOY_SEL;
 375                     ; 79       if(JoyLeft)//increase multiplier
 377  00da 7b05          	ld	a,(OFST-8,sp)
 378  00dc 2713          	jreq	L331
 379                     ; 81         if (cursorPos!=2) 
 381  00de 7b0d          	ld	a,(OFST+0,sp)
 382  00e0 a102          	cp	a,#2
 383  00e2 270d          	jreq	L331
 384                     ; 83           multiplier *= 10;
 386  00e4 1e09          	ldw	x,(OFST-4,sp)
 387  00e6 90ae000a      	ldw	y,#10
 388  00ea cd0000        	call	c_imul
 390  00ed 1f09          	ldw	(OFST-4,sp),x
 391                     ; 84           cursorPos  -= 1;
 393  00ef 0a0d          	dec	(OFST+0,sp)
 394  00f1               L331:
 395                     ; 87       if(JoyRight)//decrease multiplier
 397  00f1 7b06          	ld	a,(OFST-7,sp)
 398  00f3 270f          	jreq	L731
 399                     ; 89         if (cursorPos!=5) 
 401  00f5 7b0d          	ld	a,(OFST+0,sp)
 402  00f7 a105          	cp	a,#5
 403  00f9 2709          	jreq	L731
 404                     ; 91           multiplier /= 10;
 406  00fb 1e09          	ldw	x,(OFST-4,sp)
 407  00fd a60a          	ld	a,#10
 408  00ff 62            	div	x,a
 409  0100 1f09          	ldw	(OFST-4,sp),x
 410                     ; 92           cursorPos  += 1;
 412  0102 0c0d          	inc	(OFST+0,sp)
 413  0104               L731:
 414                     ; 95       if(JoyRight || JoyLeft)//repaint cursor position
 416  0104 7b06          	ld	a,(OFST-7,sp)
 417  0106 2604          	jrne	L541
 419  0108 7b05          	ld	a,(OFST-8,sp)
 420  010a 273e          	jreq	L341
 421  010c               L541:
 422                     ; 97         LCD_PrintString(LCD_LINE2, DISABLE, DISABLE, "      ");//clear cursor
 424  010c ae002e        	ldw	x,#L741
 425  010f 89            	pushw	x
 426  0110 4b00          	push	#0
 427  0112 5f            	clrw	x
 428  0113 a690          	ld	a,#144
 429  0115 95            	ld	xh,a
 430  0116 cd0000        	call	_LCD_PrintString
 432  0119 5b03          	addw	sp,#3
 433                     ; 98         LCD_SetCursorPos(LCD_LINE2, cursorPos/2);//set cursor position
 435  011b 7b0d          	ld	a,(OFST+0,sp)
 436  011d 44            	srl	a
 437  011e 97            	ld	xl,a
 438  011f a690          	ld	a,#144
 439  0121 95            	ld	xh,a
 440  0122 cd0000        	call	_LCD_SetCursorPos
 442                     ; 99         if(cursorPos & 1)
 444  0125 7b0d          	ld	a,(OFST+0,sp)
 445  0127 a501          	bcp	a,#1
 446  0129 2705          	jreq	L151
 447                     ; 100           LCD_PrintChar(' ');//print space
 449  012b a620          	ld	a,#32
 450  012d cd0000        	call	_LCD_PrintChar
 452  0130               L151:
 453                     ; 101         LCD_PrintChar(ArrowChar);//print cursor
 455  0130 7b02          	ld	a,(OFST-11,sp)
 456  0132 cd0000        	call	_LCD_PrintChar
 459  0135               L551:
 460                     ; 102         while (JOY_RIGHT || JOY_LEFT);
 462  0135 720b5006fb    	btjf	20486,#5,L551
 464  013a 72095006f6    	btjf	20486,#4,L551
 465                     ; 103         delay(1000l);
 467  013f ae03e8        	ldw	x,#1000
 468  0142 89            	pushw	x
 469  0143 5f            	clrw	x
 470  0144 89            	pushw	x
 471  0145 cd0000        	call	L3_delay
 473  0148 5b04          	addw	sp,#4
 474  014a               L341:
 475                     ; 105       if(JoyUp)//increase real value
 477  014a 7b03          	ld	a,(OFST-10,sp)
 478  014c 2707          	jreq	L161
 479                     ; 107         Voltage += multiplier;
 481  014e 1e0b          	ldw	x,(OFST-2,sp)
 482  0150 72fb09        	addw	x,(OFST-4,sp)
 483  0153 1f0b          	ldw	(OFST-2,sp),x
 484  0155               L161:
 485                     ; 109       if(JoyDown)//decrease real value
 487  0155 7b04          	ld	a,(OFST-9,sp)
 488  0157 2707          	jreq	L361
 489                     ; 111         Voltage -= multiplier;
 491  0159 1e0b          	ldw	x,(OFST-2,sp)
 492  015b 72f009        	subw	x,(OFST-4,sp)
 493  015e 1f0b          	ldw	(OFST-2,sp),x
 494  0160               L361:
 495                     ; 113       if(JoyUp || JoyDown)//repaint real value
 497  0160 7b03          	ld	a,(OFST-10,sp)
 498  0162 2604          	jrne	L761
 500  0164 7b04          	ld	a,(OFST-9,sp)
 501  0166 275c          	jreq	L561
 502  0168               L761:
 503                     ; 115         LCD_PrintString(LCD_LINE1, DISABLE, DISABLE, "      ");//clear voltage
 505  0168 ae002e        	ldw	x,#L741
 506  016b 89            	pushw	x
 507  016c 4b00          	push	#0
 508  016e 5f            	clrw	x
 509  016f a680          	ld	a,#128
 510  0171 95            	ld	xh,a
 511  0172 cd0000        	call	_LCD_PrintString
 513  0175 5b03          	addw	sp,#3
 514                     ; 116         if (Voltage<0)
 516  0177 1e0b          	ldw	x,(OFST-2,sp)
 517  0179 2a1a          	jrpl	L171
 518                     ; 118           LCD_SetCursorPos(LCD_LINE1, 1);
 520  017b ae0001        	ldw	x,#1
 521  017e a680          	ld	a,#128
 522  0180 95            	ld	xh,a
 523  0181 cd0000        	call	_LCD_SetCursorPos
 525                     ; 119           LCD_PrintDec4(-Voltage);
 527  0184 1e0b          	ldw	x,(OFST-2,sp)
 528  0186 50            	negw	x
 529  0187 cd0000        	call	_LCD_PrintDec4
 531                     ; 120           LCD_SetCursorPos(LCD_LINE1, 0);
 533  018a 5f            	clrw	x
 534  018b a680          	ld	a,#128
 535  018d 95            	ld	xh,a
 536  018e cd0000        	call	_LCD_SetCursorPos
 538                     ; 121           LCD_PrintChar('-');//print sign
 540  0191 a62d          	ld	a,#45
 543  0193 2017          	jp	LC001
 544  0195               L171:
 545                     ; 125           LCD_SetCursorPos(LCD_LINE1, 1);
 547  0195 ae0001        	ldw	x,#1
 548  0198 a680          	ld	a,#128
 549  019a 95            	ld	xh,a
 550  019b cd0000        	call	_LCD_SetCursorPos
 552                     ; 126           LCD_PrintDec4(Voltage);
 554  019e 1e0b          	ldw	x,(OFST-2,sp)
 555  01a0 cd0000        	call	_LCD_PrintDec4
 557                     ; 127           LCD_SetCursorPos(LCD_LINE1, 0);
 559  01a3 5f            	clrw	x
 560  01a4 a680          	ld	a,#128
 561  01a6 95            	ld	xh,a
 562  01a7 cd0000        	call	_LCD_SetCursorPos
 564                     ; 128           LCD_PrintChar('+');//print sign
 566  01aa a62b          	ld	a,#43
 567  01ac               LC001:
 568  01ac cd0000        	call	_LCD_PrintChar
 570  01af               L771:
 571                     ; 130         while (JOY_UP || JOY_DOWN);
 573  01af 720d5006fb    	btjf	20486,#6,L771
 575  01b4 720f5006f6    	btjf	20486,#7,L771
 576                     ; 131         delay(1000l);
 578  01b9 ae03e8        	ldw	x,#1000
 579  01bc 89            	pushw	x
 580  01bd 5f            	clrw	x
 581  01be 89            	pushw	x
 582  01bf cd0000        	call	L3_delay
 584  01c2 5b04          	addw	sp,#4
 585  01c4               L561:
 586                     ; 135       ADC2_StartConversion();
 588  01c4 cd0000        	call	_ADC2_StartConversion
 591  01c7               L502:
 592                     ; 136       while (!ADC2_GetFlagStatus());
 594  01c7 cd0000        	call	_ADC2_GetFlagStatus
 596  01ca 4d            	tnz	a
 597  01cb 27fa          	jreq	L502
 598                     ; 138       ADC2_ClearFlag();
 600  01cd cd0000        	call	_ADC2_ClearFlag
 602                     ; 140       LCD_SetCursorPos(LCD_LINE2, 5);//set cursor position
 604  01d0 ae0005        	ldw	x,#5
 605  01d3 a690          	ld	a,#144
 606  01d5 95            	ld	xh,a
 607  01d6 cd0000        	call	_LCD_SetCursorPos
 609                     ; 141       LCD_PrintDec4(ADC2_GetConversionValue());
 611  01d9 cd0000        	call	_ADC2_GetConversionValue
 613  01dc cd0000        	call	_LCD_PrintDec4
 615  01df               L521:
 616                     ; 70     while(!JOY_SEL)
 618  01df 720f501003cc  	btjt	20496,#7,L321
 619  01e7 cc009d        	jra	L721
 620  01ea               L112:
 621                     ; 153       ADC2_StartConversion();
 623  01ea cd0000        	call	_ADC2_StartConversion
 626  01ed               L712:
 627                     ; 154       while (!ADC2_GetFlagStatus());
 629  01ed cd0000        	call	_ADC2_GetFlagStatus
 631  01f0 4d            	tnz	a
 632  01f1 27fa          	jreq	L712
 633                     ; 156       ADC2_ClearFlag();
 635  01f3 cd0000        	call	_ADC2_ClearFlag
 637                     ; 158       ADCBuffer[i] = ADC2_GetConversionValue();
 639  01f6 cd0000        	call	_ADC2_GetConversionValue
 641  01f9 1607          	ldw	y,(OFST-6,sp)
 642  01fb 9058          	sllw	y
 643  01fd 72f90e        	addw	y,(OFST+1,sp)
 644  0200 90ff          	ldw	(y),x
 645                     ; 160       ADCRealValues[i] = (double)Voltage/1000;
 647  0202 1e0b          	ldw	x,(OFST-2,sp)
 648  0204 cd0000        	call	c_itof
 650  0207 ae002a        	ldw	x,#L722
 651  020a cd0000        	call	c_fdiv
 653  020d 1e07          	ldw	x,(OFST-6,sp)
 654  020f 58            	sllw	x
 655  0210 58            	sllw	x
 656  0211 72fb12        	addw	x,(OFST+5,sp)
 657  0214 cd0000        	call	c_rtol
 659                     ; 65   for(i=0; i<ADC_BUFFER_SIZE; i++)
 661  0217 1e07          	ldw	x,(OFST-6,sp)
 662  0219 5c            	incw	x
 663  021a 1f07          	ldw	(OFST-6,sp),x
 666  021c a30014        	cpw	x,#20
 667  021f 2403cc0084    	jrult	L701
 668  0224 cc00a7        	jra	L311
 741                     ; 168 static double GetMultiplierCalib(unsigned int * ADCBuffer, double * ADCRealValues, unsigned int NumOfData)
 741                     ; 169 {
 742                     	switch	.text
 743  0227               L332_GetMultiplierCalib:
 745  0227 89            	pushw	x
 746  0228 5209          	subw	sp,#9
 747       00000009      OFST:	set	9
 750                     ; 175   max=0;
 752  022a 5f            	clrw	x
 753  022b 1f06          	ldw	(OFST-3,sp),x
 754                     ; 176   maxindex = 0;
 756  022d 0f05          	clr	(OFST-4,sp)
 757                     ; 177   for(i=0; i<NumOfData; i++)
 759  022f 2019          	jra	L372
 760  0231               L762:
 761                     ; 179     if (max < ADCBuffer[i])
 763  0231 58            	sllw	x
 764  0232 72fb0a        	addw	x,(OFST+1,sp)
 765  0235 fe            	ldw	x,(x)
 766  0236 1306          	cpw	x,(OFST-3,sp)
 767  0238 230d          	jrule	L772
 768                     ; 181       max = ADCBuffer[i];
 770  023a 1e08          	ldw	x,(OFST-1,sp)
 771  023c 58            	sllw	x
 772  023d 72fb0a        	addw	x,(OFST+1,sp)
 773  0240 fe            	ldw	x,(x)
 774  0241 1f06          	ldw	(OFST-3,sp),x
 775                     ; 182       maxindex = i;
 777  0243 7b09          	ld	a,(OFST+0,sp)
 778  0245 6b05          	ld	(OFST-4,sp),a
 779  0247               L772:
 780                     ; 177   for(i=0; i<NumOfData; i++)
 782  0247 1e08          	ldw	x,(OFST-1,sp)
 783  0249 5c            	incw	x
 784  024a               L372:
 786  024a 1f08          	ldw	(OFST-1,sp),x
 789  024c 1310          	cpw	x,(OFST+7,sp)
 790  024e 25e1          	jrult	L762
 791                     ; 186   return (ADCRealValues[maxindex] / ADCBuffer[maxindex]);
 793  0250 7b05          	ld	a,(OFST-4,sp)
 794  0252 5f            	clrw	x
 795  0253 97            	ld	xl,a
 796  0254 58            	sllw	x
 797  0255 72fb0a        	addw	x,(OFST+1,sp)
 798  0258 fe            	ldw	x,(x)
 799  0259 cd0000        	call	c_uitof
 801  025c 96            	ldw	x,sp
 802  025d 5c            	incw	x
 803  025e cd0000        	call	c_rtol
 805  0261 7b05          	ld	a,(OFST-4,sp)
 806  0263 97            	ld	xl,a
 807  0264 a604          	ld	a,#4
 808  0266 42            	mul	x,a
 809  0267 72fb0e        	addw	x,(OFST+5,sp)
 810  026a cd0000        	call	c_ltor
 812  026d 96            	ldw	x,sp
 813  026e 5c            	incw	x
 814  026f cd0000        	call	c_fdiv
 818  0272 5b0b          	addw	sp,#11
 819  0274 81            	ret	
 926                     ; 190 static void ADCCalibratePQ(unsigned int * ADCBuffer, double * ADCRealValues, unsigned int NumOfData, double * P, double * Q)
 926                     ; 191 {
 927                     	switch	.text
 928  0275               L103_ADCCalibratePQ:
 930  0275 89            	pushw	x
 931  0276 5222          	subw	sp,#34
 932       00000022      OFST:	set	34
 935                     ; 217   SumX  = 0;
 937  0278 5f            	clrw	x
 938  0279 1f1f          	ldw	(OFST-3,sp),x
 939  027b 1f1d          	ldw	(OFST-5,sp),x
 940                     ; 218   SumX2 = 0;
 942  027d 1f13          	ldw	(OFST-15,sp),x
 943  027f 1f11          	ldw	(OFST-17,sp),x
 944                     ; 219   SumY  = 0;
 946  0281 1f1b          	ldw	(OFST-7,sp),x
 947  0283 1f19          	ldw	(OFST-9,sp),x
 948                     ; 220   SumXY = 0;
 950  0285 1f17          	ldw	(OFST-11,sp),x
 951  0287 1f15          	ldw	(OFST-13,sp),x
 952                     ; 223   for(i=0; i<NumOfData; i++)
 954  0289 2058          	jra	L553
 955  028b               L153:
 956                     ; 225     SumX  += ADCBuffer[i];
 958  028b 58            	sllw	x
 959  028c 72fb23        	addw	x,(OFST+1,sp)
 960  028f fe            	ldw	x,(x)
 961  0290 cd0000        	call	c_uitolx
 963  0293 96            	ldw	x,sp
 964  0294 1c001d        	addw	x,#OFST-5
 965  0297 cd0000        	call	c_lgadd
 967                     ; 226     SumX2 += (unsigned long)ADCBuffer[i] * (unsigned long)ADCBuffer[i];
 969  029a 1e21          	ldw	x,(OFST-1,sp)
 970  029c 58            	sllw	x
 971  029d 72fb23        	addw	x,(OFST+1,sp)
 972  02a0 1621          	ldw	y,(OFST-1,sp)
 973  02a2 fe            	ldw	x,(x)
 974  02a3 9058          	sllw	y
 975  02a5 72f923        	addw	y,(OFST+1,sp)
 976  02a8 90fe          	ldw	y,(y)
 977  02aa cd0000        	call	c_umul
 979  02ad 96            	ldw	x,sp
 980  02ae 1c0011        	addw	x,#OFST-17
 981  02b1 cd0000        	call	c_lgadd
 983                     ; 227     SumY  += ADCRealValues[i];
 985  02b4 1e21          	ldw	x,(OFST-1,sp)
 986  02b6 58            	sllw	x
 987  02b7 58            	sllw	x
 988  02b8 72fb27        	addw	x,(OFST+5,sp)
 989  02bb cd0000        	call	c_ltor
 991  02be 96            	ldw	x,sp
 992  02bf 1c0019        	addw	x,#OFST-9
 993  02c2 cd0000        	call	c_fgadd
 995                     ; 228     SumXY += ADCBuffer[i] * ADCRealValues[i];
 997  02c5 1e21          	ldw	x,(OFST-1,sp)
 998  02c7 58            	sllw	x
 999  02c8 72fb23        	addw	x,(OFST+1,sp)
1000  02cb fe            	ldw	x,(x)
1001  02cc cd0000        	call	c_uitof
1003  02cf 1e21          	ldw	x,(OFST-1,sp)
1004  02d1 58            	sllw	x
1005  02d2 58            	sllw	x
1006  02d3 72fb27        	addw	x,(OFST+5,sp)
1007  02d6 cd0000        	call	c_fmul
1009  02d9 96            	ldw	x,sp
1010  02da 1c0015        	addw	x,#OFST-13
1011  02dd cd0000        	call	c_fgadd
1013                     ; 223   for(i=0; i<NumOfData; i++)
1015  02e0 1e21          	ldw	x,(OFST-1,sp)
1016  02e2 5c            	incw	x
1017  02e3               L553:
1019  02e3 1f21          	ldw	(OFST-1,sp),x
1022  02e5 1329          	cpw	x,(OFST+7,sp)
1023  02e7 25a2          	jrult	L153
1024                     ; 231   *P = ((NumOfData * SumXY) - (SumX * SumY)) / ((NumOfData * (unsigned long)SumX2) - ((double)SumX * SumX));
1026  02e9 96            	ldw	x,sp
1027  02ea 1c001d        	addw	x,#OFST-5
1028  02ed cd0000        	call	c_ltor
1030  02f0 cd0000        	call	c_ultof
1032  02f3 96            	ldw	x,sp
1033  02f4 1c000d        	addw	x,#OFST-21
1034  02f7 cd0000        	call	c_rtol
1036  02fa 96            	ldw	x,sp
1037  02fb 1c001d        	addw	x,#OFST-5
1038  02fe cd0000        	call	c_ltor
1040  0301 cd0000        	call	c_ultof
1042  0304 96            	ldw	x,sp
1043  0305 1c000d        	addw	x,#OFST-21
1044  0308 cd0000        	call	c_fmul
1046  030b 96            	ldw	x,sp
1047  030c 1c0009        	addw	x,#OFST-25
1048  030f cd0000        	call	c_rtol
1050  0312 1e29          	ldw	x,(OFST+7,sp)
1051  0314 cd0000        	call	c_uitolx
1053  0317 96            	ldw	x,sp
1054  0318 1c0011        	addw	x,#OFST-17
1055  031b cd0000        	call	c_lmul
1057  031e cd0000        	call	c_ultof
1059  0321 96            	ldw	x,sp
1060  0322 1c0009        	addw	x,#OFST-25
1061  0325 cd0000        	call	c_fsub
1063  0328 96            	ldw	x,sp
1064  0329 1c0005        	addw	x,#OFST-29
1065  032c cd0000        	call	c_rtol
1067  032f 96            	ldw	x,sp
1068  0330 1c001d        	addw	x,#OFST-5
1069  0333 cd0000        	call	c_ltor
1071  0336 cd0000        	call	c_ultof
1073  0339 96            	ldw	x,sp
1074  033a 1c0019        	addw	x,#OFST-9
1075  033d cd0000        	call	c_fmul
1077  0340 96            	ldw	x,sp
1078  0341 5c            	incw	x
1079  0342 cd0000        	call	c_rtol
1081  0345 1e29          	ldw	x,(OFST+7,sp)
1082  0347 cd0000        	call	c_uitof
1084  034a 96            	ldw	x,sp
1085  034b 1c0015        	addw	x,#OFST-13
1086  034e cd0000        	call	c_fmul
1088  0351 96            	ldw	x,sp
1089  0352 5c            	incw	x
1090  0353 cd0000        	call	c_fsub
1092  0356 96            	ldw	x,sp
1093  0357 1c0005        	addw	x,#OFST-29
1094  035a cd0000        	call	c_fdiv
1096  035d 1e2b          	ldw	x,(OFST+9,sp)
1097  035f cd0000        	call	c_rtol
1099                     ; 233   *Q = (SumY - (*P * SumX))/NumOfData;
1101  0362 1e29          	ldw	x,(OFST+7,sp)
1102  0364 cd0000        	call	c_uitof
1104  0367 96            	ldw	x,sp
1105  0368 1c000d        	addw	x,#OFST-21
1106  036b cd0000        	call	c_rtol
1108  036e 96            	ldw	x,sp
1109  036f 1c001d        	addw	x,#OFST-5
1110  0372 cd0000        	call	c_ltor
1112  0375 cd0000        	call	c_ultof
1114  0378 96            	ldw	x,sp
1115  0379 1c0009        	addw	x,#OFST-25
1116  037c cd0000        	call	c_rtol
1118  037f 1e2b          	ldw	x,(OFST+9,sp)
1119  0381 cd0000        	call	c_ltor
1121  0384 96            	ldw	x,sp
1122  0385 1c0009        	addw	x,#OFST-25
1123  0388 cd0000        	call	c_fmul
1125  038b 96            	ldw	x,sp
1126  038c 1c0005        	addw	x,#OFST-29
1127  038f cd0000        	call	c_rtol
1129  0392 96            	ldw	x,sp
1130  0393 1c0019        	addw	x,#OFST-9
1131  0396 cd0000        	call	c_ltor
1133  0399 96            	ldw	x,sp
1134  039a 1c0005        	addw	x,#OFST-29
1135  039d cd0000        	call	c_fsub
1137  03a0 96            	ldw	x,sp
1138  03a1 1c000d        	addw	x,#OFST-21
1139  03a4 cd0000        	call	c_fdiv
1141  03a7 1e2d          	ldw	x,(OFST+11,sp)
1142  03a9 cd0000        	call	c_rtol
1144                     ; 234 }//ADCCalibratePQ
1147  03ac 5b24          	addw	sp,#36
1148  03ae 81            	ret	
1236                     ; 237 static double GetErrorCalib(unsigned int * ADCBuffer, double * ADCRealValues, unsigned int NumOfData, double P, double Q)
1236                     ; 238 {
1237                     	switch	.text
1238  03af               L163_GetErrorCalib:
1240  03af 89            	pushw	x
1241  03b0 520e          	subw	sp,#14
1242       0000000e      OFST:	set	14
1245                     ; 249   error=0;
1247  03b2 5f            	clrw	x
1248  03b3 1f07          	ldw	(OFST-7,sp),x
1249  03b5 1f05          	ldw	(OFST-9,sp),x
1250                     ; 250   for(i=0; i<NumOfData; i++)
1252  03b7 203f          	jra	L524
1253  03b9               L124:
1254                     ; 252     diff = (P * ADCBuffer[i] + Q) - ADCRealValues[i];
1256  03b9 58            	sllw	x
1257  03ba 72fb0f        	addw	x,(OFST+1,sp)
1258  03bd fe            	ldw	x,(x)
1259  03be cd0000        	call	c_uitof
1261  03c1 96            	ldw	x,sp
1262  03c2 1c0017        	addw	x,#OFST+9
1263  03c5 cd0000        	call	c_fmul
1265  03c8 96            	ldw	x,sp
1266  03c9 1c001b        	addw	x,#OFST+13
1267  03cc cd0000        	call	c_fadd
1269  03cf 1e0d          	ldw	x,(OFST-1,sp)
1270  03d1 58            	sllw	x
1271  03d2 58            	sllw	x
1272  03d3 72fb13        	addw	x,(OFST+5,sp)
1273  03d6 cd0000        	call	c_fsub
1275  03d9 96            	ldw	x,sp
1276  03da 1c0009        	addw	x,#OFST-5
1277  03dd cd0000        	call	c_rtol
1279                     ; 253     error += diff * diff;
1281  03e0 96            	ldw	x,sp
1282  03e1 1c0009        	addw	x,#OFST-5
1283  03e4 cd0000        	call	c_ltor
1285  03e7 96            	ldw	x,sp
1286  03e8 1c0009        	addw	x,#OFST-5
1287  03eb cd0000        	call	c_fmul
1289  03ee 96            	ldw	x,sp
1290  03ef 1c0005        	addw	x,#OFST-9
1291  03f2 cd0000        	call	c_fgadd
1293                     ; 250   for(i=0; i<NumOfData; i++)
1295  03f5 1e0d          	ldw	x,(OFST-1,sp)
1296  03f7 5c            	incw	x
1297  03f8               L524:
1299  03f8 1f0d          	ldw	(OFST-1,sp),x
1302  03fa 1315          	cpw	x,(OFST+7,sp)
1303  03fc 25bb          	jrult	L124
1304                     ; 255   error = sqrt(error)/NumOfData;
1306  03fe 1e15          	ldw	x,(OFST+7,sp)
1307  0400 cd0000        	call	c_uitof
1309  0403 96            	ldw	x,sp
1310  0404 5c            	incw	x
1311  0405 cd0000        	call	c_rtol
1313  0408 1e07          	ldw	x,(OFST-7,sp)
1314  040a 89            	pushw	x
1315  040b 1e07          	ldw	x,(OFST-7,sp)
1316  040d 89            	pushw	x
1317  040e cd0000        	call	_sqrt
1319  0411 5b04          	addw	sp,#4
1320  0413 96            	ldw	x,sp
1321  0414 5c            	incw	x
1322  0415 cd0000        	call	c_fdiv
1324  0418 96            	ldw	x,sp
1325  0419 1c0005        	addw	x,#OFST-9
1326  041c cd0000        	call	c_rtol
1328                     ; 256   return error;
1330  041f 96            	ldw	x,sp
1331  0420 1c0005        	addw	x,#OFST-9
1332  0423 cd0000        	call	c_ltor
1336  0426 5b10          	addw	sp,#16
1337  0428 81            	ret	
1448                     ; 260 void TestADCCalibration(void)
1448                     ; 261 {
1449                     	switch	.text
1450  0429               _TestADCCalibration:
1452  0429 5234          	subw	sp,#52
1453       00000034      OFST:	set	52
1456                     ; 272   SetCPUClock(0);
1458  042b 4f            	clr	a
1459  042c cd0000        	call	_SetCPUClock
1461                     ; 275   if ((ADCBuffer = malloc(ADC_BUFFER_SIZE * sizeof(ADCBuffer[0]))) == NULL)
1463  042f ae0028        	ldw	x,#40
1464  0432 cd0000        	call	_malloc
1466  0435 1f33          	ldw	(OFST-1,sp),x
1467  0437 2601          	jrne	L574
1468                     ; 276     _asm("trap\n");
1471  0439 83            	trap	
1473  043a               L574:
1474                     ; 277   if ((ADCRealValues = malloc(ADC_BUFFER_SIZE * sizeof(ADCRealValues[0]))) == NULL)
1476  043a ae0050        	ldw	x,#80
1477  043d cd0000        	call	_malloc
1479  0440 1f2d          	ldw	(OFST-7,sp),x
1480  0442 2601          	jrne	L774
1481                     ; 278     _asm("trap\n");
1484  0444 83            	trap	
1486  0445               L774:
1487                     ; 283     NumOfData = ADCCollectDataCalib(ADCBuffer, ADCRealValues);
1489  0445 1e2d          	ldw	x,(OFST-7,sp)
1490  0447 89            	pushw	x
1491  0448 1e35          	ldw	x,(OFST+1,sp)
1492  044a cd0016        	call	L53_ADCCollectDataCalib
1494  044d 5b02          	addw	sp,#2
1495  044f 1f2b          	ldw	(OFST-9,sp),x
1496                     ; 284     P= GetMultiplierCalib(ADCBuffer, ADCRealValues, NumOfData);
1498  0451 89            	pushw	x
1499  0452 1e2f          	ldw	x,(OFST-5,sp)
1500  0454 89            	pushw	x
1501  0455 1e37          	ldw	x,(OFST+3,sp)
1502  0457 cd0227        	call	L332_GetMultiplierCalib
1504  045a 5b04          	addw	sp,#4
1505  045c 96            	ldw	x,sp
1506  045d 1c002f        	addw	x,#OFST-5
1507  0460 cd0000        	call	c_rtol
1509                     ; 285     diffOrig = GetErrorCalib(ADCBuffer, ADCRealValues, NumOfData, P, 0);
1511  0463 ce0028        	ldw	x,L505+2
1512  0466 89            	pushw	x
1513  0467 ce0026        	ldw	x,L505
1514  046a 89            	pushw	x
1515  046b 1e35          	ldw	x,(OFST+1,sp)
1516  046d 89            	pushw	x
1517  046e 1e35          	ldw	x,(OFST+1,sp)
1518  0470 89            	pushw	x
1519  0471 1e33          	ldw	x,(OFST-1,sp)
1520  0473 89            	pushw	x
1521  0474 1e37          	ldw	x,(OFST+3,sp)
1522  0476 89            	pushw	x
1523  0477 1e3f          	ldw	x,(OFST+11,sp)
1524  0479 cd03af        	call	L163_GetErrorCalib
1526  047c 5b0c          	addw	sp,#12
1527  047e 96            	ldw	x,sp
1528  047f 5c            	incw	x
1529  0480 cd0000        	call	c_rtol
1531                     ; 288     ADCCalibratePQ(ADCBuffer, ADCRealValues, NumOfData, &P, &Q);
1533  0483 96            	ldw	x,sp
1534  0484 1c0027        	addw	x,#OFST-13
1535  0487 89            	pushw	x
1536  0488 1c0008        	addw	x,#8
1537  048b 89            	pushw	x
1538  048c 1e2f          	ldw	x,(OFST-5,sp)
1539  048e 89            	pushw	x
1540  048f 1e33          	ldw	x,(OFST-1,sp)
1541  0491 89            	pushw	x
1542  0492 1e3b          	ldw	x,(OFST+7,sp)
1543  0494 cd0275        	call	L103_ADCCalibratePQ
1545  0497 5b08          	addw	sp,#8
1546                     ; 289     diffCalib = GetErrorCalib(ADCBuffer, ADCRealValues, NumOfData, P, Q);
1548  0499 1e29          	ldw	x,(OFST-11,sp)
1549  049b 89            	pushw	x
1550  049c 1e29          	ldw	x,(OFST-11,sp)
1551  049e 89            	pushw	x
1552  049f 1e35          	ldw	x,(OFST+1,sp)
1553  04a1 89            	pushw	x
1554  04a2 1e35          	ldw	x,(OFST+1,sp)
1555  04a4 89            	pushw	x
1556  04a5 1e33          	ldw	x,(OFST-1,sp)
1557  04a7 89            	pushw	x
1558  04a8 1e37          	ldw	x,(OFST+3,sp)
1559  04aa 89            	pushw	x
1560  04ab 1e3f          	ldw	x,(OFST+11,sp)
1561  04ad cd03af        	call	L163_GetErrorCalib
1563  04b0 5b0c          	addw	sp,#12
1564  04b2 96            	ldw	x,sp
1565  04b3 1c0005        	addw	x,#OFST-47
1566  04b6 cd0000        	call	c_rtol
1568                     ; 292     sprintf(DEBUG_STRING, "Orig = %f", diffOrig);
1570  04b9 1e03          	ldw	x,(OFST-49,sp)
1571  04bb 89            	pushw	x
1572  04bc 1e03          	ldw	x,(OFST-49,sp)
1573  04be 89            	pushw	x
1574  04bf ae001c        	ldw	x,#L115
1575  04c2 89            	pushw	x
1576  04c3 96            	ldw	x,sp
1577  04c4 1c000f        	addw	x,#OFST-37
1578  04c7 cd0000        	call	_sprintf
1580  04ca 5b06          	addw	sp,#6
1581                     ; 293     LCD_PrintString(LCD_LINE1, ENABLE, DISABLE, DEBUG_STRING);
1583  04cc 96            	ldw	x,sp
1584  04cd 1c0009        	addw	x,#OFST-43
1585  04d0 89            	pushw	x
1586  04d1 4b00          	push	#0
1587  04d3 ae0001        	ldw	x,#1
1588  04d6 a680          	ld	a,#128
1589  04d8 95            	ld	xh,a
1590  04d9 cd0000        	call	_LCD_PrintString
1592  04dc 5b03          	addw	sp,#3
1593                     ; 294     sprintf(DEBUG_STRING, "Calib= %f", diffCalib);
1595  04de 1e07          	ldw	x,(OFST-45,sp)
1596  04e0 89            	pushw	x
1597  04e1 1e07          	ldw	x,(OFST-45,sp)
1598  04e3 89            	pushw	x
1599  04e4 ae0012        	ldw	x,#L315
1600  04e7 89            	pushw	x
1601  04e8 96            	ldw	x,sp
1602  04e9 1c000f        	addw	x,#OFST-37
1603  04ec cd0000        	call	_sprintf
1605  04ef 5b06          	addw	sp,#6
1606                     ; 295     LCD_PrintString(LCD_LINE2, ENABLE, DISABLE, DEBUG_STRING);
1608  04f1 96            	ldw	x,sp
1609  04f2 1c0009        	addw	x,#OFST-43
1610  04f5 89            	pushw	x
1611  04f6 4b00          	push	#0
1612  04f8 ae0001        	ldw	x,#1
1613  04fb a690          	ld	a,#144
1614  04fd 95            	ld	xh,a
1615  04fe cd0000        	call	_LCD_PrintString
1617  0501 5b03          	addw	sp,#3
1618                     ; 296     delay(500000l);//to show results
1620  0503 aea120        	ldw	x,#41248
1621  0506 89            	pushw	x
1622  0507 ae0007        	ldw	x,#7
1623  050a 89            	pushw	x
1624  050b cd0000        	call	L3_delay
1626  050e 5b04          	addw	sp,#4
1627                     ; 300   LCD_Clear();
1629  0510 cd0000        	call	_LCD_Clear
1631                     ; 301   LCD_PrintString(LCD_LINE1, DISABLE, ENABLE, "Real calibrated U");  
1633  0513 ae0000        	ldw	x,#L515
1634  0516 89            	pushw	x
1635  0517 4b01          	push	#1
1636  0519 5f            	clrw	x
1637  051a a680          	ld	a,#128
1638  051c 95            	ld	xh,a
1639  051d cd0000        	call	_LCD_PrintString
1641  0520 5b03          	addw	sp,#3
1643  0522 2035          	jra	L125
1644  0524               L715:
1645                     ; 305     ADC2_StartConversion();
1647  0524 cd0000        	call	_ADC2_StartConversion
1650  0527               L725:
1651                     ; 306     while (!ADC2_GetFlagStatus());
1653  0527 cd0000        	call	_ADC2_GetFlagStatus
1655  052a 4d            	tnz	a
1656  052b 27fa          	jreq	L725
1657                     ; 308     ADC2_ClearFlag();
1659  052d cd0000        	call	_ADC2_ClearFlag
1661                     ; 310     LCD_SetCursorPos(LCD_LINE2, 4);//set cursor position
1663  0530 ae0004        	ldw	x,#4
1664  0533 a690          	ld	a,#144
1665  0535 95            	ld	xh,a
1666  0536 cd0000        	call	_LCD_SetCursorPos
1668                     ; 311     LCD_PrintDec4((P*ADC2_GetConversionValue() + Q)*1000);
1670  0539 cd0000        	call	_ADC2_GetConversionValue
1672  053c cd0000        	call	c_uitof
1674  053f 96            	ldw	x,sp
1675  0540 1c002f        	addw	x,#OFST-5
1676  0543 cd0000        	call	c_fmul
1678  0546 96            	ldw	x,sp
1679  0547 1c0027        	addw	x,#OFST-13
1680  054a cd0000        	call	c_fadd
1682  054d ae002a        	ldw	x,#L722
1683  0550 cd0000        	call	c_fmul
1685  0553 cd0000        	call	c_ftoi
1687  0556 cd0000        	call	_LCD_PrintDec4
1689  0559               L125:
1690                     ; 302   while(!JOY_SEL)
1692  0559 720e5010c6    	btjt	20496,#7,L715
1693                     ; 315   free(ADCBuffer);
1695  055e 1e33          	ldw	x,(OFST-1,sp)
1696  0560 cd0000        	call	_free
1698                     ; 316 }//TestADCCalibration
1701  0563 5b34          	addw	sp,#52
1702  0565 81            	ret	
1715                     	xdef	_TestADCCalibration
1716                     	xref	_SetCPUClock
1717                     	xref	_LCD_PrintDec4
1718                     	xref	_LCD_PrintDec2
1719                     	xref	_LCD_PrintString
1720                     	xref	_LCD_PrintChar
1721                     	xref	_LCD_SetCursorPos
1722                     	xref	_LCD_Clear
1723                     	xref	_ADC2_ClearFlag
1724                     	xref	_ADC2_GetFlagStatus
1725                     	xref	_ADC2_GetConversionValue
1726                     	xref	_ADC2_StartConversion
1727                     	xref	_ADC2_ITConfig
1728                     	xref	_ADC2_Init
1729                     	xref	_sqrt
1730                     	xref	_malloc
1731                     	xref	_free
1732                     	xref	_sprintf
1733                     .const:	section	.text
1734  0000               L515:
1735  0000 5265616c2063  	dc.b	"Real calibrated U",0
1736  0012               L315:
1737  0012 43616c69623d  	dc.b	"Calib= %f",0
1738  001c               L115:
1739  001c 4f726967203d  	dc.b	"Orig = %f",0
1740  0026               L505:
1741  0026 00000000      	dc.w	0,0
1742  002a               L722:
1743  002a 447a0000      	dc.w	17530,0
1744  002e               L741:
1745  002e 202020202020  	dc.b	"      ",0
1746  0035               L501:
1747  0035 20203d526561  	dc.b	"  =Real U",0
1748                     	xref.b	c_x
1749                     	xref.b	c_y
1769                     	xref	c_ftoi
1770                     	xref	c_fadd
1771                     	xref	c_lmul
1772                     	xref	c_fsub
1773                     	xref	c_ultof
1774                     	xref	c_fmul
1775                     	xref	c_fgadd
1776                     	xref	c_umul
1777                     	xref	c_lgadd
1778                     	xref	c_uitolx
1779                     	xref	c_uitof
1780                     	xref	c_rtol
1781                     	xref	c_fdiv
1782                     	xref	c_itof
1783                     	xref	c_imul
1784                     	xref	c_lrzmp
1785                     	xref	c_lgsbc
1786                     	xref	c_ltor
1787                     	end
