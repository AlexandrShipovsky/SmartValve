   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.6 - 08 Apr 2008
   3                     ; Optimizer V4.2.6 - 08 Apr 2008
  42                     ; 14 static void delay(unsigned long cycles)
  42                     ; 15 {
  44                     	switch	.text
  45  0000               L3_delay:
  47       00000000      OFST:	set	0
  50  0000               L13:
  51                     ; 16   while (cycles--);
  53  0000 96            	ldw	x,sp
  54  0001 1c0003        	addw	x,#OFST+3
  55  0004 cd0000        	call	c_ltor
  57  0007 96            	ldw	x,sp
  58  0008 1c0003        	addw	x,#OFST+3
  59  000b a601          	ld	a,#1
  60  000d cd0000        	call	c_lgsbc
  62  0010 cd0000        	call	c_lrzmp
  64  0013 26eb          	jrne	L13
  65                     ; 17 }
  68  0015 81            	ret	
  94                     ; 21 static void Init_SPI(void)
  94                     ; 22 {
  95                     	switch	.text
  96  0016               L53_Init_SPI:
 100                     ; 23   SPI_DeInit();
 102  0016 cd0000        	call	_SPI_DeInit
 104                     ; 24   SPI_Init(SPI_FIRSTBIT_MSB, SPI_BAUDRATEPRESCALER_64, SPI_MODE_MASTER, SPI_CLOCKPOLARITY_HIGH, SPI_CLOCKPHASE_2EDGE, SPI_DATADIRECTION_2LINES_FULLDUPLEX, ENABLE, 0);
 106  0019 4b00          	push	#0
 107  001b 4b01          	push	#1
 108  001d 4b00          	push	#0
 109  001f 4b01          	push	#1
 110  0021 4b02          	push	#2
 111  0023 4b04          	push	#4
 112  0025 ae0028        	ldw	x,#40
 113  0028 4f            	clr	a
 114  0029 95            	ld	xh,a
 115  002a cd0000        	call	_SPI_Init
 117  002d 5b06          	addw	sp,#6
 118                     ; 25   SPI_Cmd(ENABLE);
 120  002f a601          	ld	a,#1
 122                     ; 26 }
 125  0031 cc0000        	jp	_SPI_Cmd
 165                     ; 36 void main(void)
 165                     ; 37 {
 166                     	switch	.text
 167  0034               _main:
 171                     ; 39   Init_SPI();
 173  0034 ade0          	call	L53_Init_SPI
 175                     ; 40   LCD_Init();
 177  0036 cd0000        	call	_LCD_Init
 179                     ; 41   LCD_Backlight(ENABLE);
 181  0039 a601          	ld	a,#1
 182  003b cd0000        	call	_LCD_Backlight
 184                     ; 43   LCD_Clear();
 186  003e cd0000        	call	_LCD_Clear
 188                     ; 44   LCD_PrintString(LCD_LINE1, ENABLE, DISABLE, " AN2719  demo ");  
 190  0041 ae00d2        	ldw	x,#L75
 191  0044 89            	pushw	x
 192  0045 4b00          	push	#0
 193  0047 ae0001        	ldw	x,#1
 194  004a a680          	ld	a,#128
 195  004c 95            	ld	xh,a
 196  004d cd0000        	call	_LCD_PrintString
 198  0050 5b03          	addw	sp,#3
 199                     ; 45   LCD_RollString(LCD_LINE2, "              Please connect 16MHz XTALL  and signal source to BNC AIN12 input!", 80);  
 201  0052 ae0050        	ldw	x,#80
 202  0055 89            	pushw	x
 203  0056 ae0082        	ldw	x,#L16
 204  0059 89            	pushw	x
 205  005a a690          	ld	a,#144
 206  005c cd0000        	call	_LCD_RollString
 208  005f 5b04          	addw	sp,#4
 209                     ; 46   LCD_PrintString(LCD_LINE2, ENABLE, DISABLE, "press Joystick");  
 211  0061 ae0073        	ldw	x,#L36
 212  0064 89            	pushw	x
 213  0065 4b00          	push	#0
 214  0067 ae0001        	ldw	x,#1
 215  006a a690          	ld	a,#144
 216  006c 95            	ld	xh,a
 217  006d cd0000        	call	_LCD_PrintString
 219  0070 5b03          	addw	sp,#3
 221  0072               L76:
 222                     ; 47   while(KEY_BUTTON_UP);
 224  0072 720e5010fb    	btjt	20496,#7,L76
 225                     ; 50   SetCPUClock(1); //XTALL - must be present 16MHz  
 227  0077 a601          	ld	a,#1
 228  0079 cd0000        	call	_SetCPUClock
 230  007c               L37:
 231                     ; 56     LCD_Clear();
 233  007c cd0000        	call	_LCD_Clear
 235                     ; 57     LCD_PrintString(LCD_LINE1, ENABLE, DISABLE, "Precision demo");  
 237  007f ae0064        	ldw	x,#L77
 238  0082 89            	pushw	x
 239  0083 4b00          	push	#0
 240  0085 ae0001        	ldw	x,#1
 241  0088 a680          	ld	a,#128
 242  008a 95            	ld	xh,a
 243  008b cd0000        	call	_LCD_PrintString
 245  008e 5b03          	addw	sp,#3
 246                     ; 58     LCD_PrintString(LCD_LINE2, ENABLE, DISABLE, "    AN2719    ");  
 248  0090 ae0055        	ldw	x,#L101
 249  0093 89            	pushw	x
 250  0094 4b00          	push	#0
 251  0096 ae0001        	ldw	x,#1
 252  0099 a690          	ld	a,#144
 253  009b 95            	ld	xh,a
 254  009c cd0000        	call	_LCD_PrintString
 256  009f 5b03          	addw	sp,#3
 257                     ; 59     delay(DELAY_BUTTON);
 259  00a1 aea120        	ldw	x,#41248
 260  00a4 89            	pushw	x
 261  00a5 ae0007        	ldw	x,#7
 262  00a8 89            	pushw	x
 263  00a9 cd0000        	call	L3_delay
 265  00ac 5b04          	addw	sp,#4
 266                     ; 63     LCD_Clear();
 268  00ae cd0000        	call	_LCD_Clear
 270                     ; 64     LCD_PrintString(LCD_LINE1, ENABLE, DISABLE, "Averaging");
 272  00b1 ae004b        	ldw	x,#L301
 273  00b4 89            	pushw	x
 274  00b5 4b00          	push	#0
 275  00b7 ae0001        	ldw	x,#1
 276  00ba a680          	ld	a,#128
 277  00bc 95            	ld	xh,a
 278  00bd cd0000        	call	_LCD_PrintString
 280  00c0 5b03          	addw	sp,#3
 281                     ; 65     delay(DELAY_BUTTON);
 283  00c2 aea120        	ldw	x,#41248
 284  00c5 89            	pushw	x
 285  00c6 ae0007        	ldw	x,#7
 286  00c9 89            	pushw	x
 287  00ca cd0000        	call	L3_delay
 289  00cd 5b04          	addw	sp,#4
 290  00cf               L501:
 291                     ; 68       TestADCAveraging();
 293  00cf cd0000        	call	_TestADCAveraging
 295                     ; 70     while(KEY_BUTTON_UP);
 297  00d2 720e5010f8    	btjt	20496,#7,L501
 298                     ; 74     LCD_Clear();
 300  00d7 cd0000        	call	_LCD_Clear
 302                     ; 75     LCD_PrintString(LCD_LINE1, ENABLE, DISABLE, "WhiteNoise");
 304  00da ae0040        	ldw	x,#L311
 305  00dd 89            	pushw	x
 306  00de 4b00          	push	#0
 307  00e0 ae0001        	ldw	x,#1
 308  00e3 a680          	ld	a,#128
 309  00e5 95            	ld	xh,a
 310  00e6 cd0000        	call	_LCD_PrintString
 312  00e9 5b03          	addw	sp,#3
 313                     ; 76     delay(DELAY_BUTTON);
 315  00eb aea120        	ldw	x,#41248
 316  00ee 89            	pushw	x
 317  00ef ae0007        	ldw	x,#7
 318  00f2 89            	pushw	x
 319  00f3 cd0000        	call	L3_delay
 321  00f6 5b04          	addw	sp,#4
 322  00f8               L511:
 323                     ; 79       TestADCWhiteNoise();
 325  00f8 cd0000        	call	_TestADCWhiteNoise
 327                     ; 81     while(KEY_BUTTON_UP);
 329  00fb 720e5010f8    	btjt	20496,#7,L511
 330                     ; 85     LCD_Clear();
 332  0100 cd0000        	call	_LCD_Clear
 334                     ; 86     LCD_PrintString(LCD_LINE1, ENABLE, DISABLE, "Filter50Hz");
 336  0103 ae0035        	ldw	x,#L321
 337  0106 89            	pushw	x
 338  0107 4b00          	push	#0
 339  0109 ae0001        	ldw	x,#1
 340  010c a680          	ld	a,#128
 341  010e 95            	ld	xh,a
 342  010f cd0000        	call	_LCD_PrintString
 344  0112 5b03          	addw	sp,#3
 345                     ; 87     delay(DELAY_BUTTON);
 347  0114 aea120        	ldw	x,#41248
 348  0117 89            	pushw	x
 349  0118 ae0007        	ldw	x,#7
 350  011b 89            	pushw	x
 351  011c cd0000        	call	L3_delay
 353  011f 5b04          	addw	sp,#4
 354  0121               L521:
 355                     ; 90       TestADCDigitalFilter50Hz();
 357  0121 cd0000        	call	_TestADCDigitalFilter50Hz
 359                     ; 92     while(KEY_BUTTON_UP);
 361  0124 720e5010f8    	btjt	20496,#7,L521
 362                     ; 97     LCD_Clear();
 364  0129 cd0000        	call	_LCD_Clear
 366                     ; 98     LCD_PrintString(LCD_LINE1, ENABLE, DISABLE, "FFT 32 points");
 368  012c ae0027        	ldw	x,#L331
 369  012f 89            	pushw	x
 370  0130 4b00          	push	#0
 371  0132 ae0001        	ldw	x,#1
 372  0135 a680          	ld	a,#128
 373  0137 95            	ld	xh,a
 374  0138 cd0000        	call	_LCD_PrintString
 376  013b 5b03          	addw	sp,#3
 377                     ; 99     LCD_PrintString(LCD_LINE2, ENABLE, DISABLE, "see debug data");
 379  013d ae0018        	ldw	x,#L531
 380  0140 89            	pushw	x
 381  0141 4b00          	push	#0
 382  0143 ae0001        	ldw	x,#1
 383  0146 a690          	ld	a,#144
 384  0148 95            	ld	xh,a
 385  0149 cd0000        	call	_LCD_PrintString
 387  014c 5b03          	addw	sp,#3
 388                     ; 100     delay(DELAY_BUTTON);  
 390  014e aea120        	ldw	x,#41248
 391  0151 89            	pushw	x
 392  0152 ae0007        	ldw	x,#7
 393  0155 89            	pushw	x
 394  0156 cd0000        	call	L3_delay
 396  0159 5b04          	addw	sp,#4
 397  015b               L731:
 398                     ; 104       TestADCFFT();
 400  015b cd0000        	call	_TestADCFFT
 402                     ; 106     while(KEY_BUTTON_UP);
 404  015e 720e5010f8    	btjt	20496,#7,L731
 405                     ; 113     LCD_Clear();
 407  0163 cd0000        	call	_LCD_Clear
 409                     ; 114     LCD_PrintString(LCD_LINE1, ENABLE, DISABLE, "Calibration");
 411  0166 ae000c        	ldw	x,#L541
 412  0169 89            	pushw	x
 413  016a 4b00          	push	#0
 414  016c ae0001        	ldw	x,#1
 415  016f a680          	ld	a,#128
 416  0171 95            	ld	xh,a
 417  0172 cd0000        	call	_LCD_PrintString
 419  0175 5b03          	addw	sp,#3
 420                     ; 115     delay(DELAY_BUTTON);  
 422  0177 aea120        	ldw	x,#41248
 423  017a 89            	pushw	x
 424  017b ae0007        	ldw	x,#7
 425  017e 89            	pushw	x
 426  017f cd0000        	call	L3_delay
 428  0182 5b04          	addw	sp,#4
 429  0184               L741:
 430                     ; 118       TestADCCalibration();  
 432  0184 cd0000        	call	_TestADCCalibration
 434                     ; 120     while(KEY_BUTTON_UP);
 436  0187 720e5010f8    	btjt	20496,#7,L741
 437                     ; 124     LCD_Clear();
 439  018c cd0000        	call	_LCD_Clear
 441                     ; 125     LCD_PrintString(LCD_LINE1, ENABLE, DISABLE, "End of demo");
 443  018f ae0000        	ldw	x,#L551
 444  0192 89            	pushw	x
 445  0193 4b00          	push	#0
 446  0195 ae0001        	ldw	x,#1
 447  0198 a680          	ld	a,#128
 448  019a 95            	ld	xh,a
 449  019b cd0000        	call	_LCD_PrintString
 451  019e 5b03          	addw	sp,#3
 452                     ; 126     delay(DELAY_BUTTON);  
 454  01a0 aea120        	ldw	x,#41248
 455  01a3 89            	pushw	x
 456  01a4 ae0007        	ldw	x,#7
 457  01a7 89            	pushw	x
 458  01a8 cd0000        	call	L3_delay
 460  01ab 5b04          	addw	sp,#4
 462  01ad cc007c        	jra	L37
 484                     	xdef	_main
 485                     	xref	_SetCPUClock
 486                     	xref	_TestADCCalibration
 487                     	xref	_TestADCFFT
 488                     	xref	_TestADCDigitalFilter50Hz
 489                     	xref	_TestADCWhiteNoise
 490                     	xref	_TestADCAveraging
 491                     	xref	_LCD_RollString
 492                     	xref	_LCD_PrintString
 493                     	xref	_LCD_Clear
 494                     	xref	_LCD_Init
 495                     	xref	_LCD_Backlight
 496                     	xref	_SPI_Cmd
 497                     	xref	_SPI_Init
 498                     	xref	_SPI_DeInit
 499                     .const:	section	.text
 500  0000               L551:
 501  0000 456e64206f66  	dc.b	"End of demo",0
 502  000c               L541:
 503  000c 43616c696272  	dc.b	"Calibration",0
 504  0018               L531:
 505  0018 736565206465  	dc.b	"see debug data",0
 506  0027               L331:
 507  0027 464654203332  	dc.b	"FFT 32 points",0
 508  0035               L321:
 509  0035 46696c746572  	dc.b	"Filter50Hz",0
 510  0040               L311:
 511  0040 57686974654e  	dc.b	"WhiteNoise",0
 512  004b               L301:
 513  004b 417665726167  	dc.b	"Averaging",0
 514  0055               L101:
 515  0055 20202020414e  	dc.b	"    AN2719    ",0
 516  0064               L77:
 517  0064 507265636973  	dc.b	"Precision demo",0
 518  0073               L36:
 519  0073 707265737320  	dc.b	"press Joystick",0
 520  0082               L16:
 521  0082 202020202020  	dc.b	"              Plea"
 522  0094 736520636f6e  	dc.b	"se connect 16MHz X"
 523  00a6 54414c4c2020  	dc.b	"TALL  and signal s"
 524  00b8 6f7572636520  	dc.b	"ource to BNC AIN12"
 525  00ca 20696e707574  	dc.b	" input!",0
 526  00d2               L75:
 527  00d2 20414e323731  	dc.b	" AN2719  demo ",0
 547                     	xref	c_lrzmp
 548                     	xref	c_lgsbc
 549                     	xref	c_ltor
 550                     	end
