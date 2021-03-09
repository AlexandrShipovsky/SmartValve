   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.6 - 08 Apr 2008
   3                     ; Optimizer V4.2.6 - 08 Apr 2008
 179                     ; 13 void InitADCTimerTrigger(PParam pparam, unsigned int divider)
 179                     ; 14 {
 181                     	switch	.text
 182  0000               _InitADCTimerTrigger:
 184  0000 89            	pushw	x
 185  0001 89            	pushw	x
 186       00000002      OFST:	set	2
 189                     ; 18     ADCpparam = pparam;
 191  0002 cf0000        	ldw	_ADCpparam,x
 192                     ; 19     ADCpparam->ConvNumber = 0;
 194  0005 905f          	clrw	y
 195  0007 ef0c          	ldw	(12,x),y
 196                     ; 20     ADCpparam->EndOfAllConversions = 1;
 198  0009 a601          	ld	a,#1
 199  000b e70b          	ld	(11,x),a
 200                     ; 22     CLK -> PCKENR1 |= CLK_PCKENR1_TIM1; //enable clock for timer 1
 202  000d 721e50c7      	bset	20679,#7
 203                     ; 23     TIM1->PSCRH = 0x00;  //prescaller to 0
 205  0011 725f5260      	clr	21088
 206                     ; 24     TIM1->PSCRL = 0x00;
 208  0015 725f5261      	clr	21089
 209                     ; 25     TIM1->ARRH  = divider >> 8;  //reload value
 211  0019 7b07          	ld	a,(OFST+5,sp)
 212  001b c75262        	ld	21090,a
 213                     ; 26     TIM1->ARRL  = divider;
 215  001e 7b08          	ld	a,(OFST+6,sp)
 216  0020 c75263        	ld	21091,a
 217                     ; 27     TIM1->CR2   = 0x20;  //TRGO enable on update event
 219  0023 35205251      	mov	21073,#32
 220                     ; 28     TIM1->CR1  |= TIM1_CR1_ARPE; //auto preload enable
 222  0027 721e5250      	bset	21072,#7
 223                     ; 29     TIM1->EGR  |= TIM1_EGR_UG;   //generate update event
 225                     ; 32     SchmittTriggers = ((unsigned int)1<<(ADCpparam->InputChannelCount)-1) << ADCpparam->StartInputChannel;
 227  002b 72105257      	bset	21079,#0
 228  002f 90ce0000      	ldw	y,_ADCpparam
 229  0033 ae0001        	ldw	x,#1
 230  0036 90e601        	ld	a,(1,y)
 231  0039 4a            	dec	a
 232  003a 2704          	jreq	L6
 233  003c               L01:
 234  003c 58            	sllw	x
 235  003d 4a            	dec	a
 236  003e 26fc          	jrne	L01
 237  0040               L6:
 238  0040 72c60000      	ld	a,[_ADCpparam.w]
 239  0044 2704          	jreq	L21
 240  0046               L41:
 241  0046 58            	sllw	x
 242  0047 4a            	dec	a
 243  0048 26fc          	jrne	L41
 244  004a               L21:
 245  004a 1f01          	ldw	(OFST-1,sp),x
 246                     ; 33     ADC2->TDRL = SchmittTriggers >> 8;
 248  004c 7b01          	ld	a,(OFST-1,sp)
 249  004e c75407        	ld	21511,a
 250                     ; 34     ADC2->TDRH = SchmittTriggers;
 252  0051 7b02          	ld	a,(OFST+0,sp)
 253  0053 c75406        	ld	21510,a
 254                     ; 37     ADC2_Init(ADC2_CONVERSIONMODE_SINGLE, ADC2_CHANNEL_12, ADC2_PRESSEL_FCPU_D6, ADC2_EXTTRIG_TIM, ENABLE, ADC2_ALIGN_RIGHT, ADC2_SCHMITTTRIG_CHANNEL12, DISABLE);
 256  0056 4b00          	push	#0
 257  0058 4b0c          	push	#12
 258  005a 4b08          	push	#8
 259  005c 4b01          	push	#1
 260  005e 4b00          	push	#0
 261  0060 4b30          	push	#48
 262  0062 ae000c        	ldw	x,#12
 263  0065 4f            	clr	a
 264  0066 95            	ld	xh,a
 265  0067 cd0000        	call	_ADC2_Init
 267  006a 5b06          	addw	sp,#6
 268                     ; 39     ADC2_ClearFlag();
 270  006c cd0000        	call	_ADC2_ClearFlag
 272                     ; 41     ADC2_ITConfig(ENABLE);
 274  006f a601          	ld	a,#1
 275  0071 cd0000        	call	_ADC2_ITConfig
 277                     ; 42     ADCpparam->EndOfAllConversions = 0;
 279  0074 ce0000        	ldw	x,_ADCpparam
 280                     ; 43 }
 283  0077 5b04          	addw	sp,#4
 284  0079 6f0b          	clr	(11,x)
 285  007b 81            	ret	
 309                     ; 46 void ADCStart(void)
 309                     ; 47 {
 310                     	switch	.text
 311  007c               _ADCStart:
 315                     ; 48   enableInterrupts();
 318  007c 9a            	rim	
 320                     ; 49   TIM1->CR1  |= TIM1_CR1_CEN;  //start timer - trigger
 323  007d 72105250      	bset	21072,#0
 324                     ; 50 }
 327  0081 81            	ret	
 363                     ; 53 @far @interrupt void ADCInterrupt (void)
 363                     ; 54 {
 365                     	switch	.text
 366  0082               f_ADCInterrupt:
 368       00000003      OFST:	set	3
 369  0082 3b0002        	push	c_x+2
 370  0085 be00          	ldw	x,c_x
 371  0087 89            	pushw	x
 372  0088 3b0002        	push	c_y+2
 373  008b be00          	ldw	x,c_y
 374  008d 89            	pushw	x
 375  008e 5203          	subw	sp,#3
 378                     ; 57     ADC2_ClearFlag(); //clear end of conversion bit
 380  0090 cd0000        	call	_ADC2_ClearFlag
 382                     ; 58     if (ADCpparam->EndOfAllConversions)
 384  0093 ce0000        	ldw	x,_ADCpparam
 385  0096 e60b          	ld	a,(11,x)
 386  0098 2704ac1e011e  	jrne	L331
 387                     ; 59       return;
 389                     ; 62     ADCpparam->AddrADCDataStart[ADCpparam->ConvNumber] = ADC2_GetConversionValue()<<5;
 391  009e cd0000        	call	_ADC2_GetConversionValue
 393  00a1 58            	sllw	x
 394  00a2 58            	sllw	x
 395  00a3 58            	sllw	x
 396  00a4 58            	sllw	x
 397  00a5 58            	sllw	x
 398  00a6 1f01          	ldw	(OFST-2,sp),x
 399  00a8 ce0000        	ldw	x,_ADCpparam
 400  00ab ee0c          	ldw	x,(12,x)
 401  00ad 90ce0000      	ldw	y,_ADCpparam
 402  00b1 58            	sllw	x
 403  00b2 90ee02        	ldw	y,(2,y)
 404  00b5 90bf00        	ldw	c_x,y
 405  00b8 72bb0000      	addw	x,c_x
 406  00bc 1601          	ldw	y,(OFST-2,sp)
 407  00be ff            	ldw	(x),y
 408                     ; 63     ADCpparam->ConvNumber++; //increment counter
 410  00bf ce0000        	ldw	x,_ADCpparam
 411  00c2 9093          	ldw	y,x
 412  00c4 ee0c          	ldw	x,(12,x)
 413  00c6 5c            	incw	x
 414  00c7 90ef0c        	ldw	(12,y),x
 415                     ; 66     channel = (ADC2->CSR & ADC2_CHANNEL_15);
 417  00ca c65400        	ld	a,21504
 418  00cd a40f          	and	a,#15
 419  00cf 6b03          	ld	(OFST+0,sp),a
 420                     ; 67     if (channel == (ADCpparam->StartInputChannel + ADCpparam->InputChannelCount -1))
 422  00d1 ce0000        	ldw	x,_ADCpparam
 423  00d4 e601          	ld	a,(1,x)
 424  00d6 5f            	clrw	x
 425  00d7 72cb0000      	add	a,[_ADCpparam.w]
 426  00db 59            	rlcw	x
 427  00dc 02            	rlwa	x,a
 428  00dd 5a            	decw	x
 429  00de 7b03          	ld	a,(OFST+0,sp)
 430  00e0 905f          	clrw	y
 431  00e2 9097          	ld	yl,a
 432  00e4 90bf01        	ldw	c_y+1,y
 433  00e7 b301          	cpw	x,c_y+1
 434  00e9 260b          	jrne	L721
 435                     ; 68       ADC2->CSR = (ADC2->CSR & ~ADC2_CHANNEL_15) | ADCpparam->StartInputChannel;
 437  00eb c65400        	ld	a,21504
 438  00ee a4f0          	and	a,#240
 439  00f0 72ca0000      	or	a,[_ADCpparam.w]
 441  00f4 200a          	jra	L131
 442  00f6               L721:
 443                     ; 70       ADC2->CSR = (ADC2->CSR & ~ADC2_CHANNEL_15) | (channel+1);
 445  00f6 4c            	inc	a
 446  00f7 6b02          	ld	(OFST-1,sp),a
 447  00f9 c65400        	ld	a,21504
 448  00fc a4f0          	and	a,#240
 449  00fe 1a02          	or	a,(OFST-1,sp)
 450  0100               L131:
 451  0100 c75400        	ld	21504,a
 452                     ; 73     if (ADCpparam->ConvNumber == ADCpparam->NumOfConversions)
 454  0103 ce0000        	ldw	x,_ADCpparam
 455  0106 9093          	ldw	y,x
 456  0108 ee0c          	ldw	x,(12,x)
 457  010a 90e309        	cpw	x,(9,y)
 458  010d 260f          	jrne	L331
 459                     ; 75       ADC2_Cmd(DISABLE);             //switch off ADC
 461  010f 4f            	clr	a
 462  0110 cd0000        	call	_ADC2_Cmd
 464                     ; 76       TIM1->CR1  &= ~TIM1_CR1_CEN;  //stop timer - trigger
 466  0113 72115250      	bres	21072,#0
 467                     ; 77       ADCpparam->EndOfAllConversions = 1; //signalize end of conversions
 469  0117 ce0000        	ldw	x,_ADCpparam
 470  011a a601          	ld	a,#1
 471  011c e70b          	ld	(11,x),a
 472  011e               L331:
 473                     ; 79   return;
 476  011e 5b03          	addw	sp,#3
 477  0120 85            	popw	x
 478  0121 bf00          	ldw	c_y,x
 479  0123 320002        	pop	c_y+2
 480  0126 85            	popw	x
 481  0127 bf00          	ldw	c_x,x
 482  0129 320002        	pop	c_x+2
 483  012c 80            	iret	
 509                     	xdef	f_ADCInterrupt
 510                     	xdef	_ADCStart
 511                     	xdef	_InitADCTimerTrigger
 512                     	switch	.bss
 513  0000               _ADCpparam:
 514  0000 0000          	ds.b	2
 515                     	xdef	_ADCpparam
 516                     	xref	_ADC2_ClearFlag
 517                     	xref	_ADC2_GetConversionValue
 518                     	xref	_ADC2_ITConfig
 519                     	xref	_ADC2_Cmd
 520                     	xref	_ADC2_Init
 521                     	xref.b	c_x
 522                     	xref.b	c_y
 542                     	end
