   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.6 - 08 Apr 2008
   3                     ; Optimizer V4.2.6 - 08 Apr 2008
   5                     .const:	section	.text
   6  0000               _S_CGRAM:
   7  0000 03            	dc.b	3
   8  0001 ff            	dc.b	255
   9  0002 02            	dc.b	2
  10  0003 00            	dc.b	0
  11  0004 04            	dc.b	4
  12  0005 00            	dc.b	0
  13  0006 04            	dc.b	4
  14  0007 00            	dc.b	0
  15  0008 0c            	dc.b	12
  16  0009 7f            	dc.b	127
  17  000a 0c            	dc.b	12
  18  000b 7f            	dc.b	127
  19  000c 1c            	dc.b	28
  20  000d 3f            	dc.b	63
  21  000e 1e            	dc.b	30
  22  000f 1f            	dc.b	31
  23  0010 3f            	dc.b	63
  24  0011 0f            	dc.b	15
  25  0012 3f            	dc.b	63
  26  0013 87            	dc.b	135
  27  0014 7f            	dc.b	127
  28  0015 c3            	dc.b	195
  29  0016 7f            	dc.b	127
  30  0017 e3            	dc.b	227
  31  0018 00            	dc.b	0
  32  0019 03            	dc.b	3
  33  001a 00            	dc.b	0
  34  001b 03            	dc.b	3
  35  001c 00            	dc.b	0
  36  001d 07            	dc.b	7
  37  001e ff            	dc.b	255
  38  001f fe            	dc.b	254
  39  0020               _T_CGRAM:
  40  0020 ff            	dc.b	255
  41  0021 ff            	dc.b	255
  42  0022 00            	dc.b	0
  43  0023 00            	dc.b	0
  44  0024 00            	dc.b	0
  45  0025 00            	dc.b	0
  46  0026 00            	dc.b	0
  47  0027 00            	dc.b	0
  48  0028 f8            	dc.b	248
  49  0029 f8            	dc.b	248
  50  002a f0            	dc.b	240
  51  002b f8            	dc.b	248
  52  002c f0            	dc.b	240
  53  002d f0            	dc.b	240
  54  002e f0            	dc.b	240
  55  002f f0            	dc.b	240
  56  0030 e1            	dc.b	225
  57  0031 e0            	dc.b	224
  58  0032 e3            	dc.b	227
  59  0033 e0            	dc.b	224
  60  0034 c3            	dc.b	195
  61  0035 c0            	dc.b	192
  62  0036 c7            	dc.b	199
  63  0037 c0            	dc.b	192
  64  0038 87            	dc.b	135
  65  0039 c0            	dc.b	192
  66  003a 8f            	dc.b	143
  67  003b 80            	dc.b	128
  68  003c 0f            	dc.b	15
  69  003d 80            	dc.b	128
  70  003e 1f            	dc.b	31
  71  003f 00            	dc.b	0
 109                     ; 54 void LCD_Delay(u16 nCount)
 109                     ; 55 {
 111                     	switch	.text
 112  0000               _LCD_Delay:
 114  0000 89            	pushw	x
 115       00000000      OFST:	set	0
 118  0001 2003          	jra	L72
 119  0003               L52:
 120                     ; 59     nCount--;
 122  0003 5a            	decw	x
 123  0004 1f01          	ldw	(OFST+1,sp),x
 124  0006               L72:
 125                     ; 57   while (nCount != 0)
 127  0006 1e01          	ldw	x,(OFST+1,sp)
 128  0008 26f9          	jrne	L52
 129                     ; 61 }
 132  000a 85            	popw	x
 133  000b 81            	ret	
 165                     ; 64 static u8 LCD_SPISendByte(u8 DataToSend)
 165                     ; 65 {
 166                     	switch	.text
 167  000c               L33_LCD_SPISendByte:
 171                     ; 68   SPI->DR = DataToSend;
 173  000c c75204        	ld	20996,a
 175  000f               L55:
 176                     ; 70   while ((SPI->SR & SPI_SR_TXE) == 0)
 178  000f 72035203fb    	btjf	20995,#1,L55
 180  0014               L36:
 181                     ; 75   while ((SPI->SR & SPI_SR_RXNE) == 0)
 183  0014 72015203fb    	btjf	20995,#0,L36
 184                     ; 81   return SPI->DR;
 186  0019 c65204        	ld	a,20996
 189  001c 81            	ret	
 246                     ; 86 void LCD_ChipSelect(FunctionalState NewState)
 246                     ; 87 {
 247                     	switch	.text
 248  001d               _LCD_ChipSelect:
 252                     ; 88   if (NewState == DISABLE)
 254  001d 4d            	tnz	a
 255  001e 260a          	jrne	L511
 256                     ; 90     GPIO_WriteLow(LCD_CS_PORT, LCD_CS_PIN); /* CS pin low: LCD disabled */
 258  0020 4b01          	push	#1
 259  0022 ae5019        	ldw	x,#20505
 260  0025 cd0000        	call	_GPIO_WriteLow
 263  0028 2008          	jra	L711
 264  002a               L511:
 265                     ; 94     GPIO_WriteHigh(LCD_CS_PORT, LCD_CS_PIN); /* CS pin high: LCD enabled */
 267  002a 4b01          	push	#1
 268  002c ae5019        	ldw	x,#20505
 269  002f cd0000        	call	_GPIO_WriteHigh
 271  0032               L711:
 272  0032 84            	pop	a
 273                     ; 96 }
 276  0033 81            	ret	
 313                     ; 99 void LCD_Backlight(FunctionalState NewState)
 313                     ; 100 {
 314                     	switch	.text
 315  0034               _LCD_Backlight:
 319                     ; 101   if (NewState == DISABLE)
 321  0034 4d            	tnz	a
 322  0035 260a          	jrne	L731
 323                     ; 103     GPIO_WriteLow(LCD_BACKLIGHT_PORT, LCD_BACKLIGHT_PIN);
 325  0037 4b10          	push	#16
 326  0039 ae5023        	ldw	x,#20515
 327  003c cd0000        	call	_GPIO_WriteLow
 330  003f 2008          	jra	L141
 331  0041               L731:
 332                     ; 107     GPIO_WriteHigh(LCD_BACKLIGHT_PORT, LCD_BACKLIGHT_PIN);
 334  0041 4b10          	push	#16
 335  0043 ae5023        	ldw	x,#20515
 336  0046 cd0000        	call	_GPIO_WriteHigh
 338  0049               L141:
 339  0049 84            	pop	a
 340                     ; 109 }
 343  004a 81            	ret	
 384                     ; 112 void LCD_SendByte(u8 DataType, u8 DataToSend)
 384                     ; 113 {
 385                     	switch	.text
 386  004b               _LCD_SendByte:
 388  004b 89            	pushw	x
 389       00000000      OFST:	set	0
 392                     ; 115   LCD_ChipSelect(ENABLE); /* Enable access to LCD */
 394  004c a601          	ld	a,#1
 395  004e adcd          	call	_LCD_ChipSelect
 397                     ; 117   LCD_SPISendByte(DataType); /* Send Synchro/Mode byte */
 399  0050 7b01          	ld	a,(OFST+1,sp)
 400  0052 adb8          	call	L33_LCD_SPISendByte
 402                     ; 118   LCD_SPISendByte((u8)(DataToSend & (u8)0xF0)); /* Send byte high nibble */
 404  0054 7b02          	ld	a,(OFST+2,sp)
 405  0056 a4f0          	and	a,#240
 406  0058 adb2          	call	L33_LCD_SPISendByte
 408                     ; 119   LCD_SPISendByte((u8)((u8)(DataToSend << 4) & (u8)0xF0)); /* Send byte low nibble */
 410  005a 7b02          	ld	a,(OFST+2,sp)
 411  005c 97            	ld	xl,a
 412  005d a610          	ld	a,#16
 413  005f 42            	mul	x,a
 414  0060 9f            	ld	a,xl
 415  0061 a4f0          	and	a,#240
 416  0063 ada7          	call	L33_LCD_SPISendByte
 418                     ; 121   LCD_ChipSelect(DISABLE); /* Disable access to LCD */
 420  0065 4f            	clr	a
 421  0066 adb5          	call	_LCD_ChipSelect
 423                     ; 123 }
 426  0068 85            	popw	x
 427  0069 81            	ret	
 481                     ; 126 void LCD_SendBuffer(u8 *pTxBuffer, u8 *pRxBuffer, u8 NumByte)
 481                     ; 127 {
 482                     	switch	.text
 483  006a               _LCD_SendBuffer:
 485  006a 89            	pushw	x
 486       00000000      OFST:	set	0
 489                     ; 128   LCD_ChipSelect(ENABLE);
 491  006b a601          	ld	a,#1
 492  006d adae          	call	_LCD_ChipSelect
 495  006f 2012          	jra	L702
 496  0071               L502:
 497                     ; 131     *pRxBuffer = LCD_SPISendByte(*pTxBuffer);
 499  0071 1e01          	ldw	x,(OFST+1,sp)
 500  0073 f6            	ld	a,(x)
 501  0074 ad96          	call	L33_LCD_SPISendByte
 503  0076 1e05          	ldw	x,(OFST+5,sp)
 504  0078 f7            	ld	(x),a
 505                     ; 132     pTxBuffer++;
 507  0079 1e01          	ldw	x,(OFST+1,sp)
 508  007b 5c            	incw	x
 509  007c 1f01          	ldw	(OFST+1,sp),x
 510                     ; 133     pRxBuffer++;
 512  007e 1e05          	ldw	x,(OFST+5,sp)
 513  0080 5c            	incw	x
 514  0081 1f05          	ldw	(OFST+5,sp),x
 515  0083               L702:
 516                     ; 129   while (NumByte--) /* while there is data to be read */
 518  0083 7b07          	ld	a,(OFST+7,sp)
 519  0085 0a07          	dec	(OFST+7,sp)
 520  0087 4d            	tnz	a
 521  0088 26e7          	jrne	L502
 522                     ; 135   LCD_ChipSelect(DISABLE);
 524  008a ad91          	call	_LCD_ChipSelect
 526                     ; 136 }
 529  008c 85            	popw	x
 530  008d 81            	ret	
 556                     ; 139 void LCD_Init(void)
 556                     ; 140 {
 557                     	switch	.text
 558  008e               _LCD_Init:
 562                     ; 142   GPIO_Init(LCD_CS_PORT, LCD_CS_PIN, GPIO_MODE_OUT_PP_LOW_FAST);
 564  008e 4bc0          	push	#192
 565  0090 4b01          	push	#1
 566  0092 ae5019        	ldw	x,#20505
 567  0095 cd0000        	call	_GPIO_Init
 569  0098 85            	popw	x
 570                     ; 145   GPIO_Init(LCD_BACKLIGHT_PORT, LCD_BACKLIGHT_PIN, GPIO_MODE_OUT_PP_LOW_FAST);
 572  0099 4bc0          	push	#192
 573  009b 4b10          	push	#16
 574  009d ae5023        	ldw	x,#20515
 575  00a0 cd0000        	call	_GPIO_Init
 577  00a3 85            	popw	x
 578                     ; 147   LCD_SendByte(COMMAND_TYPE, SET_TEXT_MODE); /* Set the LCD in TEXT mode */
 580  00a4 ae0030        	ldw	x,#48
 581  00a7 a6f8          	ld	a,#248
 582  00a9 95            	ld	xh,a
 583  00aa ad9f          	call	_LCD_SendByte
 585                     ; 148   LCD_SendByte(COMMAND_TYPE, DISPLAY_ON); /* Enable the display */
 587  00ac ae000c        	ldw	x,#12
 588  00af a6f8          	ld	a,#248
 589  00b1 95            	ld	xh,a
 590  00b2 ad97          	call	_LCD_SendByte
 592                     ; 149   LCD_Clear(); /* Clear the LCD */
 594  00b4 ad08          	call	_LCD_Clear
 596                     ; 150   LCD_SendByte(COMMAND_TYPE, ENTRY_MODE_SET_INC); /* Select the entry mode type */
 598  00b6 ae0006        	ldw	x,#6
 599  00b9 a6f8          	ld	a,#248
 600  00bb 95            	ld	xh,a
 602                     ; 152 }
 605  00bc 208d          	jp	_LCD_SendByte
 638                     ; 155 void LCD_Clear(void)
 638                     ; 156 {
 639                     	switch	.text
 640  00be               _LCD_Clear:
 642  00be 89            	pushw	x
 643       00000002      OFST:	set	2
 646                     ; 159   LCD_SendByte(COMMAND_TYPE, DISPLAY_CLR); /* Clear the LCD */
 648  00bf ae0001        	ldw	x,#1
 649  00c2 a6f8          	ld	a,#248
 650  00c4 95            	ld	xh,a
 651  00c5 ad84          	call	_LCD_SendByte
 653                     ; 161   for (i = 0; i < 5000; i++)
 655  00c7 5f            	clrw	x
 656  00c8               L732:
 659  00c8 5c            	incw	x
 662  00c9 a31388        	cpw	x,#5000
 663  00cc 25fa          	jrult	L732
 664                     ; 164 }
 667  00ce 85            	popw	x
 668  00cf 81            	ret	
 693                     ; 167 void LCD_SetTextMode(void)
 693                     ; 168 {
 694                     	switch	.text
 695  00d0               _LCD_SetTextMode:
 699                     ; 169   LCD_SendByte(COMMAND_TYPE, SET_TEXT_MODE);
 701  00d0 ae0030        	ldw	x,#48
 702  00d3 a6f8          	ld	a,#248
 703  00d5 95            	ld	xh,a
 704  00d6 cd004b        	call	_LCD_SendByte
 706                     ; 170   LCD_Clear();
 709                     ; 171 }
 712  00d9 20e3          	jp	_LCD_Clear
 737                     ; 174 void LCD_SetGraphicMode(void)
 737                     ; 175 {
 738                     	switch	.text
 739  00db               _LCD_SetGraphicMode:
 743                     ; 176   LCD_Clear();
 745  00db ade1          	call	_LCD_Clear
 747                     ; 177   LCD_SendByte(COMMAND_TYPE, SET_GRAPHIC_MODE);
 749  00dd ae0036        	ldw	x,#54
 750  00e0 a6f8          	ld	a,#248
 751  00e2 95            	ld	xh,a
 753                     ; 179 }
 756  00e3 cc004b        	jp	_LCD_SendByte
 796                     ; 182 void LCD_ClearLine(u8 Line)
 796                     ; 183 {
 797                     	switch	.text
 798  00e6               _LCD_ClearLine:
 800  00e6 88            	push	a
 801       00000001      OFST:	set	1
 804                     ; 187   LCD_SendByte(COMMAND_TYPE, Line);
 806  00e7 97            	ld	xl,a
 807  00e8 a6f8          	ld	a,#248
 808  00ea 95            	ld	xh,a
 809  00eb cd004b        	call	_LCD_SendByte
 811                     ; 190   for (CharPos = 0; CharPos < LCD_LINE_MAX_CHAR; CharPos++)
 813  00ee 0f01          	clr	(OFST+0,sp)
 814  00f0               L303:
 815                     ; 192     LCD_SendByte(DATA_TYPE, ' ');
 817  00f0 ae0020        	ldw	x,#32
 818  00f3 a6fa          	ld	a,#250
 819  00f5 95            	ld	xh,a
 820  00f6 cd004b        	call	_LCD_SendByte
 822                     ; 190   for (CharPos = 0; CharPos < LCD_LINE_MAX_CHAR; CharPos++)
 824  00f9 0c01          	inc	(OFST+0,sp)
 827  00fb 7b01          	ld	a,(OFST+0,sp)
 828  00fd a10f          	cp	a,#15
 829  00ff 25ef          	jrult	L303
 830                     ; 194 }
 833  0101 84            	pop	a
 834  0102 81            	ret	
 874                     ; 197 void LCD_SetCursorPos(u8 Line, u8 Offset)
 874                     ; 198 {
 875                     	switch	.text
 876  0103               _LCD_SetCursorPos:
 878  0103 89            	pushw	x
 879       00000000      OFST:	set	0
 882                     ; 199   LCD_SendByte(COMMAND_TYPE, (u8)(Line + Offset));
 884  0104 9e            	ld	a,xh
 885  0105 1b02          	add	a,(OFST+2,sp)
 886  0107 97            	ld	xl,a
 887  0108 a6f8          	ld	a,#248
 888  010a 95            	ld	xh,a
 889  010b cd004b        	call	_LCD_SendByte
 891                     ; 200 }
 894  010e 85            	popw	x
 895  010f 81            	ret	
 928                     ; 203 void LCD_PrintChar(u8 Ascii)
 928                     ; 204 {
 929                     	switch	.text
 930  0110               _LCD_PrintChar:
 934                     ; 205   LCD_SendByte(DATA_TYPE, Ascii);
 936  0110 97            	ld	xl,a
 937  0111 a6fa          	ld	a,#250
 938  0113 95            	ld	xh,a
 940                     ; 206 }
 943  0114 cc004b        	jp	_LCD_SendByte
1013                     ; 209 void LCD_PrintString(u8 Line, FunctionalState AutoComplete, FunctionalState Append, u8 *ptr)
1013                     ; 210 {
1014                     	switch	.text
1015  0117               _LCD_PrintString:
1017  0117 89            	pushw	x
1018  0118 88            	push	a
1019       00000001      OFST:	set	1
1022                     ; 211   u8 CharPos = 0;
1024  0119 0f01          	clr	(OFST+0,sp)
1025                     ; 214   if (Append == DISABLE)
1027  011b 7b06          	ld	a,(OFST+5,sp)
1028  011d 2619          	jrne	L104
1029                     ; 216     LCD_SendByte(COMMAND_TYPE, Line);
1031  011f 9e            	ld	a,xh
1032  0120 97            	ld	xl,a
1033  0121 a6f8          	ld	a,#248
1034  0123 95            	ld	xh,a
1035  0124 cd004b        	call	_LCD_SendByte
1037  0127 200f          	jra	L104
1038  0129               L773:
1039                     ; 222     LCD_SendByte(DATA_TYPE, *ptr);
1041  0129 f6            	ld	a,(x)
1042  012a 97            	ld	xl,a
1043  012b a6fa          	ld	a,#250
1044  012d 95            	ld	xh,a
1045  012e cd004b        	call	_LCD_SendByte
1047                     ; 223     CharPos++;
1049  0131 0c01          	inc	(OFST+0,sp)
1050                     ; 224     ptr++;
1052  0133 1e07          	ldw	x,(OFST+6,sp)
1053  0135 5c            	incw	x
1054  0136 1f07          	ldw	(OFST+6,sp),x
1055  0138               L104:
1056                     ; 220   while ((*ptr != 0) && (CharPos < LCD_LINE_MAX_CHAR))
1058  0138 1e07          	ldw	x,(OFST+6,sp)
1059  013a f6            	ld	a,(x)
1060  013b 2706          	jreq	L504
1062  013d 7b01          	ld	a,(OFST+0,sp)
1063  013f a10f          	cp	a,#15
1064  0141 25e6          	jrult	L773
1065  0143               L504:
1066                     ; 228   if (AutoComplete == ENABLE)
1068  0143 7b03          	ld	a,(OFST+2,sp)
1069  0145 4a            	dec	a
1070  0146 2613          	jrne	L704
1072  0148 200b          	jra	L314
1073  014a               L114:
1074                     ; 232       LCD_SendByte(DATA_TYPE, ' ');
1076  014a ae0020        	ldw	x,#32
1077  014d a6fa          	ld	a,#250
1078  014f 95            	ld	xh,a
1079  0150 cd004b        	call	_LCD_SendByte
1081                     ; 233       CharPos++;
1083  0153 0c01          	inc	(OFST+0,sp)
1084  0155               L314:
1085                     ; 230     while (CharPos < LCD_LINE_MAX_CHAR)
1087  0155 7b01          	ld	a,(OFST+0,sp)
1088  0157 a10f          	cp	a,#15
1089  0159 25ef          	jrult	L114
1090  015b               L704:
1091                     ; 236 }
1094  015b 5b03          	addw	sp,#3
1095  015d 81            	ret	
1146                     ; 239 void LCD_PrintMsg(u8 *ptr)
1146                     ; 240 {
1147                     	switch	.text
1148  015e               _LCD_PrintMsg:
1150  015e 89            	pushw	x
1151  015f 89            	pushw	x
1152       00000002      OFST:	set	2
1155                     ; 241   u8 Char = 0;
1157                     ; 242   u8 CharPos = 0;
1159  0160 0f02          	clr	(OFST+0,sp)
1160                     ; 244   LCD_Clear(); /* Clear the LCD display */
1162  0162 cd00be        	call	_LCD_Clear
1164                     ; 247   LCD_SendByte(COMMAND_TYPE, LCD_LINE1);
1166  0165 ae0080        	ldw	x,#128
1169  0168 2038          	jp	LC001
1170  016a               L744:
1171                     ; 253     if (CharPos == LCD_LINE_MAX_CHAR)
1173  016a a10f          	cp	a,#15
1174  016c 260b          	jrne	L554
1175                     ; 255       LCD_SendByte(COMMAND_TYPE, LCD_LINE2); /* Select second line */
1177  016e ae0090        	ldw	x,#144
1178  0171 a6f8          	ld	a,#248
1179  0173 95            	ld	xh,a
1180  0174 cd004b        	call	_LCD_SendByte
1182  0177 1e03          	ldw	x,(OFST+1,sp)
1183  0179               L554:
1184                     ; 258     Char = *ptr;
1186  0179 f6            	ld	a,(x)
1187  017a 6b01          	ld	(OFST-1,sp),a
1188                     ; 260     switch (Char)
1191                     ; 278       break;
1192  017c a00a          	sub	a,#10
1193  017e 271a          	jreq	L124
1194  0180 a003          	sub	a,#3
1195  0182 2712          	jreq	L714
1196                     ; 273       default:
1196                     ; 274         /* Display characters different from (\r, \n) */
1196                     ; 275         LCD_SendByte(DATA_TYPE, Char);
1198  0184 7b01          	ld	a,(OFST-1,sp)
1199  0186 97            	ld	xl,a
1200  0187 a6fa          	ld	a,#250
1201  0189 95            	ld	xh,a
1202  018a cd004b        	call	_LCD_SendByte
1204                     ; 276         CharPos++;
1206  018d 0c02          	inc	(OFST+0,sp)
1207                     ; 277         ptr++;
1209  018f 1e03          	ldw	x,(OFST+1,sp)
1210  0191               LC002:
1212  0191 5c            	incw	x
1213  0192 1f03          	ldw	(OFST+1,sp),x
1214                     ; 278       break;
1216  0194 2014          	jra	L154
1217  0196               L714:
1218                     ; 262       case ('\r'):
1218                     ; 263         /* Carriage return */
1218                     ; 264         CharPos++;
1220  0196 0c02          	inc	(OFST+0,sp)
1221                     ; 265         ptr++;
1222                     ; 266       break;
1224  0198 20f7          	jp	LC002
1225  019a               L124:
1226                     ; 267       case ('\n'):
1226                     ; 268         CharPos = 0;
1228  019a 6b02          	ld	(OFST+0,sp),a
1229                     ; 269         ptr++;
1231  019c 5c            	incw	x
1232  019d 1f03          	ldw	(OFST+1,sp),x
1233                     ; 271         LCD_SendByte(COMMAND_TYPE, LCD_LINE2);
1235  019f ae0090        	ldw	x,#144
1236  01a2               LC001:
1237  01a2 a6f8          	ld	a,#248
1238  01a4 95            	ld	xh,a
1239  01a5 cd004b        	call	_LCD_SendByte
1241                     ; 272       break;
1243  01a8 1e03          	ldw	x,(OFST+1,sp)
1244  01aa               L154:
1245                     ; 250   while ((*ptr != 0) && (CharPos < (LCD_LINE_MAX_CHAR * 2)))
1247  01aa f6            	ld	a,(x)
1248  01ab 2706          	jreq	L364
1250  01ad 7b02          	ld	a,(OFST+0,sp)
1251  01af a11e          	cp	a,#30
1252  01b1 25b7          	jrult	L744
1253  01b3               L364:
1254                     ; 281 }
1257  01b3 5b04          	addw	sp,#4
1258  01b5 81            	ret	
1298                     ; 284 void LCD_PrintDec1(u8 Number)
1298                     ; 285 {
1299                     	switch	.text
1300  01b6               _LCD_PrintDec1:
1302  01b6 88            	push	a
1303  01b7 88            	push	a
1304       00000001      OFST:	set	1
1307                     ; 288   if (Number < (u8)10)
1309  01b8 a10a          	cp	a,#10
1310  01ba 2416          	jruge	L305
1311                     ; 292     NbreTmp = (u8)(Number / (u8)10);
1313  01bc ae000a        	ldw	x,#10
1314  01bf 9093          	ldw	y,x
1315  01c1 5f            	clrw	x
1316  01c2 97            	ld	xl,a
1317  01c3 65            	divw	x,y
1318                     ; 296     NbreTmp = (u8)(Number - (u8)((u8)10 * NbreTmp));
1320  01c4 a60a          	ld	a,#10
1321  01c6 42            	mul	x,a
1322  01c7 9f            	ld	a,xl
1323  01c8 1002          	sub	a,(OFST+1,sp)
1324  01ca 40            	neg	a
1325  01cb 6b01          	ld	(OFST+0,sp),a
1326                     ; 297     LCD_PrintChar((u8)(NbreTmp + (u8)0x30));
1328  01cd ab30          	add	a,#48
1329  01cf cd0110        	call	_LCD_PrintChar
1331  01d2               L305:
1332                     ; 299 }
1335  01d2 85            	popw	x
1336  01d3 81            	ret	
1376                     ; 302 void LCD_PrintDec2(u8 Number)
1376                     ; 303 {
1377                     	switch	.text
1378  01d4               _LCD_PrintDec2:
1380  01d4 88            	push	a
1381  01d5 88            	push	a
1382       00000001      OFST:	set	1
1385                     ; 306   if (Number < (u8)100)
1387  01d6 a164          	cp	a,#100
1388  01d8 2421          	jruge	L325
1389                     ; 310     NbreTmp = (u8)(Number / (u8)10);
1391  01da ae000a        	ldw	x,#10
1392  01dd 9093          	ldw	y,x
1393  01df 5f            	clrw	x
1394  01e0 97            	ld	xl,a
1395  01e1 65            	divw	x,y
1396  01e2 9f            	ld	a,xl
1397  01e3 6b01          	ld	(OFST+0,sp),a
1398                     ; 311     LCD_PrintChar((u8)(NbreTmp + (u8)0x30));
1400  01e5 ab30          	add	a,#48
1401  01e7 cd0110        	call	_LCD_PrintChar
1403                     ; 314     NbreTmp = (u8)(Number - (u8)((u8)10 * NbreTmp));
1405  01ea 7b01          	ld	a,(OFST+0,sp)
1406  01ec 97            	ld	xl,a
1407  01ed a60a          	ld	a,#10
1408  01ef 42            	mul	x,a
1409  01f0 9f            	ld	a,xl
1410  01f1 1002          	sub	a,(OFST+1,sp)
1411  01f3 40            	neg	a
1412  01f4 6b01          	ld	(OFST+0,sp),a
1413                     ; 315     LCD_PrintChar((u8)(NbreTmp + (u8)0x30));
1415  01f6 ab30          	add	a,#48
1416  01f8 cd0110        	call	_LCD_PrintChar
1418  01fb               L325:
1419                     ; 317 }
1422  01fb 85            	popw	x
1423  01fc 81            	ret	
1470                     ; 320 void LCD_PrintDec3(u16 Number)
1470                     ; 321 {
1471                     	switch	.text
1472  01fd               _LCD_PrintDec3:
1474  01fd 89            	pushw	x
1475  01fe 89            	pushw	x
1476       00000002      OFST:	set	2
1479                     ; 325   if (Number < (u16)1000)
1481  01ff a303e8        	cpw	x,#1000
1482  0202 2438          	jruge	L545
1483                     ; 328     Nbre1Tmp = (u8)(Number / (u8)100);
1485  0204 a664          	ld	a,#100
1486  0206 62            	div	x,a
1487  0207 9f            	ld	a,xl
1488  0208 6b02          	ld	(OFST+0,sp),a
1489                     ; 329     LCD_PrintChar((u8)(Nbre1Tmp + (u8)0x30));
1491  020a ab30          	add	a,#48
1492  020c cd0110        	call	_LCD_PrintChar
1494                     ; 332     Nbre1Tmp = (u8)(Number - ((u8)100 * Nbre1Tmp));
1496  020f 7b02          	ld	a,(OFST+0,sp)
1497  0211 97            	ld	xl,a
1498  0212 a664          	ld	a,#100
1499  0214 42            	mul	x,a
1500  0215 9f            	ld	a,xl
1501  0216 1004          	sub	a,(OFST+2,sp)
1502  0218 40            	neg	a
1503  0219 6b02          	ld	(OFST+0,sp),a
1504                     ; 333     Nbre2Tmp = (u8)(Nbre1Tmp / (u8)10);
1506  021b ae000a        	ldw	x,#10
1507  021e 9093          	ldw	y,x
1508  0220 5f            	clrw	x
1509  0221 97            	ld	xl,a
1510  0222 65            	divw	x,y
1511  0223 9f            	ld	a,xl
1512  0224 6b01          	ld	(OFST-1,sp),a
1513                     ; 334     LCD_PrintChar((u8)(Nbre2Tmp + (u8)0x30));
1515  0226 ab30          	add	a,#48
1516  0228 cd0110        	call	_LCD_PrintChar
1518                     ; 337     Nbre1Tmp = ((u8)(Nbre1Tmp - (u8)((u8)10 * Nbre2Tmp)));
1520  022b 7b01          	ld	a,(OFST-1,sp)
1521  022d 97            	ld	xl,a
1522  022e a60a          	ld	a,#10
1523  0230 42            	mul	x,a
1524  0231 9f            	ld	a,xl
1525  0232 1002          	sub	a,(OFST+0,sp)
1526  0234 40            	neg	a
1527  0235 6b02          	ld	(OFST+0,sp),a
1528                     ; 338     LCD_PrintChar((u8)(Nbre1Tmp + (u8)0x30));
1530  0237 ab30          	add	a,#48
1531  0239 cd0110        	call	_LCD_PrintChar
1533  023c               L545:
1534                     ; 341 }
1537  023c 5b04          	addw	sp,#4
1538  023e 81            	ret	
1585                     ; 344 void LCD_PrintDec4(u16 Number)
1585                     ; 345 {
1586                     	switch	.text
1587  023f               _LCD_PrintDec4:
1589  023f 89            	pushw	x
1590  0240 5206          	subw	sp,#6
1591       00000006      OFST:	set	6
1594                     ; 349   if (Number < (u16)10000)
1596  0242 a32710        	cpw	x,#10000
1597  0245 2463          	jruge	L765
1598                     ; 352     Nbre1Tmp = (u16)(Number / (u16)1000);
1600  0247 90ae03e8      	ldw	y,#1000
1601  024b 65            	divw	x,y
1602  024c 1f05          	ldw	(OFST-1,sp),x
1603                     ; 353     LCD_PrintChar((u8)(Nbre1Tmp + (u8)0x30));
1605  024e 7b06          	ld	a,(OFST+0,sp)
1606  0250 ab30          	add	a,#48
1607  0252 cd0110        	call	_LCD_PrintChar
1609                     ; 356     Nbre1Tmp = (u16)(Number - ((u16)1000 * Nbre1Tmp));
1611  0255 1e05          	ldw	x,(OFST-1,sp)
1612  0257 90ae03e8      	ldw	y,#1000
1613  025b cd0000        	call	c_imul
1615  025e 1f01          	ldw	(OFST-5,sp),x
1616  0260 1e07          	ldw	x,(OFST+1,sp)
1617  0262 72f001        	subw	x,(OFST-5,sp)
1618  0265 1f05          	ldw	(OFST-1,sp),x
1619                     ; 357     Nbre2Tmp = (u16)(Nbre1Tmp / (u8)100);
1621  0267 a664          	ld	a,#100
1622  0269 62            	div	x,a
1623  026a 1f03          	ldw	(OFST-3,sp),x
1624                     ; 358     LCD_PrintChar((u8)(Nbre2Tmp + (u8)0x30));
1626  026c 7b04          	ld	a,(OFST-2,sp)
1627  026e ab30          	add	a,#48
1628  0270 cd0110        	call	_LCD_PrintChar
1630                     ; 361     Nbre1Tmp = (u16)(Nbre1Tmp - ((u16)100 * Nbre2Tmp));
1632  0273 1e03          	ldw	x,(OFST-3,sp)
1633  0275 90ae0064      	ldw	y,#100
1634  0279 cd0000        	call	c_imul
1636  027c 1f01          	ldw	(OFST-5,sp),x
1637  027e 1e05          	ldw	x,(OFST-1,sp)
1638  0280 72f001        	subw	x,(OFST-5,sp)
1639  0283 1f05          	ldw	(OFST-1,sp),x
1640                     ; 362     Nbre2Tmp = (u16)(Nbre1Tmp / (u16)10);
1642  0285 a60a          	ld	a,#10
1643  0287 62            	div	x,a
1644  0288 1f03          	ldw	(OFST-3,sp),x
1645                     ; 363     LCD_PrintChar((u8)(Nbre2Tmp + (u8)0x30));
1647  028a 7b04          	ld	a,(OFST-2,sp)
1648  028c ab30          	add	a,#48
1649  028e cd0110        	call	_LCD_PrintChar
1651                     ; 366     Nbre1Tmp = ((u16)(Nbre1Tmp - (u16)((u16)10 * Nbre2Tmp)));
1653  0291 1e03          	ldw	x,(OFST-3,sp)
1654  0293 90ae000a      	ldw	y,#10
1655  0297 cd0000        	call	c_imul
1657  029a 1f01          	ldw	(OFST-5,sp),x
1658  029c 1e05          	ldw	x,(OFST-1,sp)
1659  029e 72f001        	subw	x,(OFST-5,sp)
1660  02a1 1f05          	ldw	(OFST-1,sp),x
1661                     ; 367     LCD_PrintChar((u8)(Nbre1Tmp + (u8)0x30));
1663  02a3 7b06          	ld	a,(OFST+0,sp)
1664  02a5 ab30          	add	a,#48
1665  02a7 cd0110        	call	_LCD_PrintChar
1667  02aa               L765:
1668                     ; 369 }
1671  02aa 5b08          	addw	sp,#8
1672  02ac 81            	ret	
1705                     ; 372 void LCD_PrintHex1(u8 Number)
1705                     ; 373 {
1706                     	switch	.text
1707  02ad               _LCD_PrintHex1:
1709  02ad 88            	push	a
1710       00000000      OFST:	set	0
1713                     ; 374   if (Number < (u8)0x0A)
1715  02ae a10a          	cp	a,#10
1716  02b0 2404          	jruge	L506
1717                     ; 376     LCD_PrintChar((u8)(Number + (u8)0x30));
1719  02b2 ab30          	add	a,#48
1722  02b4 200c          	jra	L706
1723  02b6               L506:
1724                     ; 379     if (Number < (u8)0x10)
1726  02b6 7b01          	ld	a,(OFST+1,sp)
1727  02b8 a110          	cp	a,#16
1728  02ba 2404          	jruge	L116
1729                     ; 381       LCD_PrintChar((u8)(Number + (u8)0x37));
1731  02bc ab37          	add	a,#55
1734  02be 2002          	jra	L706
1735  02c0               L116:
1736                     ; 385       LCD_PrintChar('-');
1738  02c0 a62d          	ld	a,#45
1740  02c2               L706:
1741  02c2 cd0110        	call	_LCD_PrintChar
1742                     ; 387 }
1745  02c5 84            	pop	a
1746  02c6 81            	ret	
1779                     ; 390 void LCD_PrintHex2(u8 Number)
1779                     ; 391 {
1780                     	switch	.text
1781  02c7               _LCD_PrintHex2:
1783  02c7 88            	push	a
1784       00000000      OFST:	set	0
1787                     ; 392   LCD_PrintHex1((u8)(Number >> (u8)4));
1789  02c8 4e            	swap	a
1790  02c9 a40f          	and	a,#15
1791  02cb ade0          	call	_LCD_PrintHex1
1793                     ; 393   LCD_PrintHex1((u8)(Number & (u8)0x0F));
1795  02cd 7b01          	ld	a,(OFST+1,sp)
1796  02cf a40f          	and	a,#15
1797  02d1 adda          	call	_LCD_PrintHex1
1799                     ; 394 }
1802  02d3 84            	pop	a
1803  02d4 81            	ret	
1836                     ; 397 void LCD_PrintHex3(u16 Number)
1836                     ; 398 {
1837                     	switch	.text
1838  02d5               _LCD_PrintHex3:
1840  02d5 89            	pushw	x
1841       00000000      OFST:	set	0
1844                     ; 399   LCD_PrintHex1((u8)(Number >> (u8)8));
1846  02d6 9e            	ld	a,xh
1847  02d7 add4          	call	_LCD_PrintHex1
1849                     ; 400   LCD_PrintHex1((u8)((u8)(Number) >> (u8)4));
1851  02d9 7b02          	ld	a,(OFST+2,sp)
1852  02db 4e            	swap	a
1853  02dc a40f          	and	a,#15
1854  02de adcd          	call	_LCD_PrintHex1
1856                     ; 401   LCD_PrintHex1((u8)((u8)(Number) & (u8)0x0F));
1858  02e0 7b02          	ld	a,(OFST+2,sp)
1859  02e2 a40f          	and	a,#15
1860  02e4 adc7          	call	_LCD_PrintHex1
1862                     ; 402 }
1865  02e6 85            	popw	x
1866  02e7 81            	ret	
1899                     ; 405 void LCD_PrintBin2(u8 Number)
1899                     ; 406 {
1900                     	switch	.text
1901  02e8               _LCD_PrintBin2:
1903  02e8 88            	push	a
1904       00000000      OFST:	set	0
1907                     ; 407   LCD_PrintHex1((u8)((u8)(Number & (u8)0x02) >> (u8)1));
1909  02e9 a402          	and	a,#2
1910  02eb 44            	srl	a
1911  02ec adbf          	call	_LCD_PrintHex1
1913                     ; 408   LCD_PrintHex1((u8)(Number & (u8)0x01));
1915  02ee 7b01          	ld	a,(OFST+1,sp)
1916  02f0 a401          	and	a,#1
1917  02f2 adb9          	call	_LCD_PrintHex1
1919                     ; 409 }
1922  02f4 84            	pop	a
1923  02f5 81            	ret	
1956                     ; 412 void LCD_PrintBin4(u8 Number)
1956                     ; 413 {
1957                     	switch	.text
1958  02f6               _LCD_PrintBin4:
1960  02f6 88            	push	a
1961       00000000      OFST:	set	0
1964                     ; 414   LCD_PrintHex1((u8)((u8)(Number & (u8)0x08) >> (u8)3));
1966  02f7 a408          	and	a,#8
1967  02f9 44            	srl	a
1968  02fa 44            	srl	a
1969  02fb 44            	srl	a
1970  02fc adaf          	call	_LCD_PrintHex1
1972                     ; 415   LCD_PrintHex1((u8)((u8)(Number & (u8)0x04) >> (u8)2));
1974  02fe 7b01          	ld	a,(OFST+1,sp)
1975  0300 a404          	and	a,#4
1976  0302 44            	srl	a
1977  0303 44            	srl	a
1978  0304 ada7          	call	_LCD_PrintHex1
1980                     ; 416   LCD_PrintHex1((u8)((u8)(Number & (u8)0x02) >> (u8)1));
1982  0306 7b01          	ld	a,(OFST+1,sp)
1983  0308 a402          	and	a,#2
1984  030a 44            	srl	a
1985  030b ada0          	call	_LCD_PrintHex1
1987                     ; 417   LCD_PrintHex1((u8)(Number & (u8)0x01));
1989  030d 7b01          	ld	a,(OFST+1,sp)
1990  030f a401          	and	a,#1
1991  0311 ad9a          	call	_LCD_PrintHex1
1993                     ; 418 }
1996  0313 84            	pop	a
1997  0314 81            	ret	
2047                     ; 421 void LCD_DisplayCGRAM0(u8 address, u8 *ptrTable)
2047                     ; 422 {
2048                     	switch	.text
2049  0315               _LCD_DisplayCGRAM0:
2051  0315 88            	push	a
2052  0316 88            	push	a
2053       00000001      OFST:	set	1
2056                     ; 426   LCD_SendByte(COMMAND_TYPE, (u8)0x40);
2058  0317 ae0040        	ldw	x,#64
2059  031a a6f8          	ld	a,#248
2060  031c 95            	ld	xh,a
2061  031d cd004b        	call	_LCD_SendByte
2063                     ; 428   u = 32; /* Nb byte in the table */
2065  0320 a620          	ld	a,#32
2066  0322 6b01          	ld	(OFST+0,sp),a
2067  0324               L717:
2068                     ; 431     LCD_SendByte(DATA_TYPE, ptrTable[32 - u]);
2070  0324 4f            	clr	a
2071  0325 97            	ld	xl,a
2072  0326 a620          	ld	a,#32
2073  0328 1001          	sub	a,(OFST+0,sp)
2074  032a 2401          	jrnc	L062
2075  032c 5a            	decw	x
2076  032d               L062:
2077  032d 02            	rlwa	x,a
2078  032e 72fb05        	addw	x,(OFST+4,sp)
2079  0331 f6            	ld	a,(x)
2080  0332 97            	ld	xl,a
2081  0333 a6fa          	ld	a,#250
2082  0335 95            	ld	xh,a
2083  0336 cd004b        	call	_LCD_SendByte
2085                     ; 432     u--;
2087  0339 0a01          	dec	(OFST+0,sp)
2088                     ; 429   while (u)
2090  033b 26e7          	jrne	L717
2091                     ; 436   LCD_SendByte(COMMAND_TYPE, address);
2093  033d 7b02          	ld	a,(OFST+1,sp)
2094  033f 97            	ld	xl,a
2095  0340 a6f8          	ld	a,#248
2096  0342 95            	ld	xh,a
2097  0343 cd004b        	call	_LCD_SendByte
2099                     ; 437   LCD_SendByte(DATA_TYPE, (u8)0x00);
2101  0346 5f            	clrw	x
2102  0347 a6fa          	ld	a,#250
2103  0349 95            	ld	xh,a
2104  034a cd004b        	call	_LCD_SendByte
2106                     ; 438   LCD_SendByte(DATA_TYPE, (u8)0x00);
2108  034d 5f            	clrw	x
2109  034e a6fa          	ld	a,#250
2110  0350 95            	ld	xh,a
2111  0351 cd004b        	call	_LCD_SendByte
2113                     ; 439 }
2116  0354 85            	popw	x
2117  0355 81            	ret	
2167                     ; 442 void LCD_DisplayCGRAM1(u8 address, u8 *ptrTable)
2167                     ; 443 {
2168                     	switch	.text
2169  0356               _LCD_DisplayCGRAM1:
2171  0356 88            	push	a
2172  0357 88            	push	a
2173       00000001      OFST:	set	1
2176                     ; 447   LCD_SendByte(COMMAND_TYPE, (u8)((u8)0x40 | (u8)0x10));
2178  0358 ae0050        	ldw	x,#80
2179  035b a6f8          	ld	a,#248
2180  035d 95            	ld	xh,a
2181  035e cd004b        	call	_LCD_SendByte
2183                     ; 449   u = 32; /* Nb byte in the table */
2185  0361 a620          	ld	a,#32
2186  0363 6b01          	ld	(OFST+0,sp),a
2187  0365               L747:
2188                     ; 452     LCD_SendByte(DATA_TYPE, ptrTable[32 - u]);
2190  0365 4f            	clr	a
2191  0366 97            	ld	xl,a
2192  0367 a620          	ld	a,#32
2193  0369 1001          	sub	a,(OFST+0,sp)
2194  036b 2401          	jrnc	L672
2195  036d 5a            	decw	x
2196  036e               L672:
2197  036e 02            	rlwa	x,a
2198  036f 72fb05        	addw	x,(OFST+4,sp)
2199  0372 f6            	ld	a,(x)
2200  0373 97            	ld	xl,a
2201  0374 a6fa          	ld	a,#250
2202  0376 95            	ld	xh,a
2203  0377 cd004b        	call	_LCD_SendByte
2205                     ; 453     u--;
2207  037a 0a01          	dec	(OFST+0,sp)
2208                     ; 450   while (u)
2210  037c 26e7          	jrne	L747
2211                     ; 457   LCD_SendByte(COMMAND_TYPE, (u8)(address + 1));
2213  037e 7b02          	ld	a,(OFST+1,sp)
2214  0380 4c            	inc	a
2215  0381 97            	ld	xl,a
2216  0382 a6f8          	ld	a,#248
2217  0384 95            	ld	xh,a
2218  0385 cd004b        	call	_LCD_SendByte
2220                     ; 458   LCD_SendByte(DATA_TYPE, (u8)0x00);
2222  0388 5f            	clrw	x
2223  0389 a6fa          	ld	a,#250
2224  038b 95            	ld	xh,a
2225  038c cd004b        	call	_LCD_SendByte
2227                     ; 459   LCD_SendByte(DATA_TYPE, (u8)0x02);
2229  038f ae0002        	ldw	x,#2
2230  0392 a6fa          	ld	a,#250
2231  0394 95            	ld	xh,a
2232  0395 cd004b        	call	_LCD_SendByte
2234                     ; 460 }
2237  0398 85            	popw	x
2238  0399 81            	ret	
2274                     ; 463 void LCD_DisplayLogo(u8 address)
2274                     ; 464 {
2275                     	switch	.text
2276  039a               _LCD_DisplayLogo:
2278  039a 88            	push	a
2279       00000000      OFST:	set	0
2282                     ; 465   LCD_DisplayCGRAM0(address, S_CGRAM);
2284  039b ae0000        	ldw	x,#_S_CGRAM
2285  039e 89            	pushw	x
2286  039f cd0315        	call	_LCD_DisplayCGRAM0
2288  03a2 85            	popw	x
2289                     ; 466   LCD_DisplayCGRAM1(address, T_CGRAM);
2291  03a3 ae0020        	ldw	x,#_T_CGRAM
2292  03a6 89            	pushw	x
2293  03a7 7b03          	ld	a,(OFST+3,sp)
2294  03a9 adab          	call	_LCD_DisplayCGRAM1
2296  03ab 85            	popw	x
2297                     ; 467 }
2300  03ac 84            	pop	a
2301  03ad 81            	ret	
2377                     ; 470 void LCD_RollString(u8 Line, u8 *ptr, u16 speed)
2377                     ; 471 {
2378                     	switch	.text
2379  03ae               _LCD_RollString:
2381  03ae 88            	push	a
2382  03af 5205          	subw	sp,#5
2383       00000005      OFST:	set	5
2386                     ; 472   u8 CharPos = 0;
2388  03b1 0f01          	clr	(OFST-4,sp)
2389                     ; 477   LCD_SendByte(COMMAND_TYPE, Line);
2391  03b3 97            	ld	xl,a
2392  03b4 a6f8          	ld	a,#248
2393  03b6 95            	ld	xh,a
2394  03b7 cd004b        	call	_LCD_SendByte
2396                     ; 479   ptr2 = ptr;
2398  03ba 1e09          	ldw	x,(OFST+4,sp)
2399  03bc 1f02          	ldw	(OFST-3,sp),x
2401  03be 204d          	jra	L7201
2402  03c0               L3201:
2403                     ; 484     if (*ptr != 0)
2405  03c0 1e09          	ldw	x,(OFST+4,sp)
2406  03c2 f6            	ld	a,(x)
2407  03c3 270e          	jreq	L3301
2408                     ; 486       LCD_SendByte(DATA_TYPE, *ptr);
2410  03c5 97            	ld	xl,a
2411  03c6 a6fa          	ld	a,#250
2412  03c8 95            	ld	xh,a
2413  03c9 cd004b        	call	_LCD_SendByte
2415                     ; 487       ptr++;
2417  03cc 1e09          	ldw	x,(OFST+4,sp)
2418  03ce 5c            	incw	x
2419  03cf 1f09          	ldw	(OFST+4,sp),x
2421  03d1 2009          	jra	L5301
2422  03d3               L3301:
2423                     ; 491       LCD_SendByte(DATA_TYPE, ' ');
2425  03d3 ae0020        	ldw	x,#32
2426  03d6 a6fa          	ld	a,#250
2427  03d8 95            	ld	xh,a
2428  03d9 cd004b        	call	_LCD_SendByte
2430  03dc               L5301:
2431                     ; 494     CharPos++;
2433  03dc 0c01          	inc	(OFST-4,sp)
2434                     ; 496     if (CharPos == LCD_LINE_MAX_CHAR)
2436  03de 7b01          	ld	a,(OFST-4,sp)
2437  03e0 a10f          	cp	a,#15
2438  03e2 2629          	jrne	L7201
2439                     ; 498       for(i=0; i<1000; i++) LCD_Delay(speed);
2441  03e4 5f            	clrw	x
2442  03e5 1f04          	ldw	(OFST-1,sp),x
2443  03e7               L1401:
2446  03e7 1e0b          	ldw	x,(OFST+6,sp)
2447  03e9 cd0000        	call	_LCD_Delay
2451  03ec 1e04          	ldw	x,(OFST-1,sp)
2452  03ee 5c            	incw	x
2453  03ef 1f04          	ldw	(OFST-1,sp),x
2456  03f1 a303e8        	cpw	x,#1000
2457  03f4 25f1          	jrult	L1401
2458                     ; 499       LCD_ClearLine(Line);
2460  03f6 7b06          	ld	a,(OFST+1,sp)
2461  03f8 cd00e6        	call	_LCD_ClearLine
2463                     ; 500       LCD_SendByte(COMMAND_TYPE, Line);
2465  03fb 7b06          	ld	a,(OFST+1,sp)
2466  03fd 97            	ld	xl,a
2467  03fe a6f8          	ld	a,#248
2468  0400 95            	ld	xh,a
2469  0401 cd004b        	call	_LCD_SendByte
2471                     ; 501       CharPos = 0;
2473  0404 0f01          	clr	(OFST-4,sp)
2474                     ; 502       ptr2++;
2476  0406 1e02          	ldw	x,(OFST-3,sp)
2477  0408 5c            	incw	x
2478  0409 1f02          	ldw	(OFST-3,sp),x
2479                     ; 503       ptr = ptr2;
2481  040b 1f09          	ldw	(OFST+4,sp),x
2482  040d               L7201:
2483                     ; 482   while (*ptr2 != 0)
2485  040d 1e02          	ldw	x,(OFST-3,sp)
2486  040f f6            	ld	a,(x)
2487  0410 26ae          	jrne	L3201
2488                     ; 506 }
2491  0412 5b06          	addw	sp,#6
2492  0414 81            	ret	
2527                     	xdef	_LCD_Delay
2528                     	xdef	_T_CGRAM
2529                     	xdef	_S_CGRAM
2530                     	xdef	_LCD_RollString
2531                     	xdef	_LCD_DisplayLogo
2532                     	xdef	_LCD_DisplayCGRAM1
2533                     	xdef	_LCD_DisplayCGRAM0
2534                     	xdef	_LCD_PrintBin4
2535                     	xdef	_LCD_PrintBin2
2536                     	xdef	_LCD_PrintHex3
2537                     	xdef	_LCD_PrintHex2
2538                     	xdef	_LCD_PrintHex1
2539                     	xdef	_LCD_PrintDec4
2540                     	xdef	_LCD_PrintDec3
2541                     	xdef	_LCD_PrintDec2
2542                     	xdef	_LCD_PrintDec1
2543                     	xdef	_LCD_PrintMsg
2544                     	xdef	_LCD_PrintString
2545                     	xdef	_LCD_PrintChar
2546                     	xdef	_LCD_SetCursorPos
2547                     	xdef	_LCD_ClearLine
2548                     	xdef	_LCD_SetGraphicMode
2549                     	xdef	_LCD_SetTextMode
2550                     	xdef	_LCD_Clear
2551                     	xdef	_LCD_Init
2552                     	xdef	_LCD_SendBuffer
2553                     	xdef	_LCD_SendByte
2554                     	xdef	_LCD_Backlight
2555                     	xdef	_LCD_ChipSelect
2556                     	xref	_GPIO_WriteLow
2557                     	xref	_GPIO_WriteHigh
2558                     	xref	_GPIO_Init
2559                     	xref.b	c_x
2578                     	xref	c_imul
2579                     	end
