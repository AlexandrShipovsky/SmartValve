   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.6 - 08 Apr 2008
   3                     ; Optimizer V4.2.6 - 08 Apr 2008
  33                     ; 65 void ADC2_DeInit(void)
  33                     ; 66 {
  35                     	switch	.text
  36  0000               _ADC2_DeInit:
  40                     ; 67   ADC2->CSR  = ADC2_CSR_RESET_VALUE;
  42  0000 725f5400      	clr	21504
  43                     ; 68   ADC2->CR1  = ADC2_CR1_RESET_VALUE;
  45  0004 725f5401      	clr	21505
  46                     ; 69   ADC2->CR2  = ADC2_CR2_RESET_VALUE;
  48  0008 725f5402      	clr	21506
  49                     ; 70   ADC2->TDRH = ADC2_TDRH_RESET_VALUE;
  51  000c 725f5406      	clr	21510
  52                     ; 71   ADC2->TDRL = ADC2_TDRL_RESET_VALUE;
  54  0010 725f5407      	clr	21511
  55                     ; 72 }
  58  0014 81            	ret	
 583                     ; 107 void ADC2_Init(ADC2_ConvMode_TypeDef ADC2_ConversionMode, ADC2_Channel_TypeDef ADC2_Channel, ADC2_PresSel_TypeDef ADC2_PrescalerSelection, ADC2_ExtTrig_TypeDef ADC2_ExtTrigger, FunctionalState ADC2_ExtTrigState, ADC2_Align_TypeDef ADC2_Align, ADC2_SchmittTrigg_TypeDef ADC2_SchmittTriggerChannel, FunctionalState ADC2_SchmittTriggerState)
 583                     ; 108 {
 584                     	switch	.text
 585  0015               _ADC2_Init:
 587  0015 89            	pushw	x
 588       00000000      OFST:	set	0
 591                     ; 111   assert_param(IS_ADC2_CONVERSIONMODE_OK(ADC2_ConversionMode));
 593                     ; 112   assert_param(IS_ADC2_CHANNEL_OK(ADC2_Channel));
 595                     ; 113   assert_param(IS_ADC2_PRESSEL_OK(ADC2_PrescalerSelection));
 597                     ; 114   assert_param(IS_ADC2_EXTTRIG_OK(ADC2_ExtTrigger));
 599                     ; 115   assert_param(IS_FUNCTIONALSTATE_OK(((ADC2_ExtTrigState))));
 601                     ; 116   assert_param(IS_ADC2_ALIGN_OK(ADC2_Align));
 603                     ; 117   assert_param(IS_ADC2_SCHMITTTRIG_OK(ADC2_SchmittTriggerChannel));
 605                     ; 118   assert_param(IS_FUNCTIONALSTATE_OK(ADC2_SchmittTriggerState));
 607                     ; 123   ADC2_ConversionConfig(ADC2_ConversionMode, ADC2_Channel, ADC2_Align);
 609  0016 7b08          	ld	a,(OFST+8,sp)
 610  0018 88            	push	a
 611  0019 7b02          	ld	a,(OFST+2,sp)
 612  001b 95            	ld	xh,a
 613  001c cd00e3        	call	_ADC2_ConversionConfig
 615  001f 84            	pop	a
 616                     ; 125   ADC2_PrescalerConfig(ADC2_PrescalerSelection);
 618  0020 7b05          	ld	a,(OFST+5,sp)
 619  0022 ad31          	call	_ADC2_PrescalerConfig
 621                     ; 130   ADC2_ExternalTriggerConfig(ADC2_ExtTrigger, ADC2_ExtTrigState);
 623  0024 7b07          	ld	a,(OFST+7,sp)
 624  0026 97            	ld	xl,a
 625  0027 7b06          	ld	a,(OFST+6,sp)
 626  0029 95            	ld	xh,a
 627  002a cd0110        	call	_ADC2_ExternalTriggerConfig
 629                     ; 135   ADC2_SchmittTriggerConfig(ADC2_SchmittTriggerChannel, ADC2_SchmittTriggerState);
 631  002d 7b0a          	ld	a,(OFST+10,sp)
 632  002f 97            	ld	xl,a
 633  0030 7b09          	ld	a,(OFST+9,sp)
 634  0032 95            	ld	xh,a
 635  0033 ad33          	call	_ADC2_SchmittTriggerConfig
 637                     ; 138   ADC2->CR1 |= ADC2_CR1_ADON;
 639  0035 72105401      	bset	21505,#0
 640                     ; 140 }
 643  0039 85            	popw	x
 644  003a 81            	ret	
 679                     ; 157 void ADC2_Cmd(FunctionalState NewState)
 679                     ; 158 {
 680                     	switch	.text
 681  003b               _ADC2_Cmd:
 685                     ; 161   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 687                     ; 163   if (NewState != DISABLE)
 689  003b 4d            	tnz	a
 690  003c 2705          	jreq	L703
 691                     ; 165     ADC2->CR1 |= ADC2_CR1_ADON;
 693  003e 72105401      	bset	21505,#0
 696  0042 81            	ret	
 697  0043               L703:
 698                     ; 169     ADC2->CR1 &= (u8)(~ADC2_CR1_ADON);
 700  0043 72115401      	bres	21505,#0
 701                     ; 172 }
 704  0047 81            	ret	
 739                     ; 192 void ADC2_ITConfig(FunctionalState ADC2_ITEnable)
 739                     ; 193 {
 740                     	switch	.text
 741  0048               _ADC2_ITConfig:
 745                     ; 196   assert_param(IS_FUNCTIONALSTATE_OK(ADC2_ITEnable));
 747                     ; 198   if (ADC2_ITEnable != DISABLE)
 749  0048 4d            	tnz	a
 750  0049 2705          	jreq	L133
 751                     ; 201     ADC2->CSR |= (u8)ADC2_CSR_EOCIE;
 753  004b 721a5400      	bset	21504,#5
 756  004f 81            	ret	
 757  0050               L133:
 758                     ; 206     ADC2->CSR &= (u8)(~ADC2_CSR_EOCIE);
 760  0050 721b5400      	bres	21504,#5
 761                     ; 209 }
 764  0054 81            	ret	
 800                     ; 226 void ADC2_PrescalerConfig(ADC2_PresSel_TypeDef ADC2_Prescaler)
 800                     ; 227 {
 801                     	switch	.text
 802  0055               _ADC2_PrescalerConfig:
 804  0055 88            	push	a
 805       00000000      OFST:	set	0
 808                     ; 230   assert_param(IS_ADC2_PRESSEL_OK(ADC2_Prescaler));
 810                     ; 233   ADC2->CR1 &= (u8)(~ADC2_CR1_SPSEL);
 812  0056 c65401        	ld	a,21505
 813  0059 a48f          	and	a,#143
 814  005b c75401        	ld	21505,a
 815                     ; 235   ADC2->CR1 |= (u8)(ADC2_Prescaler);
 817  005e c65401        	ld	a,21505
 818  0061 1a01          	or	a,(OFST+1,sp)
 819  0063 c75401        	ld	21505,a
 820                     ; 237 }
 823  0066 84            	pop	a
 824  0067 81            	ret	
 872                     ; 257 void ADC2_SchmittTriggerConfig(ADC2_SchmittTrigg_TypeDef ADC2_SchmittTriggerChannel, FunctionalState ADC2_SchmittTriggerState)
 872                     ; 258 {
 873                     	switch	.text
 874  0068               _ADC2_SchmittTriggerConfig:
 876  0068 89            	pushw	x
 877       00000000      OFST:	set	0
 880                     ; 261   assert_param(IS_ADC2_SCHMITTTRIG_OK(ADC2_SchmittTriggerChannel));
 882                     ; 262   assert_param(IS_FUNCTIONALSTATE_OK(ADC2_SchmittTriggerState));
 884                     ; 264   if (ADC2_SchmittTriggerChannel == ADC2_SCHMITTTRIG_ALL)
 886  0069 9e            	ld	a,xh
 887  006a a11f          	cp	a,#31
 888  006c 261d          	jrne	L573
 889                     ; 266     if (ADC2_SchmittTriggerState != DISABLE)
 891  006e 9f            	ld	a,xl
 892  006f 4d            	tnz	a
 893  0070 270a          	jreq	L773
 894                     ; 268       ADC2->TDRL &= (u8)0x0;
 896  0072 725f5407      	clr	21511
 897                     ; 269       ADC2->TDRH &= (u8)0x0;
 899  0076 725f5406      	clr	21510
 901  007a 2065          	jra	L304
 902  007c               L773:
 903                     ; 273       ADC2->TDRL |= (u8)0xFF;
 905  007c c65407        	ld	a,21511
 906  007f aaff          	or	a,#255
 907  0081 c75407        	ld	21511,a
 908                     ; 274       ADC2->TDRH |= (u8)0xFF;
 910  0084 c65406        	ld	a,21510
 911  0087 aaff          	or	a,#255
 912  0089 2053          	jp	LC001
 913  008b               L573:
 914                     ; 277   else if (ADC2_SchmittTriggerChannel < ADC2_SCHMITTTRIG_CHANNEL8)
 916  008b 7b01          	ld	a,(OFST+1,sp)
 917  008d a108          	cp	a,#8
 918  008f 0d02          	tnz	(OFST+2,sp)
 919  0091 2426          	jruge	L504
 920                     ; 279     if (ADC2_SchmittTriggerState != DISABLE)
 922  0093 2714          	jreq	L704
 923                     ; 281       ADC2->TDRL &= (u8)(~(u8)((u8)0x01 << (u8)ADC2_SchmittTriggerChannel));
 925  0095 5f            	clrw	x
 926  0096 97            	ld	xl,a
 927  0097 a601          	ld	a,#1
 928  0099 5d            	tnzw	x
 929  009a 2704          	jreq	L03
 930  009c               L23:
 931  009c 48            	sll	a
 932  009d 5a            	decw	x
 933  009e 26fc          	jrne	L23
 934  00a0               L03:
 935  00a0 43            	cpl	a
 936  00a1 c45407        	and	a,21511
 937  00a4               LC002:
 938  00a4 c75407        	ld	21511,a
 940  00a7 2038          	jra	L304
 941  00a9               L704:
 942                     ; 285       ADC2->TDRL |= (u8)((u8)0x01 << (u8)ADC2_SchmittTriggerChannel);
 944  00a9 5f            	clrw	x
 945  00aa 97            	ld	xl,a
 946  00ab a601          	ld	a,#1
 947  00ad 5d            	tnzw	x
 948  00ae 2704          	jreq	L43
 949  00b0               L63:
 950  00b0 48            	sll	a
 951  00b1 5a            	decw	x
 952  00b2 26fc          	jrne	L63
 953  00b4               L43:
 954  00b4 ca5407        	or	a,21511
 955  00b7 20eb          	jp	LC002
 956  00b9               L504:
 957                     ; 290     if (ADC2_SchmittTriggerState != DISABLE)
 959  00b9 2713          	jreq	L514
 960                     ; 292       ADC2->TDRH &= (u8)(~(u8)((u8)0x01 << ((u8)ADC2_SchmittTriggerChannel - (u8)8)));
 962  00bb a008          	sub	a,#8
 963  00bd 5f            	clrw	x
 964  00be 97            	ld	xl,a
 965  00bf a601          	ld	a,#1
 966  00c1 5d            	tnzw	x
 967  00c2 2704          	jreq	L04
 968  00c4               L24:
 969  00c4 48            	sll	a
 970  00c5 5a            	decw	x
 971  00c6 26fc          	jrne	L24
 972  00c8               L04:
 973  00c8 43            	cpl	a
 974  00c9 c45406        	and	a,21510
 976  00cc 2010          	jp	LC001
 977  00ce               L514:
 978                     ; 296       ADC2->TDRH |= (u8)((u8)0x01 << ((u8)ADC2_SchmittTriggerChannel - (u8)8));
 980  00ce a008          	sub	a,#8
 981  00d0 5f            	clrw	x
 982  00d1 97            	ld	xl,a
 983  00d2 a601          	ld	a,#1
 984  00d4 5d            	tnzw	x
 985  00d5 2704          	jreq	L44
 986  00d7               L64:
 987  00d7 48            	sll	a
 988  00d8 5a            	decw	x
 989  00d9 26fc          	jrne	L64
 990  00db               L44:
 991  00db ca5406        	or	a,21510
 992  00de               LC001:
 993  00de c75406        	ld	21510,a
 994  00e1               L304:
 995                     ; 300 }
 998  00e1 85            	popw	x
 999  00e2 81            	ret	
1056                     ; 322 void ADC2_ConversionConfig(ADC2_ConvMode_TypeDef ADC2_ConversionMode, ADC2_Channel_TypeDef ADC2_Channel, ADC2_Align_TypeDef ADC2_Align)
1056                     ; 323 {
1057                     	switch	.text
1058  00e3               _ADC2_ConversionConfig:
1060       00000000      OFST:	set	0
1063                     ; 326   assert_param(IS_ADC2_CONVERSIONMODE_OK(ADC2_ConversionMode));
1065                     ; 327   assert_param(IS_ADC2_CHANNEL_OK(ADC2_Channel));
1067                     ; 328   assert_param(IS_ADC2_ALIGN_OK(ADC2_Align));
1069                     ; 331   ADC2->CR2 &= (u8)(~ADC2_CR2_ALIGN);
1071  00e3 72175402      	bres	21506,#3
1072  00e7 89            	pushw	x
1073                     ; 333   ADC2->CR2 |= (u8)(ADC2_Align);
1075  00e8 c65402        	ld	a,21506
1076  00eb 1a05          	or	a,(OFST+5,sp)
1077  00ed c75402        	ld	21506,a
1078                     ; 335   if (ADC2_ConversionMode == ADC2_CONVERSIONMODE_CONTINUOUS)
1080  00f0 9e            	ld	a,xh
1081  00f1 4a            	dec	a
1082  00f2 2606          	jrne	L744
1083                     ; 338     ADC2->CR1 |= ADC2_CR1_CONT;
1085  00f4 72125401      	bset	21505,#1
1087  00f8 2004          	jra	L154
1088  00fa               L744:
1089                     ; 343     ADC2->CR1 &= (u8)(~ADC2_CR1_CONT);
1091  00fa 72135401      	bres	21505,#1
1092  00fe               L154:
1093                     ; 347   ADC2->CSR &= (u8)(~ADC2_CSR_CH);
1095  00fe c65400        	ld	a,21504
1096  0101 a4f0          	and	a,#240
1097  0103 c75400        	ld	21504,a
1098                     ; 349   ADC2->CSR |= (u8)(ADC2_Channel);
1100  0106 c65400        	ld	a,21504
1101  0109 1a02          	or	a,(OFST+2,sp)
1102  010b c75400        	ld	21504,a
1103                     ; 351 }
1106  010e 85            	popw	x
1107  010f 81            	ret	
1153                     ; 373 void ADC2_ExternalTriggerConfig(ADC2_ExtTrig_TypeDef ADC2_ExtTrigger, FunctionalState ADC2_ExtTrigState)
1153                     ; 374 {
1154                     	switch	.text
1155  0110               _ADC2_ExternalTriggerConfig:
1157  0110 89            	pushw	x
1158       00000000      OFST:	set	0
1161                     ; 377   assert_param(IS_ADC2_EXTTRIG_OK(ADC2_ExtTrigger));
1163                     ; 378   assert_param(IS_FUNCTIONALSTATE_OK(ADC2_ExtTrigState));
1165                     ; 381   ADC2->CR2 &= (u8)(~ADC2_CR2_EXTSEL);
1167  0111 c65402        	ld	a,21506
1168  0114 a4cf          	and	a,#207
1169  0116 c75402        	ld	21506,a
1170                     ; 383   if (ADC2_ExtTrigState != DISABLE)
1172  0119 9f            	ld	a,xl
1173  011a 4d            	tnz	a
1174  011b 2706          	jreq	L574
1175                     ; 386     ADC2->CR2 |= (u8)(ADC2_CR2_EXTTRIG);
1177  011d 721c5402      	bset	21506,#6
1179  0121 2004          	jra	L774
1180  0123               L574:
1181                     ; 391     ADC2->CR2 &= (u8)(~ADC2_CR2_EXTTRIG);
1183  0123 721d5402      	bres	21506,#6
1184  0127               L774:
1185                     ; 395   ADC2->CR2 |= (u8)(ADC2_ExtTrigger);
1187  0127 c65402        	ld	a,21506
1188  012a 1a01          	or	a,(OFST+1,sp)
1189  012c c75402        	ld	21506,a
1190                     ; 397 }
1193  012f 85            	popw	x
1194  0130 81            	ret	
1218                     ; 417 void ADC2_StartConversion(void)
1218                     ; 418 {
1219                     	switch	.text
1220  0131               _ADC2_StartConversion:
1224                     ; 419   ADC2->CR1 |= ADC2_CR1_ADON;
1226  0131 72105401      	bset	21505,#0
1227                     ; 420 }
1230  0135 81            	ret	
1270                     ; 438 u16 ADC2_GetConversionValue(void)
1270                     ; 439 {
1271                     	switch	.text
1272  0136               _ADC2_GetConversionValue:
1274  0136 5205          	subw	sp,#5
1275       00000005      OFST:	set	5
1278                     ; 441   u16 temph = 0;
1280                     ; 442   u8 templ = 0;
1282                     ; 444   if (ADC2->CR2 & ADC2_CR2_ALIGN) /* Right alignment */
1284  0138 720754020e    	btjf	21506,#3,L725
1285                     ; 447     templ = ADC2->DRL;
1287  013d c65405        	ld	a,21509
1288  0140 6b03          	ld	(OFST-2,sp),a
1289                     ; 449     temph = ADC2->DRH;
1291  0142 c65404        	ld	a,21508
1292  0145 97            	ld	xl,a
1293                     ; 451     temph = (u16)(templ | (u16)(temph << (u8)8));
1295  0146 7b03          	ld	a,(OFST-2,sp)
1296  0148 02            	rlwa	x,a
1298  0149 201a          	jra	L135
1299  014b               L725:
1300                     ; 456     temph = ADC2->DRH;
1302  014b c65404        	ld	a,21508
1303  014e 97            	ld	xl,a
1304                     ; 458     templ = ADC2->DRL;
1306  014f c65405        	ld	a,21509
1307  0152 6b03          	ld	(OFST-2,sp),a
1308                     ; 460     temph = (u16)((u16)(templ << (u8)6) | (u16)(temph << (u8)8));
1310  0154 4f            	clr	a
1311  0155 02            	rlwa	x,a
1312  0156 1f01          	ldw	(OFST-4,sp),x
1313  0158 7b03          	ld	a,(OFST-2,sp)
1314  015a 97            	ld	xl,a
1315  015b a640          	ld	a,#64
1316  015d 42            	mul	x,a
1317  015e 01            	rrwa	x,a
1318  015f 1a02          	or	a,(OFST-3,sp)
1319  0161 01            	rrwa	x,a
1320  0162 1a01          	or	a,(OFST-4,sp)
1321  0164 01            	rrwa	x,a
1322  0165               L135:
1323                     ; 463   return ((u16)temph);
1327  0165 5b05          	addw	sp,#5
1328  0167 81            	ret	
1372                     ; 483 FlagStatus ADC2_GetFlagStatus(void)
1372                     ; 484 {
1373                     	switch	.text
1374  0168               _ADC2_GetFlagStatus:
1378                     ; 486   return ((u8)(ADC2->CSR & ADC2_CSR_EOC));
1380  0168 c65400        	ld	a,21504
1381  016b a480          	and	a,#128
1384  016d 81            	ret	
1407                     ; 505 void ADC2_ClearFlag(void)
1407                     ; 506 {
1408                     	switch	.text
1409  016e               _ADC2_ClearFlag:
1413                     ; 507     ADC2->CSR &= (u8)(~ADC2_CSR_EOC);
1415  016e 721f5400      	bres	21504,#7
1416                     ; 508 }
1419  0172 81            	ret	
1443                     ; 526 ITStatus ADC2_GetITStatus(void)
1443                     ; 527 {
1444                     	switch	.text
1445  0173               _ADC2_GetITStatus:
1449                     ; 528   return ((u8)(ADC2->CSR & ADC2_CSR_EOC));
1451  0173 c65400        	ld	a,21504
1452  0176 a480          	and	a,#128
1455  0178 81            	ret	
1479                     ; 546 void ADC2_ClearITPendingBit(void)
1479                     ; 547 {
1480                     	switch	.text
1481  0179               _ADC2_ClearITPendingBit:
1485                     ; 548     ADC2->CSR &= (u8)(~ADC2_CSR_EOC);
1487  0179 721f5400      	bres	21504,#7
1488                     ; 549 }
1491  017d 81            	ret	
1504                     	xdef	_ADC2_ClearITPendingBit
1505                     	xdef	_ADC2_GetITStatus
1506                     	xdef	_ADC2_ClearFlag
1507                     	xdef	_ADC2_GetFlagStatus
1508                     	xdef	_ADC2_GetConversionValue
1509                     	xdef	_ADC2_StartConversion
1510                     	xdef	_ADC2_ExternalTriggerConfig
1511                     	xdef	_ADC2_ConversionConfig
1512                     	xdef	_ADC2_SchmittTriggerConfig
1513                     	xdef	_ADC2_PrescalerConfig
1514                     	xdef	_ADC2_ITConfig
1515                     	xdef	_ADC2_Cmd
1516                     	xdef	_ADC2_Init
1517                     	xdef	_ADC2_DeInit
1536                     	end
