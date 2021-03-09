   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.6 - 08 Apr 2008
   3                     ; Optimizer V4.2.6 - 08 Apr 2008
  65                     ; 18 static void ADCCollectDataAvrg(unsigned int * ADCBuffer)
  65                     ; 19 {
  67                     	switch	.text
  68  0000               L3_ADCCollectDataAvrg:
  70  0000 89            	pushw	x
  71  0001 5204          	subw	sp,#4
  72       00000004      OFST:	set	4
  75                     ; 24     divider = F_CPU / F_SAMPLING;
  77  0003 1e01          	ldw	x,(OFST-3,sp)
  78                     ; 25     CLK -> PCKENR1 |= CLK_PCKENR1_TIM1; //enable clock for timer 1
  80  0005 721e50c7      	bset	20679,#7
  81                     ; 26     TIM1->PSCRH = 0x00;  //prescaller to 0
  83  0009 725f5260      	clr	21088
  84                     ; 27     TIM1->PSCRL = 0x00;
  86  000d 725f5261      	clr	21089
  87                     ; 28     TIM1->ARRH  = divider >> 8;  //reload value
  89  0011 353e5262      	mov	21090,#62
  90                     ; 29     TIM1->ARRL  = divider;
  92  0015 35805263      	mov	21091,#128
  93                     ; 30     TIM1->CR2   = 0x20;  //TRGO enable on update event
  95  0019 35205251      	mov	21073,#32
  96                     ; 31     TIM1->CR1  |= TIM1_CR1_ARPE; //auto preload enable
  98  001d 721e5250      	bset	21072,#7
  99                     ; 32     TIM1->EGR  |= TIM1_EGR_UG;   //generate update event
 101                     ; 35     ADC2_ITConfig(DISABLE);
 103  0021 4f            	clr	a
 104  0022 72105257      	bset	21079,#0
 105  0026 cd0000        	call	_ADC2_ITConfig
 107                     ; 37     ADC2_Init(ADC2_CONVERSIONMODE_SINGLE, ADC2_CHANNEL_12, ADC2_PRESSEL_FCPU_D6, ADC2_EXTTRIG_TIM, ENABLE, ADC2_ALIGN_RIGHT, ADC2_SCHMITTTRIG_CHANNEL12, DISABLE);
 109  0029 4b00          	push	#0
 110  002b 4b0c          	push	#12
 111  002d 4b08          	push	#8
 112  002f 4b01          	push	#1
 113  0031 4b00          	push	#0
 114  0033 4b30          	push	#48
 115  0035 ae000c        	ldw	x,#12
 116  0038 4f            	clr	a
 117  0039 95            	ld	xh,a
 118  003a cd0000        	call	_ADC2_Init
 120  003d 5b06          	addw	sp,#6
 121                     ; 39     ADC2_ClearFlag();
 123  003f cd0000        	call	_ADC2_ClearFlag
 125                     ; 42     TIM1->CR1  |= TIM1_CR1_CEN;  
 127  0042 72105250      	bset	21072,#0
 128                     ; 45     i=0;
 130  0046 5f            	clrw	x
 131  0047 1f03          	ldw	(OFST-1,sp),x
 132  0049               L54:
 133                     ; 49       while (!ADC2_GetFlagStatus());
 135  0049 cd0000        	call	_ADC2_GetFlagStatus
 137  004c 4d            	tnz	a
 138  004d 27fa          	jreq	L54
 139                     ; 52       ADC2_ClearFlag(); 
 141  004f cd0000        	call	_ADC2_ClearFlag
 143                     ; 55       ADCBuffer [i] = ADC2_GetConversionValue();
 145  0052 cd0000        	call	_ADC2_GetConversionValue
 147  0055 1603          	ldw	y,(OFST-1,sp)
 148  0057 9058          	sllw	y
 149  0059 72f905        	addw	y,(OFST+1,sp)
 150  005c 90ff          	ldw	(y),x
 151                     ; 56       i++;
 153  005e 1e03          	ldw	x,(OFST-1,sp)
 154  0060 5c            	incw	x
 155  0061 1f03          	ldw	(OFST-1,sp),x
 156                     ; 46     while (i<ADC_BUFFER_SIZE)
 158  0063 a300c8        	cpw	x,#200
 159  0066 25e1          	jrult	L54
 160                     ; 61     ADC2_Cmd(DISABLE);             //switch off ADC
 162  0068 4f            	clr	a
 163  0069 cd0000        	call	_ADC2_Cmd
 165                     ; 62     TIM1->CR1  &= ~TIM1_CR1_CEN;  //stop timer - trigger
 167  006c 72115250      	bres	21072,#0
 168                     ; 63 }//ADCCollectData
 171  0070 5b06          	addw	sp,#6
 172  0072 81            	ret	
 228                     .const:	section	.text
 229  0000               L62:
 230  0000 0000000a      	dc.l	10
 231                     ; 67 void Average(unsigned int * ADCBuffer)
 231                     ; 68 {
 232                     	switch	.text
 233  0073               _Average:
 235  0073 89            	pushw	x
 236  0074 5208          	subw	sp,#8
 237       00000008      OFST:	set	8
 240                     ; 73   for (i=0; i<(ADC_BUFFER_SIZE-AVERAGE_LENGTH); i++)
 242  0076 5f            	clrw	x
 243  0077 1f05          	ldw	(OFST-3,sp),x
 244  0079               L57:
 245                     ; 75     AverageSum = 0;
 247  0079 5f            	clrw	x
 248  007a 1f03          	ldw	(OFST-5,sp),x
 249  007c 1f01          	ldw	(OFST-7,sp),x
 250                     ; 77     for(j=0; j<AVERAGE_LENGTH; j++)
 252  007e 1f07          	ldw	(OFST-1,sp),x
 253  0080               L301:
 254                     ; 78       AverageSum += ADCBuffer[j+i];
 256  0080 72fb05        	addw	x,(OFST-3,sp)
 257  0083 58            	sllw	x
 258  0084 72fb09        	addw	x,(OFST+1,sp)
 259  0087 fe            	ldw	x,(x)
 260  0088 cd0000        	call	c_uitolx
 262  008b 96            	ldw	x,sp
 263  008c 5c            	incw	x
 264  008d cd0000        	call	c_lgadd
 266                     ; 77     for(j=0; j<AVERAGE_LENGTH; j++)
 268  0090 1e07          	ldw	x,(OFST-1,sp)
 269  0092 5c            	incw	x
 270  0093 1f07          	ldw	(OFST-1,sp),x
 273  0095 a3000a        	cpw	x,#10
 274  0098 25e6          	jrult	L301
 275                     ; 81     ADCBuffer[i]= AverageSum/AVERAGE_LENGTH;
 277  009a 96            	ldw	x,sp
 278  009b 5c            	incw	x
 279  009c cd0000        	call	c_ltor
 281  009f ae0000        	ldw	x,#L62
 282  00a2 cd0000        	call	c_ludv
 284  00a5 1e05          	ldw	x,(OFST-3,sp)
 285  00a7 58            	sllw	x
 286  00a8 72fb09        	addw	x,(OFST+1,sp)
 287  00ab 90be02        	ldw	y,c_lreg+2
 288  00ae ff            	ldw	(x),y
 289                     ; 73   for (i=0; i<(ADC_BUFFER_SIZE-AVERAGE_LENGTH); i++)
 291  00af 1e05          	ldw	x,(OFST-3,sp)
 292  00b1 5c            	incw	x
 293  00b2 1f05          	ldw	(OFST-3,sp),x
 296  00b4 a300be        	cpw	x,#190
 297  00b7 25c0          	jrult	L57
 298                     ; 83 }//Average
 301  00b9 5b0a          	addw	sp,#10
 302  00bb 81            	ret	
 365                     ; 87 static unsigned int GetMinMaxAvrg(unsigned int * Buffer, unsigned int buffersize)
 365                     ; 88 {
 366                     	switch	.text
 367  00bc               L111_GetMinMaxAvrg:
 369  00bc 89            	pushw	x
 370  00bd 5206          	subw	sp,#6
 371       00000006      OFST:	set	6
 374                     ; 91   min=0xFFFF;
 376  00bf aeffff        	ldw	x,#65535
 377  00c2 1f01          	ldw	(OFST-5,sp),x
 378                     ; 92   max=0;
 380  00c4 5f            	clrw	x
 381  00c5 1f03          	ldw	(OFST-3,sp),x
 382                     ; 93   for (i=0; i<buffersize; i++)
 384  00c7 2029          	jra	L541
 385  00c9               L141:
 386                     ; 95     if (Buffer[i]<min)
 388  00c9 58            	sllw	x
 389  00ca 72fb07        	addw	x,(OFST+1,sp)
 390  00cd fe            	ldw	x,(x)
 391  00ce 1301          	cpw	x,(OFST-5,sp)
 392  00d0 2409          	jruge	L151
 393                     ; 96       min = Buffer[i];
 395  00d2 1e05          	ldw	x,(OFST-1,sp)
 396  00d4 58            	sllw	x
 397  00d5 72fb07        	addw	x,(OFST+1,sp)
 398  00d8 fe            	ldw	x,(x)
 399  00d9 1f01          	ldw	(OFST-5,sp),x
 400  00db               L151:
 401                     ; 97     if (Buffer[i]>max)
 403  00db 1e05          	ldw	x,(OFST-1,sp)
 404  00dd 58            	sllw	x
 405  00de 72fb07        	addw	x,(OFST+1,sp)
 406  00e1 fe            	ldw	x,(x)
 407  00e2 1303          	cpw	x,(OFST-3,sp)
 408  00e4 2309          	jrule	L351
 409                     ; 98       max = Buffer[i];
 411  00e6 1e05          	ldw	x,(OFST-1,sp)
 412  00e8 58            	sllw	x
 413  00e9 72fb07        	addw	x,(OFST+1,sp)
 414  00ec fe            	ldw	x,(x)
 415  00ed 1f03          	ldw	(OFST-3,sp),x
 416  00ef               L351:
 417                     ; 93   for (i=0; i<buffersize; i++)
 419  00ef 1e05          	ldw	x,(OFST-1,sp)
 420  00f1 5c            	incw	x
 421  00f2               L541:
 423  00f2 1f05          	ldw	(OFST-1,sp),x
 426  00f4 130b          	cpw	x,(OFST+5,sp)
 427  00f6 25d1          	jrult	L141
 428                     ; 100   return(max-min);
 430  00f8 1e03          	ldw	x,(OFST-3,sp)
 431  00fa 72f001        	subw	x,(OFST-5,sp)
 434  00fd 5b08          	addw	sp,#8
 435  00ff 81            	ret	
 507                     ; 105 void TestADCAveraging(void)
 507                     ; 106 {
 508                     	switch	.text
 509  0100               _TestADCAveraging:
 511  0100 5224          	subw	sp,#36
 512       00000024      OFST:	set	36
 515                     ; 114   SetCPUClock(0); 
 517  0102 4f            	clr	a
 518  0103 cd0000        	call	_SetCPUClock
 520                     ; 117   if ((ADCBuffer = malloc(ADC_BUFFER_SIZE * sizeof(ADCBuffer[0]))) == NULL)
 522  0106 ae0190        	ldw	x,#400
 523  0109 cd0000        	call	_malloc
 525  010c 1f23          	ldw	(OFST-1,sp),x
 526  010e 2601          	jrne	L702
 527                     ; 118     _asm("trap\n");
 530  0110 83            	trap	
 532  0111               L702:
 533                     ; 121   ADCCollectDataAvrg(ADCBuffer);
 535  0111 1e23          	ldw	x,(OFST-1,sp)
 536  0113 cd0000        	call	L3_ADCCollectDataAvrg
 538                     ; 122   diffOrig = GetMinMaxAvrg(ADCBuffer, ADC_BUFFER_SIZE-AVERAGE_LENGTH);
 540  0116 ae00be        	ldw	x,#190
 541  0119 89            	pushw	x
 542  011a 1e25          	ldw	x,(OFST+1,sp)
 543  011c ad9e          	call	L111_GetMinMaxAvrg
 545  011e 5b02          	addw	sp,#2
 546  0120 1f01          	ldw	(OFST-35,sp),x
 547                     ; 125   Average(ADCBuffer);
 549  0122 1e23          	ldw	x,(OFST-1,sp)
 550  0124 cd0073        	call	_Average
 552                     ; 126   diffAvrg = GetMinMaxAvrg(ADCBuffer, ADC_BUFFER_SIZE-AVERAGE_LENGTH);
 554  0127 ae00be        	ldw	x,#190
 555  012a 89            	pushw	x
 556  012b 1e25          	ldw	x,(OFST+1,sp)
 557  012d ad8d          	call	L111_GetMinMaxAvrg
 559  012f 5b02          	addw	sp,#2
 560  0131 1f03          	ldw	(OFST-33,sp),x
 561                     ; 128   sprintf(DEBUG_STRING, "Original= %d", diffOrig);
 563  0133 1e01          	ldw	x,(OFST-35,sp)
 564  0135 89            	pushw	x
 565  0136 ae0011        	ldw	x,#L112
 566  0139 89            	pushw	x
 567  013a 96            	ldw	x,sp
 568  013b 1c0009        	addw	x,#OFST-27
 569  013e cd0000        	call	_sprintf
 571  0141 5b04          	addw	sp,#4
 572                     ; 129   LCD_PrintString(LCD_LINE1, ENABLE, DISABLE, DEBUG_STRING);
 574  0143 96            	ldw	x,sp
 575  0144 1c0005        	addw	x,#OFST-31
 576  0147 89            	pushw	x
 577  0148 4b00          	push	#0
 578  014a ae0001        	ldw	x,#1
 579  014d a680          	ld	a,#128
 580  014f 95            	ld	xh,a
 581  0150 cd0000        	call	_LCD_PrintString
 583  0153 5b03          	addw	sp,#3
 584                     ; 130   sprintf(DEBUG_STRING, "Average = %d", diffAvrg);
 586  0155 1e03          	ldw	x,(OFST-33,sp)
 587  0157 89            	pushw	x
 588  0158 ae0004        	ldw	x,#L312
 589  015b 89            	pushw	x
 590  015c 96            	ldw	x,sp
 591  015d 1c0009        	addw	x,#OFST-27
 592  0160 cd0000        	call	_sprintf
 594  0163 5b04          	addw	sp,#4
 595                     ; 131   LCD_PrintString(LCD_LINE2, ENABLE, DISABLE, DEBUG_STRING);
 597  0165 96            	ldw	x,sp
 598  0166 1c0005        	addw	x,#OFST-31
 599  0169 89            	pushw	x
 600  016a 4b00          	push	#0
 601  016c ae0001        	ldw	x,#1
 602  016f a690          	ld	a,#144
 603  0171 95            	ld	xh,a
 604  0172 cd0000        	call	_LCD_PrintString
 606  0175 5b03          	addw	sp,#3
 607                     ; 134   free(ADCBuffer);
 609  0177 1e23          	ldw	x,(OFST-1,sp)
 610  0179 cd0000        	call	_free
 612                     ; 135 }//TestADCAveraging
 615  017c 5b24          	addw	sp,#36
 616  017e 81            	ret	
 629                     	xdef	_TestADCAveraging
 630                     	xdef	_Average
 631                     	xref	_LCD_PrintString
 632                     	xref	_SetCPUClock
 633                     	xref	_ADC2_ClearFlag
 634                     	xref	_ADC2_GetFlagStatus
 635                     	xref	_ADC2_GetConversionValue
 636                     	xref	_ADC2_ITConfig
 637                     	xref	_ADC2_Cmd
 638                     	xref	_ADC2_Init
 639                     	xref	_malloc
 640                     	xref	_free
 641                     	xref	_sprintf
 642                     	switch	.const
 643  0004               L312:
 644  0004 417665726167  	dc.b	"Average = %d",0
 645  0011               L112:
 646  0011 4f726967696e  	dc.b	"Original= %d",0
 647                     	xref.b	c_lreg
 648                     	xref.b	c_x
 668                     	xref	c_ludv
 669                     	xref	c_ltor
 670                     	xref	c_lgadd
 671                     	xref	c_uitolx
 672                     	end
