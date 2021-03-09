   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.6 - 08 Apr 2008
   3                     ; Optimizer V4.2.6 - 08 Apr 2008
  66                     ; 19 static void ADCCollectDataWhiteNoise(unsigned int * ADCBuffer)
  66                     ; 20 {
  68                     	switch	.text
  69  0000               L3_ADCCollectDataWhiteNoise:
  71  0000 89            	pushw	x
  72  0001 5204          	subw	sp,#4
  73       00000004      OFST:	set	4
  76                     ; 25     divider = F_CPU / F_SAMPLING;
  78  0003 1e01          	ldw	x,(OFST-3,sp)
  79                     ; 26     CLK -> PCKENR1 |= CLK_PCKENR1_TIM1; //enable clock for timer 1
  81  0005 721e50c7      	bset	20679,#7
  82                     ; 27     TIM1->PSCRH = 0x00;  //prescaller to 0
  84  0009 725f5260      	clr	21088
  85                     ; 28     TIM1->PSCRL = 0x00;
  87  000d 725f5261      	clr	21089
  88                     ; 29     TIM1->ARRH  = divider >> 8;  //reload value
  90  0011 353e5262      	mov	21090,#62
  91                     ; 30     TIM1->ARRL  = divider;
  93  0015 35805263      	mov	21091,#128
  94                     ; 31     TIM1->CR2   = 0x20;  //TRGO enable on update event
  96  0019 35205251      	mov	21073,#32
  97                     ; 32     TIM1->CR1  |= TIM1_CR1_ARPE; //auto preload enable
  99  001d 721e5250      	bset	21072,#7
 100                     ; 33     TIM1->EGR  |= TIM1_EGR_UG;   //generate update event
 102                     ; 36     ADC2_ITConfig(DISABLE);
 104  0021 4f            	clr	a
 105  0022 72105257      	bset	21079,#0
 106  0026 cd0000        	call	_ADC2_ITConfig
 108                     ; 38     ADC2_Init(ADC2_CONVERSIONMODE_SINGLE, ADC2_CHANNEL_12, ADC2_PRESSEL_FCPU_D6, ADC2_EXTTRIG_TIM, ENABLE, ADC2_ALIGN_RIGHT, ADC2_SCHMITTTRIG_CHANNEL12, DISABLE);
 110  0029 4b00          	push	#0
 111  002b 4b0c          	push	#12
 112  002d 4b08          	push	#8
 113  002f 4b01          	push	#1
 114  0031 4b00          	push	#0
 115  0033 4b30          	push	#48
 116  0035 ae000c        	ldw	x,#12
 117  0038 4f            	clr	a
 118  0039 95            	ld	xh,a
 119  003a cd0000        	call	_ADC2_Init
 121  003d 5b06          	addw	sp,#6
 122                     ; 40     ADC2_ClearFlag();
 124  003f cd0000        	call	_ADC2_ClearFlag
 126                     ; 42     TIM1->CR1  |= TIM1_CR1_CEN;  
 128  0042 72105250      	bset	21072,#0
 129                     ; 45     i=0;
 131  0046 5f            	clrw	x
 132  0047 1f03          	ldw	(OFST-1,sp),x
 133  0049               L54:
 134                     ; 49       while (!ADC2_GetFlagStatus());
 136  0049 cd0000        	call	_ADC2_GetFlagStatus
 138  004c 4d            	tnz	a
 139  004d 27fa          	jreq	L54
 140                     ; 51       ADC2_ClearFlag(); //clear end of conversion bit
 142  004f cd0000        	call	_ADC2_ClearFlag
 144                     ; 54       ADCBuffer [i] = ADC2_GetConversionValue();
 146  0052 cd0000        	call	_ADC2_GetConversionValue
 148  0055 1603          	ldw	y,(OFST-1,sp)
 149  0057 9058          	sllw	y
 150  0059 72f905        	addw	y,(OFST+1,sp)
 151  005c 90ff          	ldw	(y),x
 152                     ; 55       i++;
 154  005e 1e03          	ldw	x,(OFST-1,sp)
 155  0060 5c            	incw	x
 156  0061 1f03          	ldw	(OFST-1,sp),x
 157                     ; 46     while (i<ADC_BUFFER_SIZE)
 159  0063 a300c8        	cpw	x,#200
 160  0066 25e1          	jrult	L54
 161                     ; 59     ADC2_Cmd(DISABLE);             //switch off ADC
 163  0068 4f            	clr	a
 164  0069 cd0000        	call	_ADC2_Cmd
 166                     ; 60     TIM1->CR1  &= ~TIM1_CR1_CEN;  //stop timer - trigger
 168  006c 72115250      	bres	21072,#0
 169                     ; 61 }//ADCCollectData
 172  0070 5b06          	addw	sp,#6
 173  0072 81            	ret	
 222                     ; 66 static double AverageWhiteNoise(unsigned int * ADCBuffer)
 222                     ; 67 {
 223                     	switch	.text
 224  0073               L15_AverageWhiteNoise:
 226  0073 89            	pushw	x
 227  0074 5206          	subw	sp,#6
 228       00000006      OFST:	set	6
 231                     ; 73   AverageSum = 0;
 233  0076 5f            	clrw	x
 234  0077 1f03          	ldw	(OFST-3,sp),x
 235  0079 1f01          	ldw	(OFST-5,sp),x
 236                     ; 74   for (i=0; i<(ADC_BUFFER_SIZE); i++)
 238  007b 1f05          	ldw	(OFST-1,sp),x
 239  007d               L57:
 240                     ; 77     AverageSum += ADCBuffer[i];
 242  007d 58            	sllw	x
 243  007e 72fb07        	addw	x,(OFST+1,sp)
 244  0081 fe            	ldw	x,(x)
 245  0082 cd0000        	call	c_uitof
 247  0085 96            	ldw	x,sp
 248  0086 5c            	incw	x
 249  0087 cd0000        	call	c_fgadd
 251                     ; 74   for (i=0; i<(ADC_BUFFER_SIZE); i++)
 253  008a 1e05          	ldw	x,(OFST-1,sp)
 254  008c 5c            	incw	x
 255  008d 1f05          	ldw	(OFST-1,sp),x
 258  008f a300c8        	cpw	x,#200
 259  0092 25e9          	jrult	L57
 260                     ; 79   return (AverageSum/ADC_BUFFER_SIZE);
 262  0094 96            	ldw	x,sp
 263  0095 5c            	incw	x
 264  0096 cd0000        	call	c_ltor
 266  0099 ae001d        	ldw	x,#L701
 267  009c cd0000        	call	c_fdiv
 271  009f 5b08          	addw	sp,#8
 272  00a1 81            	ret	
 332                     ; 84 void TestADCWhiteNoise(void)
 332                     ; 85 {
 333                     	switch	.text
 334  00a2               _TestADCWhiteNoise:
 336  00a2 5224          	subw	sp,#36
 337       00000024      OFST:	set	36
 340                     ; 92   SetCPUClock(0); 
 342  00a4 4f            	clr	a
 343  00a5 cd0000        	call	_SetCPUClock
 345                     ; 95   if ((ADCBuffer = malloc(ADC_BUFFER_SIZE * sizeof(ADCBuffer[0]))) == NULL)
 347  00a8 ae0190        	ldw	x,#400
 348  00ab cd0000        	call	_malloc
 350  00ae 1f23          	ldw	(OFST-1,sp),x
 351  00b0 2601          	jrne	L731
 352                     ; 96     _asm("trap\n");
 355  00b2 83            	trap	
 357  00b3               L731:
 358                     ; 99   ADCCollectDataWhiteNoise(ADCBuffer);
 360  00b3 1e23          	ldw	x,(OFST-1,sp)
 361  00b5 cd0000        	call	L3_ADCCollectDataWhiteNoise
 363                     ; 101   WhiteNoiseResult = AverageWhiteNoise(ADCBuffer);
 365  00b8 1e23          	ldw	x,(OFST-1,sp)
 366  00ba adb7          	call	L15_AverageWhiteNoise
 368  00bc 96            	ldw	x,sp
 369  00bd 5c            	incw	x
 370  00be cd0000        	call	c_rtol
 372                     ; 103   sprintf(DEBUG_STRING, "WhiteNoiseSpreading");
 374  00c1 ae0009        	ldw	x,#L141
 375  00c4 89            	pushw	x
 376  00c5 96            	ldw	x,sp
 377  00c6 1c0007        	addw	x,#OFST-29
 378  00c9 cd0000        	call	_sprintf
 380  00cc 85            	popw	x
 381                     ; 104   LCD_PrintString(LCD_LINE1, ENABLE, DISABLE, DEBUG_STRING);
 383  00cd 96            	ldw	x,sp
 384  00ce 1c0005        	addw	x,#OFST-31
 385  00d1 89            	pushw	x
 386  00d2 4b00          	push	#0
 387  00d4 ae0001        	ldw	x,#1
 388  00d7 a680          	ld	a,#128
 389  00d9 95            	ld	xh,a
 390  00da cd0000        	call	_LCD_PrintString
 392  00dd 5b03          	addw	sp,#3
 393                     ; 105   sprintf(DEBUG_STRING, "V= %5.4f", WhiteNoiseResult);
 395  00df 1e03          	ldw	x,(OFST-33,sp)
 396  00e1 89            	pushw	x
 397  00e2 1e03          	ldw	x,(OFST-33,sp)
 398  00e4 89            	pushw	x
 399  00e5 ae0000        	ldw	x,#L341
 400  00e8 89            	pushw	x
 401  00e9 96            	ldw	x,sp
 402  00ea 1c000b        	addw	x,#OFST-25
 403  00ed cd0000        	call	_sprintf
 405  00f0 5b06          	addw	sp,#6
 406                     ; 106   LCD_PrintString(LCD_LINE2, ENABLE, DISABLE, DEBUG_STRING);
 408  00f2 96            	ldw	x,sp
 409  00f3 1c0005        	addw	x,#OFST-31
 410  00f6 89            	pushw	x
 411  00f7 4b00          	push	#0
 412  00f9 ae0001        	ldw	x,#1
 413  00fc a690          	ld	a,#144
 414  00fe 95            	ld	xh,a
 415  00ff cd0000        	call	_LCD_PrintString
 417  0102 5b03          	addw	sp,#3
 418                     ; 109   free(ADCBuffer);
 420  0104 1e23          	ldw	x,(OFST-1,sp)
 421  0106 cd0000        	call	_free
 423                     ; 110 }//TestADCWhiteNoise
 426  0109 5b24          	addw	sp,#36
 427  010b 81            	ret	
 440                     	xdef	_TestADCWhiteNoise
 441                     	xref	_LCD_PrintString
 442                     	xref	_SetCPUClock
 443                     	xref	_ADC2_ClearFlag
 444                     	xref	_ADC2_GetFlagStatus
 445                     	xref	_ADC2_GetConversionValue
 446                     	xref	_ADC2_ITConfig
 447                     	xref	_ADC2_Cmd
 448                     	xref	_ADC2_Init
 449                     	xref	_malloc
 450                     	xref	_free
 451                     	xref	_sprintf
 452                     .const:	section	.text
 453  0000               L341:
 454  0000 563d2025352e  	dc.b	"V= %5.4f",0
 455  0009               L141:
 456  0009 57686974654e  	dc.b	"WhiteNoiseSpreadin"
 457  001b 6700          	dc.b	"g",0
 458  001d               L701:
 459  001d 43480000      	dc.w	17224,0
 460                     	xref.b	c_x
 480                     	xref	c_rtol
 481                     	xref	c_fdiv
 482                     	xref	c_ltor
 483                     	xref	c_fgadd
 484                     	xref	c_uitof
 485                     	end
