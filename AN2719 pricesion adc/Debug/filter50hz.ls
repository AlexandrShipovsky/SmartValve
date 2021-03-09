   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.6 - 08 Apr 2008
   3                     ; Optimizer V4.2.6 - 08 Apr 2008
  65                     ; 18 void ADCCollectDataFilt(unsigned int * ADCBuffer)
  65                     ; 19 {
  67                     	switch	.text
  68  0000               _ADCCollectDataFilt:
  70  0000 89            	pushw	x
  71  0001 5204          	subw	sp,#4
  72       00000004      OFST:	set	4
  75                     ; 24     divider = F_CPU / SAMPLES_PER_PERIOD / F_FILTER;
  77  0003 1e01          	ldw	x,(OFST-3,sp)
  78                     ; 25     CLK -> PCKENR1 |= CLK_PCKENR1_TIM1; //enable clock for timer 1
  80  0005 721e50c7      	bset	20679,#7
  81                     ; 26     TIM1->PSCRH = 0x00;  //prescaller to 0
  83  0009 725f5260      	clr	21088
  84                     ; 27     TIM1->PSCRL = 0x00;
  86  000d 725f5261      	clr	21089
  87                     ; 28     TIM1->ARRH  = divider >> 8;  //reload value
  89  0011 357d5262      	mov	21090,#125
  90                     ; 29     TIM1->ARRL  = divider;
  92  0015 35005263      	mov	21091,#0
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
 132  0049               L34:
 133                     ; 49       while (!ADC2_GetFlagStatus());
 135  0049 cd0000        	call	_ADC2_GetFlagStatus
 137  004c 4d            	tnz	a
 138  004d 27fa          	jreq	L34
 139                     ; 51       ADC2_ClearFlag(); 
 141  004f cd0000        	call	_ADC2_ClearFlag
 143                     ; 53       ADCBuffer [i] = ADC2_GetConversionValue();
 145  0052 cd0000        	call	_ADC2_GetConversionValue
 147  0055 1603          	ldw	y,(OFST-1,sp)
 148  0057 9058          	sllw	y
 149  0059 72f905        	addw	y,(OFST+1,sp)
 150  005c 90ff          	ldw	(y),x
 151                     ; 54       i++;
 153  005e 1e03          	ldw	x,(OFST-1,sp)
 154  0060 5c            	incw	x
 155  0061 1f03          	ldw	(OFST-1,sp),x
 156                     ; 46     while (i<ADC_BUFFER_SIZE)
 158  0063 a303e8        	cpw	x,#1000
 159  0066 25e1          	jrult	L34
 160                     ; 58     ADC2_Cmd(DISABLE);            //switch off ADC
 162  0068 4f            	clr	a
 163  0069 cd0000        	call	_ADC2_Cmd
 165                     ; 59     TIM1->CR1  &= ~TIM1_CR1_CEN;  //stop timer - trigger
 167  006c 72115250      	bres	21072,#0
 168                     ; 60 }//ADCCollectData
 171  0070 5b06          	addw	sp,#6
 172  0072 81            	ret	
 241                     .const:	section	.text
 242  0000               L03:
 243  0000 0000000a      	dc.l	10
 244                     ; 65 static void Filter50Hz(unsigned int * ADCBuffer)
 244                     ; 66 {
 245                     	switch	.text
 246  0073               L74_Filter50Hz:
 248  0073 89            	pushw	x
 249  0074 520a          	subw	sp,#10
 250       0000000a      OFST:	set	10
 253                     ; 77   if ((ACC = malloc(SAMPLES_PER_PERIOD * sizeof(ACC[0]))) == NULL)
 255  0076 ae0028        	ldw	x,#40
 256  0079 cd0000        	call	_malloc
 258  007c 1f05          	ldw	(OFST-5,sp),x
 259  007e 2601          	jrne	L101
 260                     ; 78     _asm("trap\n");
 263  0080 83            	trap	
 265  0081               L101:
 266                     ; 81   for (i=0; i< SAMPLES_PER_PERIOD; i++)
 268  0081 5f            	clrw	x
 269  0082 1f07          	ldw	(OFST-3,sp),x
 270  0084               L301:
 271                     ; 82     ACC[i]=ADCBuffer[0];
 273  0084 1e0b          	ldw	x,(OFST+1,sp)
 274  0086 fe            	ldw	x,(x)
 275  0087 cd0000        	call	c_uitolx
 277  008a 1e07          	ldw	x,(OFST-3,sp)
 278  008c 58            	sllw	x
 279  008d 58            	sllw	x
 280  008e 72fb05        	addw	x,(OFST-5,sp)
 281  0091 cd0000        	call	c_rtol
 283                     ; 81   for (i=0; i< SAMPLES_PER_PERIOD; i++)
 285  0094 1e07          	ldw	x,(OFST-3,sp)
 286  0096 5c            	incw	x
 287  0097 1f07          	ldw	(OFST-3,sp),x
 290  0099 a3000a        	cpw	x,#10
 291  009c 25e6          	jrult	L301
 292                     ; 83   IntegratorOut=ADCBuffer[0];
 294  009e 1e0b          	ldw	x,(OFST+1,sp)
 295  00a0 fe            	ldw	x,(x)
 296  00a1 cd0000        	call	c_uitolx
 298  00a4 96            	ldw	x,sp
 299  00a5 5c            	incw	x
 300  00a6 cd0000        	call	c_rtol
 302                     ; 86   for (i=0; i<ADC_BUFFER_SIZE; i++)
 304  00a9 5f            	clrw	x
 305  00aa 1f07          	ldw	(OFST-3,sp),x
 306  00ac               L111:
 307                     ; 88     for(j=SAMPLES_PER_PERIOD-1; j>0 ; j--)
 309  00ac ae0009        	ldw	x,#9
 310  00af 1f09          	ldw	(OFST-1,sp),x
 311  00b1               L711:
 312                     ; 89       ACC[j]=ACC[j-1];
 314  00b1 58            	sllw	x
 315  00b2 58            	sllw	x
 316  00b3 1d0004        	subw	x,#4
 317  00b6 72fb05        	addw	x,(OFST-5,sp)
 318  00b9 1609          	ldw	y,(OFST-1,sp)
 319  00bb 9058          	sllw	y
 320  00bd 9058          	sllw	y
 321  00bf 72f905        	addw	y,(OFST-5,sp)
 322  00c2 e603          	ld	a,(3,x)
 323  00c4 90e703        	ld	(3,y),a
 324  00c7 e602          	ld	a,(2,x)
 325  00c9 90e702        	ld	(2,y),a
 326  00cc e601          	ld	a,(1,x)
 327  00ce 90e701        	ld	(1,y),a
 328  00d1 f6            	ld	a,(x)
 329  00d2 90f7          	ld	(y),a
 330                     ; 88     for(j=SAMPLES_PER_PERIOD-1; j>0 ; j--)
 332  00d4 1e09          	ldw	x,(OFST-1,sp)
 333  00d6 5a            	decw	x
 334  00d7 1f09          	ldw	(OFST-1,sp),x
 337  00d9 26d6          	jrne	L711
 338                     ; 90     ACC[0]=IntegratorOut;
 340  00db 1e05          	ldw	x,(OFST-5,sp)
 341  00dd 7b04          	ld	a,(OFST-6,sp)
 342  00df e703          	ld	(3,x),a
 343  00e1 7b03          	ld	a,(OFST-7,sp)
 344  00e3 e702          	ld	(2,x),a
 345  00e5 7b02          	ld	a,(OFST-8,sp)
 346  00e7 e701          	ld	(1,x),a
 347  00e9 7b01          	ld	a,(OFST-9,sp)
 348  00eb f7            	ld	(x),a
 349                     ; 91     IntegratorOut += ADCBuffer[i];    
 351  00ec 1e07          	ldw	x,(OFST-3,sp)
 352  00ee 58            	sllw	x
 353  00ef 72fb0b        	addw	x,(OFST+1,sp)
 354  00f2 fe            	ldw	x,(x)
 355  00f3 cd0000        	call	c_uitolx
 357  00f6 96            	ldw	x,sp
 358  00f7 5c            	incw	x
 359  00f8 cd0000        	call	c_lgadd
 361                     ; 94     ADCBuffer[i]= (IntegratorOut - ACC[SAMPLES_PER_PERIOD-1])/SAMPLES_PER_PERIOD;
 363  00fb 96            	ldw	x,sp
 364  00fc 5c            	incw	x
 365  00fd cd0000        	call	c_ltor
 367  0100 1e05          	ldw	x,(OFST-5,sp)
 368  0102 1c0024        	addw	x,#36
 369  0105 cd0000        	call	c_lsub
 371  0108 ae0000        	ldw	x,#L03
 372  010b cd0000        	call	c_ludv
 374  010e 1e07          	ldw	x,(OFST-3,sp)
 375  0110 58            	sllw	x
 376  0111 72fb0b        	addw	x,(OFST+1,sp)
 377  0114 90be02        	ldw	y,c_lreg+2
 378  0117 ff            	ldw	(x),y
 379                     ; 86   for (i=0; i<ADC_BUFFER_SIZE; i++)
 381  0118 1e07          	ldw	x,(OFST-3,sp)
 382  011a 5c            	incw	x
 383  011b 1f07          	ldw	(OFST-3,sp),x
 386  011d a303e8        	cpw	x,#1000
 387  0120 258a          	jrult	L111
 388                     ; 96   free(ACC) ;
 390  0122 1e05          	ldw	x,(OFST-5,sp)
 391  0124 cd0000        	call	_free
 393                     ; 97 }//Filter50Hz
 396  0127 5b0c          	addw	sp,#12
 397  0129 81            	ret	
 460                     ; 102 unsigned int GetMinMaxFilt(unsigned int * Buffer, unsigned int buffersize)
 460                     ; 103 {
 461                     	switch	.text
 462  012a               _GetMinMaxFilt:
 464  012a 89            	pushw	x
 465  012b 5206          	subw	sp,#6
 466       00000006      OFST:	set	6
 469                     ; 106   min=0xFFFF;
 471  012d aeffff        	ldw	x,#65535
 472  0130 1f01          	ldw	(OFST-5,sp),x
 473                     ; 107   max=0;
 475  0132 5f            	clrw	x
 476  0133 1f03          	ldw	(OFST-3,sp),x
 477                     ; 108   for (i=0; i<buffersize; i++)
 479  0135 2029          	jra	L751
 480  0137               L351:
 481                     ; 110     if (Buffer[i]<min)
 483  0137 58            	sllw	x
 484  0138 72fb07        	addw	x,(OFST+1,sp)
 485  013b fe            	ldw	x,(x)
 486  013c 1301          	cpw	x,(OFST-5,sp)
 487  013e 2409          	jruge	L361
 488                     ; 111       min = Buffer[i];
 490  0140 1e05          	ldw	x,(OFST-1,sp)
 491  0142 58            	sllw	x
 492  0143 72fb07        	addw	x,(OFST+1,sp)
 493  0146 fe            	ldw	x,(x)
 494  0147 1f01          	ldw	(OFST-5,sp),x
 495  0149               L361:
 496                     ; 112     if (Buffer[i]>max)
 498  0149 1e05          	ldw	x,(OFST-1,sp)
 499  014b 58            	sllw	x
 500  014c 72fb07        	addw	x,(OFST+1,sp)
 501  014f fe            	ldw	x,(x)
 502  0150 1303          	cpw	x,(OFST-3,sp)
 503  0152 2309          	jrule	L561
 504                     ; 113       max = Buffer[i];
 506  0154 1e05          	ldw	x,(OFST-1,sp)
 507  0156 58            	sllw	x
 508  0157 72fb07        	addw	x,(OFST+1,sp)
 509  015a fe            	ldw	x,(x)
 510  015b 1f03          	ldw	(OFST-3,sp),x
 511  015d               L561:
 512                     ; 108   for (i=0; i<buffersize; i++)
 514  015d 1e05          	ldw	x,(OFST-1,sp)
 515  015f 5c            	incw	x
 516  0160               L751:
 518  0160 1f05          	ldw	(OFST-1,sp),x
 521  0162 130b          	cpw	x,(OFST+5,sp)
 522  0164 25d1          	jrult	L351
 523                     ; 115   return(max-min);
 525  0166 1e03          	ldw	x,(OFST-3,sp)
 526  0168 72f001        	subw	x,(OFST-5,sp)
 529  016b 5b08          	addw	sp,#8
 530  016d 81            	ret	
 603                     ; 120 void TestADCDigitalFilter50Hz(void)
 603                     ; 121 {
 604                     	switch	.text
 605  016e               _TestADCDigitalFilter50Hz:
 607  016e 5224          	subw	sp,#36
 608       00000024      OFST:	set	36
 611                     ; 129   SetCPUClock(0); 
 613  0170 4f            	clr	a
 614  0171 cd0000        	call	_SetCPUClock
 616                     ; 132   if ((ADCBuffer = malloc(ADC_BUFFER_SIZE * sizeof(ADCBuffer[0]))) == NULL)
 618  0174 ae07d0        	ldw	x,#2000
 619  0177 cd0000        	call	_malloc
 621  017a 1f23          	ldw	(OFST-1,sp),x
 622  017c 2601          	jrne	L122
 623                     ; 133     _asm("trap\n");
 626  017e 83            	trap	
 628  017f               L122:
 629                     ; 136   ADCCollectDataFilt(ADCBuffer);
 631  017f 1e23          	ldw	x,(OFST-1,sp)
 632  0181 cd0000        	call	_ADCCollectDataFilt
 634                     ; 137   diffOrig = GetMinMaxFilt(&ADCBuffer[SAMPLES_PER_PERIOD], ADC_BUFFER_SIZE - SAMPLES_PER_PERIOD);
 636  0184 ae03de        	ldw	x,#990
 637  0187 89            	pushw	x
 638  0188 1e25          	ldw	x,(OFST+1,sp)
 639  018a 1c0014        	addw	x,#20
 640  018d ad9b          	call	_GetMinMaxFilt
 642  018f 5b02          	addw	sp,#2
 643  0191 1f01          	ldw	(OFST-35,sp),x
 644                     ; 140   Filter50Hz(ADCBuffer);
 646  0193 1e23          	ldw	x,(OFST-1,sp)
 647  0195 cd0073        	call	L74_Filter50Hz
 649                     ; 141   diffFilt = GetMinMaxFilt(&ADCBuffer[SAMPLES_PER_PERIOD], ADC_BUFFER_SIZE - SAMPLES_PER_PERIOD);    
 651  0198 ae03de        	ldw	x,#990
 652  019b 89            	pushw	x
 653  019c 1e25          	ldw	x,(OFST+1,sp)
 654  019e 1c0014        	addw	x,#20
 655  01a1 ad87          	call	_GetMinMaxFilt
 657  01a3 5b02          	addw	sp,#2
 658  01a5 1f03          	ldw	(OFST-33,sp),x
 659                     ; 143   sprintf(DEBUG_STRING, "Orig50Hz= %d", diffOrig);
 661  01a7 1e01          	ldw	x,(OFST-35,sp)
 662  01a9 89            	pushw	x
 663  01aa ae0011        	ldw	x,#L322
 664  01ad 89            	pushw	x
 665  01ae 96            	ldw	x,sp
 666  01af 1c0009        	addw	x,#OFST-27
 667  01b2 cd0000        	call	_sprintf
 669  01b5 5b04          	addw	sp,#4
 670                     ; 144   LCD_PrintString(LCD_LINE1, ENABLE, DISABLE, DEBUG_STRING);
 672  01b7 96            	ldw	x,sp
 673  01b8 1c0005        	addw	x,#OFST-31
 674  01bb 89            	pushw	x
 675  01bc 4b00          	push	#0
 676  01be ae0001        	ldw	x,#1
 677  01c1 a680          	ld	a,#128
 678  01c3 95            	ld	xh,a
 679  01c4 cd0000        	call	_LCD_PrintString
 681  01c7 5b03          	addw	sp,#3
 682                     ; 145   sprintf(DEBUG_STRING, "Filt50Hz= %d", diffFilt);
 684  01c9 1e03          	ldw	x,(OFST-33,sp)
 685  01cb 89            	pushw	x
 686  01cc ae0004        	ldw	x,#L522
 687  01cf 89            	pushw	x
 688  01d0 96            	ldw	x,sp
 689  01d1 1c0009        	addw	x,#OFST-27
 690  01d4 cd0000        	call	_sprintf
 692  01d7 5b04          	addw	sp,#4
 693                     ; 146   LCD_PrintString(LCD_LINE2, ENABLE, DISABLE, DEBUG_STRING);
 695  01d9 96            	ldw	x,sp
 696  01da 1c0005        	addw	x,#OFST-31
 697  01dd 89            	pushw	x
 698  01de 4b00          	push	#0
 699  01e0 ae0001        	ldw	x,#1
 700  01e3 a690          	ld	a,#144
 701  01e5 95            	ld	xh,a
 702  01e6 cd0000        	call	_LCD_PrintString
 704  01e9 5b03          	addw	sp,#3
 705                     ; 149   free(ADCBuffer);
 707  01eb 1e23          	ldw	x,(OFST-1,sp)
 708  01ed cd0000        	call	_free
 710                     ; 150 }//TestADCDigitalFilter50Hz
 713  01f0 5b24          	addw	sp,#36
 714  01f2 81            	ret	
 727                     	xdef	_TestADCDigitalFilter50Hz
 728                     	xdef	_GetMinMaxFilt
 729                     	xdef	_ADCCollectDataFilt
 730                     	xref	_LCD_PrintString
 731                     	xref	_SetCPUClock
 732                     	xref	_ADC2_ClearFlag
 733                     	xref	_ADC2_GetFlagStatus
 734                     	xref	_ADC2_GetConversionValue
 735                     	xref	_ADC2_ITConfig
 736                     	xref	_ADC2_Cmd
 737                     	xref	_ADC2_Init
 738                     	xref	_malloc
 739                     	xref	_free
 740                     	xref	_sprintf
 741                     	switch	.const
 742  0004               L522:
 743  0004 46696c743530  	dc.b	"Filt50Hz= %d",0
 744  0011               L322:
 745  0011 4f7269673530  	dc.b	"Orig50Hz= %d",0
 746                     	xref.b	c_lreg
 747                     	xref.b	c_x
 767                     	xref	c_ludv
 768                     	xref	c_lsub
 769                     	xref	c_ltor
 770                     	xref	c_lgadd
 771                     	xref	c_rtol
 772                     	xref	c_uitolx
 773                     	end
