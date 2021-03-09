   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.6 - 08 Apr 2008
   3                     ; Optimizer V4.2.6 - 08 Apr 2008
  33                     ; 61 void SPI_DeInit(void)
  33                     ; 62 {
  35                     	switch	.text
  36  0000               _SPI_DeInit:
  40                     ; 63   SPI->CR1    = SPI_CR1_RESET_VALUE;
  42  0000 725f5200      	clr	20992
  43                     ; 64   SPI->CR2    = SPI_CR2_RESET_VALUE;
  45  0004 725f5201      	clr	20993
  46                     ; 65   SPI->ICR    = SPI_ICR_RESET_VALUE;
  48  0008 725f5202      	clr	20994
  49                     ; 66   SPI->SR     = SPI_SR_RESET_VALUE;
  51  000c 35025203      	mov	20995,#2
  52                     ; 67   SPI->CRCPR  = SPI_CRCPR_RESET_VALUE;
  54  0010 35075205      	mov	20997,#7
  55                     ; 68 }
  58  0014 81            	ret	
 372                     ; 90 void SPI_Init(SPI_FirstBit_TypeDef FirstBit, SPI_BaudRatePrescaler_TypeDef BaudRatePrescaler, SPI_Mode_TypeDef Mode, SPI_ClockPolarity_TypeDef ClockPolarity, SPI_ClockPhase_TypeDef ClockPhase, SPI_DataDirection_TypeDef Data_Direction, SPI_NSS_TypeDef Slave_Management, u8 CRCPolynomial)
 372                     ; 91 {
 373                     	switch	.text
 374  0015               _SPI_Init:
 376  0015 89            	pushw	x
 377       00000000      OFST:	set	0
 380                     ; 93   assert_param(IS_SPI_FIRSTBIT_OK(FirstBit));
 382                     ; 94   assert_param(IS_SPI_BAUDRATE_PRESCALER_OK(BaudRatePrescaler));
 384                     ; 95   assert_param(IS_SPI_MODE_OK(Mode));
 386                     ; 96   assert_param(IS_SPI_POLARITY_OK(ClockPolarity));
 388                     ; 97   assert_param(IS_SPI_PHASE_OK(ClockPhase));
 390                     ; 98   assert_param(IS_SPI_DATA_DIRECTION_OK(Data_Direction));
 392                     ; 99   assert_param(IS_SPI_SLAVEMANAGEMENT_OK(Slave_Management));
 394                     ; 100   assert_param(IS_SPI_CRC_POLYNOMIAL_OK(CRCPolynomial));
 396                     ; 103   SPI->CR1 = (u8)((u8)(FirstBit) |
 396                     ; 104                   (u8)(BaudRatePrescaler) |
 396                     ; 105                   (u8)(ClockPolarity) |
 396                     ; 106                   (u8)(ClockPhase));
 398  0016 9f            	ld	a,xl
 399  0017 1a01          	or	a,(OFST+1,sp)
 400  0019 1a06          	or	a,(OFST+6,sp)
 401  001b 1a07          	or	a,(OFST+7,sp)
 402  001d c75200        	ld	20992,a
 403                     ; 109   SPI->CR2 = (u8)((u8)(Data_Direction) | (u8)(Slave_Management));
 405  0020 7b08          	ld	a,(OFST+8,sp)
 406  0022 1a09          	or	a,(OFST+9,sp)
 407  0024 c75201        	ld	20993,a
 408                     ; 111   if (Mode == SPI_MODE_MASTER)
 410  0027 7b05          	ld	a,(OFST+5,sp)
 411  0029 a104          	cp	a,#4
 412  002b 2606          	jrne	L102
 413                     ; 113     SPI->CR2 |= (u8)SPI_CR2_SSI;
 415  002d 72105201      	bset	20993,#0
 417  0031 2004          	jra	L302
 418  0033               L102:
 419                     ; 117     SPI->CR2 &= (u8)~(SPI_CR2_SSI);
 421  0033 72115201      	bres	20993,#0
 422  0037               L302:
 423                     ; 121   SPI->CR1 |= (u8)(Mode);
 425  0037 c65200        	ld	a,20992
 426  003a 1a05          	or	a,(OFST+5,sp)
 427  003c c75200        	ld	20992,a
 428                     ; 124   SPI->CRCPR = (u8)CRCPolynomial;
 430  003f 7b0a          	ld	a,(OFST+10,sp)
 431  0041 c75205        	ld	20997,a
 432                     ; 125 }
 435  0044 85            	popw	x
 436  0045 81            	ret	
 491                     ; 143 void SPI_Cmd(FunctionalState NewState)
 491                     ; 144 {
 492                     	switch	.text
 493  0046               _SPI_Cmd:
 497                     ; 146   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 499                     ; 148   if (NewState != DISABLE)
 501  0046 4d            	tnz	a
 502  0047 2705          	jreq	L332
 503                     ; 150     SPI->CR1 |= SPI_CR1_SPE; /* Enable the SPI peripheral*/
 505  0049 721c5200      	bset	20992,#6
 508  004d 81            	ret	
 509  004e               L332:
 510                     ; 154     SPI->CR1 &= (u8)(~SPI_CR1_SPE); /* Disable the SPI peripheral*/
 512  004e 721d5200      	bres	20992,#6
 513                     ; 156 }
 516  0052 81            	ret	
 623                     ; 174 void SPI_ITConfig(SPI_IT_TypeDef SPI_IT, FunctionalState NewState)
 623                     ; 175 {
 624                     	switch	.text
 625  0053               _SPI_ITConfig:
 627  0053 89            	pushw	x
 628  0054 88            	push	a
 629       00000001      OFST:	set	1
 632                     ; 176   u8 itpos = 0;
 634  0055 0f01          	clr	(OFST+0,sp)
 635                     ; 178   assert_param(IS_SPI_CONFIG_IT_OK(SPI_IT));
 637                     ; 179   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 639                     ; 182   itpos = (u8)((u8)1 << (u8)((u8)SPI_IT & (u8)0x0F));
 641  0057 9e            	ld	a,xh
 642  0058 a40f          	and	a,#15
 643  005a 5f            	clrw	x
 644  005b 97            	ld	xl,a
 645  005c a601          	ld	a,#1
 646  005e 5d            	tnzw	x
 647  005f 2704          	jreq	L41
 648  0061               L61:
 649  0061 48            	sll	a
 650  0062 5a            	decw	x
 651  0063 26fc          	jrne	L61
 652  0065               L41:
 653  0065 6b01          	ld	(OFST+0,sp),a
 654                     ; 184   if (NewState != DISABLE)
 656  0067 0d03          	tnz	(OFST+2,sp)
 657  0069 2707          	jreq	L503
 658                     ; 186     SPI->ICR |= itpos; /* Enable interrupt*/
 660  006b c65202        	ld	a,20994
 661  006e 1a01          	or	a,(OFST+0,sp)
 663  0070 2004          	jra	L703
 664  0072               L503:
 665                     ; 190     SPI->ICR &= (u8)(~itpos); /* Disable interrupt*/
 667  0072 43            	cpl	a
 668  0073 c45202        	and	a,20994
 669  0076               L703:
 670  0076 c75202        	ld	20994,a
 671                     ; 192 }
 674  0079 5b03          	addw	sp,#3
 675  007b 81            	ret	
 707                     ; 206 void SPI_SendData(u8 Data)
 707                     ; 207 {
 708                     	switch	.text
 709  007c               _SPI_SendData:
 713                     ; 208   SPI->DR = Data; /* Write in the DR register the data to be sent*/
 715  007c c75204        	ld	20996,a
 716                     ; 209 }
 719  007f 81            	ret	
 742                     ; 225 u8 SPI_ReceiveData(void)
 742                     ; 226 {
 743                     	switch	.text
 744  0080               _SPI_ReceiveData:
 748                     ; 227   return ((u8)SPI->DR); /* Return the data in the DR register*/
 750  0080 c65204        	ld	a,20996
 753  0083 81            	ret	
 789                     ; 246 void SPI_NSSInternalSoftwareCmd(FunctionalState NewState)
 789                     ; 247 {
 790                     	switch	.text
 791  0084               _SPI_NSSInternalSoftwareCmd:
 795                     ; 249   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 797                     ; 251   if (NewState != DISABLE)
 799  0084 4d            	tnz	a
 800  0085 2705          	jreq	L353
 801                     ; 253     SPI->CR2 |= SPI_CR2_SSI; /* Set NSS pin internally by software*/
 803  0087 72105201      	bset	20993,#0
 806  008b 81            	ret	
 807  008c               L353:
 808                     ; 257     SPI->CR2 &= (u8)(~SPI_CR2_SSI); /* Reset NSS pin internally by software*/
 810  008c 72115201      	bres	20993,#0
 811                     ; 259 }
 814  0090 81            	ret	
 837                     ; 275 void SPI_TransmitCRC(void)
 837                     ; 276 {
 838                     	switch	.text
 839  0091               _SPI_TransmitCRC:
 843                     ; 277   SPI->CR2 |= SPI_CR2_CRCNEXT; /* Enable the CRC transmission*/
 845  0091 72185201      	bset	20993,#4
 846                     ; 278 }
 849  0095 81            	ret	
 886                     ; 295 void SPI_CalculateCRCCmd(FunctionalState NewState)
 886                     ; 296 {
 887                     	switch	.text
 888  0096               _SPI_CalculateCRCCmd:
 890  0096 88            	push	a
 891       00000000      OFST:	set	0
 894                     ; 298   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 896                     ; 301   SPI_Cmd(DISABLE);
 898  0097 4f            	clr	a
 899  0098 adac          	call	_SPI_Cmd
 901                     ; 303   if (NewState != DISABLE)
 903  009a 7b01          	ld	a,(OFST+1,sp)
 904  009c 2706          	jreq	L504
 905                     ; 305     SPI->CR2 |= SPI_CR2_CRCEN; /* Enable the CRC calculation*/
 907  009e 721a5201      	bset	20993,#5
 909  00a2 2004          	jra	L704
 910  00a4               L504:
 911                     ; 309     SPI->CR2 &= (u8)(~SPI_CR2_CRCEN); /* Disable the CRC calculation*/
 913  00a4 721b5201      	bres	20993,#5
 914  00a8               L704:
 915                     ; 311 }
 918  00a8 84            	pop	a
 919  00a9 81            	ret	
 981                     ; 326 u8 SPI_GetCRC(SPI_CRC_TypeDef SPI_CRC)
 981                     ; 327 {
 982                     	switch	.text
 983  00aa               _SPI_GetCRC:
 985  00aa 88            	push	a
 986       00000001      OFST:	set	1
 989                     ; 328   u8 crcreg = 0;
 991  00ab 0f01          	clr	(OFST+0,sp)
 992                     ; 331   assert_param(IS_SPI_CRC_OK(SPI_CRC));
 994                     ; 333   if (SPI_CRC != SPI_CRC_RX)
 996  00ad 4d            	tnz	a
 997  00ae 2705          	jreq	L144
 998                     ; 335     crcreg = SPI->TXCRCR;  /* Get the Tx CRC register*/
1000  00b0 c65207        	ld	a,20999
1002  00b3 2003          	jra	L344
1003  00b5               L144:
1004                     ; 339     crcreg = SPI->RXCRCR; /* Get the Rx CRC register*/
1006  00b5 c65206        	ld	a,20998
1007  00b8               L344:
1008                     ; 343   return crcreg;
1012  00b8 5b01          	addw	sp,#1
1013  00ba 81            	ret	
1038                     ; 359 void SPI_ResetCRC(void)
1038                     ; 360 {
1039                     	switch	.text
1040  00bb               _SPI_ResetCRC:
1044                     ; 363   SPI_CalculateCRCCmd(ENABLE);
1046  00bb a601          	ld	a,#1
1047  00bd add7          	call	_SPI_CalculateCRCCmd
1049                     ; 366   SPI_Cmd(ENABLE);
1051  00bf a601          	ld	a,#1
1053                     ; 367 }
1056  00c1 2083          	jp	_SPI_Cmd
1080                     ; 384 u8 SPI_GetCRCPolynomial(void)
1080                     ; 385 {
1081                     	switch	.text
1082  00c3               _SPI_GetCRCPolynomial:
1086                     ; 386   return SPI->CRCPR; /* Return the CRC polynomial register */
1088  00c3 c65205        	ld	a,20997
1091  00c6 81            	ret	
1147                     ; 402 void SPI_BiDirectionalLineConfig(SPI_Direction_TypeDef SPI_Direction)
1147                     ; 403 {
1148                     	switch	.text
1149  00c7               _SPI_BiDirectionalLineConfig:
1153                     ; 405   assert_param(IS_SPI_DIRECTION_OK(SPI_Direction));
1155                     ; 407   if (SPI_Direction != SPI_DIRECTION_RX)
1157  00c7 4d            	tnz	a
1158  00c8 2705          	jreq	L315
1159                     ; 409     SPI->CR2 |= SPI_CR2_BDOE; /* Set the Tx only mode*/
1161  00ca 721c5201      	bset	20993,#6
1164  00ce 81            	ret	
1165  00cf               L315:
1166                     ; 413     SPI->CR2 &= (u8)(~SPI_CR2_BDOE); /* Set the Rx only mode*/
1168  00cf 721d5201      	bres	20993,#6
1169                     ; 415 }
1172  00d3 81            	ret	
1293                     ; 435 FlagStatus SPI_GetFlagStatus(SPI_Flag_TypeDef SPI_FLAG)
1293                     ; 436 {
1294                     	switch	.text
1295  00d4               _SPI_GetFlagStatus:
1297  00d4 88            	push	a
1298       00000001      OFST:	set	1
1301                     ; 437   FlagStatus status = RESET;
1303  00d5 0f01          	clr	(OFST+0,sp)
1304                     ; 439   assert_param(IS_SPI_FLAGS_OK(SPI_FLAG));
1306                     ; 442   if ((SPI->SR & (u8)SPI_FLAG) != (u8)RESET)
1308  00d7 c45203        	and	a,20995
1309  00da 2702          	jreq	L375
1310                     ; 444     status = SET; /* SPI_FLAG is set */
1312  00dc a601          	ld	a,#1
1314  00de               L375:
1315                     ; 448     status = RESET; /* SPI_FLAG is reset*/
1317                     ; 452   return status;
1321  00de 5b01          	addw	sp,#1
1322  00e0 81            	ret	
1357                     ; 479 void SPI_ClearFlag(SPI_Flag_TypeDef SPI_FLAG)
1357                     ; 480 {
1358                     	switch	.text
1359  00e1               _SPI_ClearFlag:
1363                     ; 481   assert_param(IS_SPI_CLEAR_FLAGS_OK(SPI_FLAG));
1365                     ; 483   SPI->SR = (u8)(~SPI_FLAG);
1367  00e1 43            	cpl	a
1368  00e2 c75203        	ld	20995,a
1369                     ; 484 }
1372  00e5 81            	ret	
1446                     ; 509 ITStatus SPI_GetITStatus(SPI_IT_TypeDef SPI_IT)
1446                     ; 510 {
1447                     	switch	.text
1448  00e6               _SPI_GetITStatus:
1450  00e6 88            	push	a
1451  00e7 89            	pushw	x
1452       00000002      OFST:	set	2
1455                     ; 511   ITStatus pendingbitstatus = RESET;
1457                     ; 512   u8 itpos = 0;
1459                     ; 513   u8 itmask1 = 0;
1461                     ; 514   u8 itmask2 = 0;
1463                     ; 515   u8 enablestatus = 0;
1465                     ; 516   assert_param(IS_SPI_GET_IT_OK(SPI_IT));
1467                     ; 518   itpos = (u8)((u8)1 << ((u8)SPI_IT & (u8)0x0F));
1469  00e8 7b03          	ld	a,(OFST+1,sp)
1470  00ea a40f          	and	a,#15
1471  00ec 5f            	clrw	x
1472  00ed 97            	ld	xl,a
1473  00ee a601          	ld	a,#1
1474  00f0 5d            	tnzw	x
1475  00f1 2704          	jreq	L65
1476  00f3               L06:
1477  00f3 48            	sll	a
1478  00f4 5a            	decw	x
1479  00f5 26fc          	jrne	L06
1480  00f7               L65:
1481  00f7 6b01          	ld	(OFST-1,sp),a
1482                     ; 521   itmask1 = (u8)((u8)SPI_IT >> (u8)4);
1484  00f9 7b03          	ld	a,(OFST+1,sp)
1485  00fb 4e            	swap	a
1486  00fc a40f          	and	a,#15
1487  00fe 6b02          	ld	(OFST+0,sp),a
1488                     ; 523   itmask2 = (u8)((u8)1 << itmask1);
1490  0100 5f            	clrw	x
1491  0101 97            	ld	xl,a
1492  0102 a601          	ld	a,#1
1493  0104 5d            	tnzw	x
1494  0105 2704          	jreq	L26
1495  0107               L46:
1496  0107 48            	sll	a
1497  0108 5a            	decw	x
1498  0109 26fc          	jrne	L46
1499  010b               L26:
1500                     ; 525   enablestatus = (u8)((u8)SPI->ICR & itmask2);
1502  010b c45202        	and	a,20994
1503  010e 6b02          	ld	(OFST+0,sp),a
1504                     ; 527   if (((SPI->SR & itpos) != RESET) && enablestatus)
1506  0110 c65203        	ld	a,20995
1507  0113 1501          	bcp	a,(OFST-1,sp)
1508  0115 2708          	jreq	L746
1510  0117 7b02          	ld	a,(OFST+0,sp)
1511  0119 2704          	jreq	L746
1512                     ; 530     pendingbitstatus = SET;
1514  011b a601          	ld	a,#1
1516  011d 2001          	jra	L156
1517  011f               L746:
1518                     ; 535     pendingbitstatus = RESET;
1520  011f 4f            	clr	a
1521  0120               L156:
1522                     ; 538   return  pendingbitstatus;
1526  0120 5b03          	addw	sp,#3
1527  0122 81            	ret	
1570                     ; 564 void SPI_ClearITPendingBit(SPI_IT_TypeDef SPI_IT)
1570                     ; 565 {
1571                     	switch	.text
1572  0123               _SPI_ClearITPendingBit:
1574  0123 88            	push	a
1575       00000001      OFST:	set	1
1578                     ; 566   u8 itpos = 0;
1580  0124 0f01          	clr	(OFST+0,sp)
1581                     ; 567   assert_param(IS_SPI_CLEAR_IT_OK(SPI_IT));
1583                     ; 572   itpos = (u8)((u8)1 << (((u8)SPI_IT & (u8)0xF0) >> 4));
1585  0126 4e            	swap	a
1586  0127 a40f          	and	a,#15
1587  0129 5f            	clrw	x
1588  012a 97            	ld	xl,a
1589  012b a601          	ld	a,#1
1590  012d 5d            	tnzw	x
1591  012e 2704          	jreq	L07
1592  0130               L27:
1593  0130 48            	sll	a
1594  0131 5a            	decw	x
1595  0132 26fc          	jrne	L27
1596  0134               L07:
1597                     ; 574   SPI->SR = (u8)(~itpos);
1599  0134 43            	cpl	a
1600  0135 c75203        	ld	20995,a
1601                     ; 576 }
1604  0138 84            	pop	a
1605  0139 81            	ret	
1618                     	xdef	_SPI_ClearITPendingBit
1619                     	xdef	_SPI_GetITStatus
1620                     	xdef	_SPI_ClearFlag
1621                     	xdef	_SPI_GetFlagStatus
1622                     	xdef	_SPI_BiDirectionalLineConfig
1623                     	xdef	_SPI_GetCRCPolynomial
1624                     	xdef	_SPI_ResetCRC
1625                     	xdef	_SPI_GetCRC
1626                     	xdef	_SPI_CalculateCRCCmd
1627                     	xdef	_SPI_TransmitCRC
1628                     	xdef	_SPI_NSSInternalSoftwareCmd
1629                     	xdef	_SPI_ReceiveData
1630                     	xdef	_SPI_SendData
1631                     	xdef	_SPI_ITConfig
1632                     	xdef	_SPI_Cmd
1633                     	xdef	_SPI_Init
1634                     	xdef	_SPI_DeInit
1653                     	end
