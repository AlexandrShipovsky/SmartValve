   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.6 - 08 Apr 2008
   3                     ; Optimizer V4.2.6 - 08 Apr 2008
   5                     	switch	.data
   6  0000               _param:
   7  0000 00            	dc.b	0
   8  0001 06            	dc.b	6
   9  0002 0000          	dc.w	0
  10  0004 0000          	dc.w	0
  11  0006 0000          	dc.w	0
  12  0008 00            	dc.b	0
  13  0009 0000          	dc.w	0
  14  000b 00            	dc.b	0
  15  000c 0000          	dc.w	0
  16  000e 42480000      	dc.w	16968,0
  17  0012 00000000      	dc.w	0,0
  18  0016 00000000      	dc.w	0,0
  19  001a 00000000      	dc.w	0,0
  20  001e 0000          	dc.w	0
  59                     ; 36 void SetCPUClock(unsigned char IntExt)
  59                     ; 37 {
  61                     	switch	.text
  62  0000               _SetCPUClock:
  66                     ; 38   if (IntExt)
  68  0000 4d            	tnz	a
  69  0001 270a          	jreq	L52
  70                     ; 40     CLK->CKDIVR = 0x00; // Fcpu = FHSI
  72  0003 725f50c6      	clr	20678
  74  0007               L33:
  75                     ; 41     while(CLK->CCOR & CLK_CCOR_CCOBSY);
  77  0007 720c50c9fb    	btjt	20681,#6,L33
  79                     ; 58 }
  82  000c 81            	ret	
  83  000d               L52:
  84                     ; 46     CLK->ECKR  = 0x04;
  86  000d 350450c1      	mov	20673,#4
  87                     ; 47     _asm("NOP");
  90  0011 9d            	nop	
  92                     ; 48     CLK->ECKR |= 0x01;
  94  0012 721050c1      	bset	20673,#0
  96  0016               L34:
  97                     ; 50     while (!(CLK->ECKR & 0x2));
  99  0016 720350c1fb    	btjf	20673,#1,L34
 100                     ; 52     CLK->SWCR = 0x02;
 102  001b 350250c5      	mov	20677,#2
 103                     ; 54     CLK->SWR   = 0xB4;
 105  001f 35b450c4      	mov	20676,#180
 107  0023               L35:
 108                     ; 55     while (CLK->SWCR & 0x01);
 110  0023 720050c5fb    	btjt	20677,#0,L35
 112  0028               L16:
 113                     ; 56     while(CLK->CMSR != 0xB4);
 115  0028 c650c3        	ld	a,20675
 116  002b a1b4          	cp	a,#180
 117  002d 26f9          	jrne	L16
 119  002f 81            	ret	
 305                     ; 61 unsigned int AllocateDataBuffer(PParam pparam)
 305                     ; 62 {
 306                     	switch	.text
 307  0030               _AllocateDataBuffer:
 309  0030 89            	pushw	x
 310  0031 5208          	subw	sp,#8
 311       00000008      OFST:	set	8
 314                     ; 65     unsigned long MAXSAMPLES = pparam->NumOfConversions;  //   NUMBER OF REQUESTED CONVERSIONS
 316  0033 ee09          	ldw	x,(9,x)
 317  0035 cd0000        	call	c_uitolx
 319  0038 96            	ldw	x,sp
 320  0039 1c0005        	addw	x,#OFST-3
 321  003c cd0000        	call	c_rtol
 323                     ; 66     unsigned long sizeoriginBuf = 4*MAXSAMPLES+2;
 325  003f 96            	ldw	x,sp
 326  0040 1c0005        	addw	x,#OFST-3
 327  0043 cd0000        	call	c_ltor
 329  0046 a602          	ld	a,#2
 330  0048 cd0000        	call	c_llsh
 332  004b a602          	ld	a,#2
 333  004d cd0000        	call	c_ladc
 335  0050 96            	ldw	x,sp
 336  0051 1c0005        	addw	x,#OFST-3
 337  0054 cd0000        	call	c_rtol
 339                     ; 67     pparam->LengthADCData = sizeoriginBuf;
 341  0057 1e09          	ldw	x,(OFST+1,sp)
 342  0059 1607          	ldw	y,(OFST-1,sp)
 343  005b ef04          	ldw	(4,x),y
 344                     ; 68     if ((originBuf = (signed int * )malloc(sizeoriginBuf)) == NULL)
 346  005d 1e07          	ldw	x,(OFST-1,sp)
 347  005f cd0000        	call	_malloc
 349  0062 1f03          	ldw	(OFST-5,sp),x
 350  0064 261b          	jrne	L561
 351                     ; 70       pparam->LengthADCData = 0;
 353  0066 1e09          	ldw	x,(OFST+1,sp)
 354  0068 905f          	clrw	y
 355  006a ef04          	ldw	(4,x),y
 356                     ; 71       pparam->AddrADCDataStart = 0;
 358  006c ef02          	ldw	(2,x),y
 359                     ; 72       pparam->AddrADCDataStartNoAlign = 0;
 361  006e ef06          	ldw	(6,x),y
 362                     ; 73       pparam->ErrNumber = error_allocation;
 364  0070 90ae000c      	ldw	y,#12
 365  0074 ef1e          	ldw	(30,x),y
 366                     ; 74       printf("Memory allocated error\n");
 368  0076 ae0032        	ldw	x,#L761
 369  0079 cd0000        	call	_printf
 371                     ; 75       return(error_allocation);
 373  007c ae000c        	ldw	x,#12
 375  007f 2011          	jra	L41
 376  0081               L561:
 377                     ; 77     databuf = originBuf;
 379  0081 1f01          	ldw	(OFST-7,sp),x
 380                     ; 79     pparam->AddrADCDataStart = databuf;
 382  0083 1e09          	ldw	x,(OFST+1,sp)
 383  0085 1601          	ldw	y,(OFST-7,sp)
 384  0087 ef02          	ldw	(2,x),y
 385                     ; 80     pparam->AddrADCDataStartNoAlign = originBuf;
 387  0089 1603          	ldw	y,(OFST-5,sp)
 388  008b ef06          	ldw	(6,x),y
 389                     ; 81     pparam->ErrNumber = 0;     // (if =0 => no errors)
 391  008d 905f          	clrw	y
 392  008f ef1e          	ldw	(30,x),y
 393                     ; 82 return(0);
 395  0091 5f            	clrw	x
 397  0092               L41:
 399  0092 5b0a          	addw	sp,#10
 400  0094 81            	ret	
 450                     ; 86 unsigned int UnAllocateDataBuffer(PParam pparam)
 450                     ; 87 {
 451                     	switch	.text
 452  0095               _UnAllocateDataBuffer:
 454  0095 89            	pushw	x
 455  0096 89            	pushw	x
 456       00000002      OFST:	set	2
 459                     ; 90   if (!pparam->AddrADCDataStartNoAlign)
 461  0097 e607          	ld	a,(7,x)
 462  0099 ea06          	or	a,(6,x)
 463  009b 260b          	jrne	L512
 464                     ; 91   { printf("Memory unallocated error\n");
 466  009d ae0018        	ldw	x,#L712
 467  00a0 cd0000        	call	_printf
 469                     ; 92     return(error_unallocation);
 471  00a3 ae000d        	ldw	x,#13
 473  00a6 2016          	jra	L42
 474  00a8               L512:
 475                     ; 94   originBuf = pparam->AddrADCDataStartNoAlign;
 477  00a8 1e03          	ldw	x,(OFST+1,sp)
 478  00aa ee06          	ldw	x,(6,x)
 479  00ac 1f01          	ldw	(OFST-1,sp),x
 480                     ; 95   free((void *)originBuf);
 482  00ae cd0000        	call	_free
 484                     ; 96   pparam->LengthADCData = 0;
 486  00b1 1e03          	ldw	x,(OFST+1,sp)
 487  00b3 905f          	clrw	y
 488  00b5 ef04          	ldw	(4,x),y
 489                     ; 97   pparam->AddrADCDataStart = 0;
 491  00b7 ef02          	ldw	(2,x),y
 492                     ; 98   pparam->AddrADCDataStartNoAlign = 0;
 494  00b9 ef06          	ldw	(6,x),y
 495                     ; 99   pparam->ErrNumber = 0;     // (if =0 => no errors)
 497  00bb ef1e          	ldw	(30,x),y
 498                     ; 100   return(0);
 500  00bd 5f            	clrw	x
 502  00be               L42:
 504  00be 5b04          	addw	sp,#4
 505  00c0 81            	ret	
 544                     ; 106 void GetDataFromEvalBoard(PParam pparam)
 544                     ; 107 {
 545                     	switch	.text
 546  00c1               _GetDataFromEvalBoard:
 550                     ; 108   ADCStart();
 553                     ; 109 }//GetDataFromEvalBoard
 556  00c1 cc0000        	jp	_ADCStart
 596                     ; 113 void *AllocateEvalBoardBuffer(PParam pparam)
 596                     ; 114 {
 597                     	switch	.text
 598  00c4               _AllocateEvalBoardBuffer:
 600  00c4 89            	pushw	x
 601       00000000      OFST:	set	0
 604                     ; 115   AllocateDataBuffer(pparam);
 606  00c5 cd0030        	call	_AllocateDataBuffer
 608                     ; 116   return(pparam->AddrADCDataStart);
 610  00c8 1e01          	ldw	x,(OFST+1,sp)
 613  00ca 5b02          	addw	sp,#2
 614  00cc ee02          	ldw	x,(2,x)
 615  00ce 81            	ret	
 652                     ; 121 unsigned char ConvertInProgress(PParam pparam)
 652                     ; 122 {
 653                     	switch	.text
 654  00cf               _ConvertInProgress:
 658                     ; 123   return(!pparam->EndOfAllConversions);
 660  00cf e60b          	ld	a,(11,x)
 661  00d1 2602          	jrne	L04
 662  00d3 4c            	inc	a
 664  00d4 81            	ret	
 665  00d5               L04:
 666  00d5 4f            	clr	a
 669  00d6 81            	ret	
 746                     ; 128 unsigned int InitEvalBoardcard(PParam pparam, unsigned int channels, unsigned int samplesperperiod, double * error)
 746                     ; 129 {
 747                     	switch	.text
 748  00d7               _InitEvalBoardcard:
 750  00d7 89            	pushw	x
 751  00d8 5210          	subw	sp,#16
 752       00000010      OFST:	set	16
 755                     ; 130   double fvzmax=F_SAMPL_MAX;
 757  00da ce0016        	ldw	x,L143+2
 758  00dd 1f07          	ldw	(OFST-9,sp),x
 759  00df ce0014        	ldw	x,L143
 760  00e2 1f05          	ldw	(OFST-11,sp),x
 761                     ; 132   unsigned int periods=0;
 763  00e4 5f            	clrw	x
 764  00e5 1f09          	ldw	(OFST-7,sp),x
 765  00e7               L543:
 766                     ; 136     periods++;
 768  00e7 1e09          	ldw	x,(OFST-7,sp)
 769  00e9 5c            	incw	x
 770  00ea 1f09          	ldw	(OFST-7,sp),x
 771                     ; 137     divider= pparam->NormalFrequency / pparam->TriggerFrequency;
 773  00ec 1e11          	ldw	x,(OFST+1,sp)
 774  00ee 1c0012        	addw	x,#18
 775  00f1 cd0000        	call	c_ltor
 777  00f4 1e11          	ldw	x,(OFST+1,sp)
 778  00f6 1c0016        	addw	x,#22
 779  00f9 cd0000        	call	c_fdiv
 781  00fc 96            	ldw	x,sp
 782  00fd 1c000d        	addw	x,#OFST-3
 783  0100 cd0000        	call	c_rtol
 785                     ; 139   } while((pparam->NormalFrequency/divider)>fvzmax);
 787  0103 1e11          	ldw	x,(OFST+1,sp)
 788  0105 1c0012        	addw	x,#18
 789  0108 cd0000        	call	c_ltor
 791  010b 96            	ldw	x,sp
 792  010c 1c000d        	addw	x,#OFST-3
 793  010f cd0000        	call	c_fdiv
 795  0112 96            	ldw	x,sp
 796  0113 1c0005        	addw	x,#OFST-11
 797  0116 cd0000        	call	c_fcmp
 799  0119 2ccc          	jrsgt	L543
 800                     ; 141   timerCount = ceil(divider);
 802  011b 1e0f          	ldw	x,(OFST-1,sp)
 803  011d 89            	pushw	x
 804  011e 1e0f          	ldw	x,(OFST-1,sp)
 805  0120 89            	pushw	x
 806  0121 cd0000        	call	_ceil
 808  0124 5b04          	addw	sp,#4
 809  0126 cd0000        	call	c_ftoi
 811  0129 1f0b          	ldw	(OFST-5,sp),x
 812                     ; 142   * error = ((double)(timerCount)-divider) / (double)(timerCount);
 814  012b cd0000        	call	c_uitof
 816  012e 96            	ldw	x,sp
 817  012f 5c            	incw	x
 818  0130 cd0000        	call	c_rtol
 820  0133 1e0b          	ldw	x,(OFST-5,sp)
 821  0135 cd0000        	call	c_uitof
 823  0138 96            	ldw	x,sp
 824  0139 1c000d        	addw	x,#OFST-3
 825  013c cd0000        	call	c_fsub
 827  013f 96            	ldw	x,sp
 828  0140 5c            	incw	x
 829  0141 cd0000        	call	c_fdiv
 831  0144 1e19          	ldw	x,(OFST+9,sp)
 832  0146 cd0000        	call	c_rtol
 834                     ; 144     InitADCTimerTrigger(pparam, timerCount);
 836  0149 1e0b          	ldw	x,(OFST-5,sp)
 837  014b 89            	pushw	x
 838  014c 1e13          	ldw	x,(OFST+3,sp)
 839  014e cd0000        	call	_InitADCTimerTrigger
 841  0151 85            	popw	x
 842                     ; 147 return(periods);
 844  0152 1e09          	ldw	x,(OFST-7,sp)
 847  0154 5b12          	addw	sp,#18
 848  0156 81            	ret	
 913                     ; 152 void InitEvalBoardparam(PParam pparam, unsigned int numsamples, unsigned int channels, double signalfrequency, unsigned int periods)
 913                     ; 153 {
 914                     	switch	.text
 915  0157               _InitEvalBoardparam:
 917  0157 89            	pushw	x
 918  0158 5204          	subw	sp,#4
 919       00000004      OFST:	set	4
 922                     ; 154   pparam->NormalFrequency  = F_NORMAL; //frequency of etalon
 924  015a c60013        	ld	a,L704+3
 925  015d e715          	ld	(21,x),a
 926  015f c60012        	ld	a,L704+2
 927  0162 e714          	ld	(20,x),a
 928  0164 c60011        	ld	a,L704+1
 929  0167 e713          	ld	(19,x),a
 930  0169 c60010        	ld	a,L704
 931  016c e712          	ld	(18,x),a
 932                     ; 155   pparam->NumOfConversions = (numsamples*channels);
 934  016e 160b          	ldw	y,(OFST+7,sp)
 935  0170 1e09          	ldw	x,(OFST+5,sp)
 936  0172 cd0000        	call	c_imul
 938  0175 1605          	ldw	y,(OFST+1,sp)
 939  0177 90ef09        	ldw	(9,y),x
 940                     ; 156   pparam->TriggerFrequency = (pparam->NumOfConversions*signalfrequency)/periods;
 942  017a 1e11          	ldw	x,(OFST+13,sp)
 943  017c cd0000        	call	c_uitof
 945  017f 96            	ldw	x,sp
 946  0180 5c            	incw	x
 947  0181 cd0000        	call	c_rtol
 949  0184 1e05          	ldw	x,(OFST+1,sp)
 950  0186 ee09          	ldw	x,(9,x)
 951  0188 cd0000        	call	c_uitof
 953  018b 96            	ldw	x,sp
 954  018c 1c000d        	addw	x,#OFST+9
 955  018f cd0000        	call	c_fmul
 957  0192 96            	ldw	x,sp
 958  0193 5c            	incw	x
 959  0194 cd0000        	call	c_fdiv
 961  0197 1e05          	ldw	x,(OFST+1,sp)
 962  0199 1c0016        	addw	x,#22
 963  019c cd0000        	call	c_rtol
 965                     ; 157   pparam->SignalFrequency  = signalfrequency;
 967  019f 1e05          	ldw	x,(OFST+1,sp)
 968  01a1 7b10          	ld	a,(OFST+12,sp)
 969  01a3 e711          	ld	(17,x),a
 970  01a5 7b0f          	ld	a,(OFST+11,sp)
 971  01a7 e710          	ld	(16,x),a
 972  01a9 7b0e          	ld	a,(OFST+10,sp)
 973  01ab e70f          	ld	(15,x),a
 974  01ad 7b0d          	ld	a,(OFST+9,sp)
 975  01af e70e          	ld	(14,x),a
 976                     ; 158   pparam->ErrNumber = 0;     // (if =0 => no errors)
 978  01b1 905f          	clrw	y
 979  01b3 ef1e          	ldw	(30,x),y
 980                     ; 159 }//InitEvalBoardparam
 983  01b5 5b06          	addw	sp,#6
 984  01b7 81            	ret	
1067                     ; 163 void GetMinMaxData(signed int *Buffer,unsigned int size,signed int * maximum,signed int * minimum)
1067                     ; 164 {
1068                     	switch	.text
1069  01b8               _GetMinMaxData:
1071  01b8 89            	pushw	x
1072  01b9 5206          	subw	sp,#6
1073       00000006      OFST:	set	6
1076                     ; 165   signed int m= (signed)(-0x8000),n= 32767;
1078  01bb ae8000        	ldw	x,#32768
1079  01be 1f01          	ldw	(OFST-5,sp),x
1082  01c0 5a            	decw	x
1083  01c1 1f03          	ldw	(OFST-3,sp),x
1084                     ; 167   for(i=0;i<size;i++)
1086  01c3 5f            	clrw	x
1088  01c4 2029          	jra	L554
1089  01c6               L154:
1090                     ; 169     if (Buffer[i]>m) m = Buffer[i];
1092  01c6 58            	sllw	x
1093  01c7 72fb07        	addw	x,(OFST+1,sp)
1094  01ca fe            	ldw	x,(x)
1095  01cb 1301          	cpw	x,(OFST-5,sp)
1096  01cd 2d09          	jrsle	L164
1099  01cf 1e05          	ldw	x,(OFST-1,sp)
1100  01d1 58            	sllw	x
1101  01d2 72fb07        	addw	x,(OFST+1,sp)
1102  01d5 fe            	ldw	x,(x)
1103  01d6 1f01          	ldw	(OFST-5,sp),x
1104  01d8               L164:
1105                     ; 170     if (Buffer[i]<n) n = Buffer[i];
1107  01d8 1e05          	ldw	x,(OFST-1,sp)
1108  01da 58            	sllw	x
1109  01db 72fb07        	addw	x,(OFST+1,sp)
1110  01de fe            	ldw	x,(x)
1111  01df 1303          	cpw	x,(OFST-3,sp)
1112  01e1 2e09          	jrsge	L364
1115  01e3 1e05          	ldw	x,(OFST-1,sp)
1116  01e5 58            	sllw	x
1117  01e6 72fb07        	addw	x,(OFST+1,sp)
1118  01e9 fe            	ldw	x,(x)
1119  01ea 1f03          	ldw	(OFST-3,sp),x
1120  01ec               L364:
1121                     ; 167   for(i=0;i<size;i++)
1123  01ec 1e05          	ldw	x,(OFST-1,sp)
1124  01ee 5c            	incw	x
1125  01ef               L554:
1126  01ef 1f05          	ldw	(OFST-1,sp),x
1129  01f1 130b          	cpw	x,(OFST+5,sp)
1130  01f3 25d1          	jrult	L154
1131                     ; 172   * maximum = m;
1133  01f5 1e0d          	ldw	x,(OFST+7,sp)
1134  01f7 1601          	ldw	y,(OFST-5,sp)
1135  01f9 ff            	ldw	(x),y
1136                     ; 173   * minimum = n;
1138  01fa 1e0f          	ldw	x,(OFST+9,sp)
1139  01fc 1603          	ldw	y,(OFST-3,sp)
1140  01fe ff            	ldw	(x),y
1141                     ; 174 }//GetMinMaxData
1144  01ff 5b08          	addw	sp,#8
1145  0201 81            	ret	
1271                     ; 178 unsigned int GetPeriodIndex(signed int *Buffer,unsigned int size,signed int maximum,signed int minimum,double hysteresis)
1271                     ; 179 {
1272                     	switch	.text
1273  0202               _GetPeriodIndex:
1275  0202 89            	pushw	x
1276  0203 5228          	subw	sp,#40
1277       00000028      OFST:	set	40
1280                     ; 180   unsigned long m=0,n=0,minperiod=0,maxperiod=0,middle,minperiodold=0,maxperiodold=0;
1282  0205 5f            	clrw	x
1283  0206 1f0f          	ldw	(OFST-25,sp),x
1284  0208 1f0d          	ldw	(OFST-27,sp),x
1287  020a 1f13          	ldw	(OFST-21,sp),x
1288  020c 1f11          	ldw	(OFST-23,sp),x
1291  020e 1f17          	ldw	(OFST-17,sp),x
1292  0210 1f15          	ldw	(OFST-19,sp),x
1295  0212 1f1b          	ldw	(OFST-13,sp),x
1296  0214 1f19          	ldw	(OFST-15,sp),x
1299  0216 1f21          	ldw	(OFST-7,sp),x
1300  0218 1f1f          	ldw	(OFST-9,sp),x
1303  021a 1f25          	ldw	(OFST-3,sp),x
1304  021c 1f23          	ldw	(OFST-5,sp),x
1305                     ; 184   middle = maximum/2 + minimum/2;
1307  021e a602          	ld	a,#2
1308  0220 1e31          	ldw	x,(OFST+9,sp)
1309  0222 cd0000        	call	c_sdivx
1311  0225 1f07          	ldw	(OFST-33,sp),x
1312  0227 a602          	ld	a,#2
1313  0229 1e2f          	ldw	x,(OFST+7,sp)
1314  022b cd0000        	call	c_sdivx
1316  022e 72fb07        	addw	x,(OFST-33,sp)
1317  0231 cd0000        	call	c_itolx
1319  0234 96            	ldw	x,sp
1320  0235 1c0009        	addw	x,#OFST-31
1321  0238 cd0000        	call	c_rtol
1323                     ; 185   maximum -= (((long)maximum-minimum)*hysteresis);
1325  023b 1e31          	ldw	x,(OFST+9,sp)
1326  023d cd0000        	call	c_itolx
1328  0240 96            	ldw	x,sp
1329  0241 1c0005        	addw	x,#OFST-35
1330  0244 cd0000        	call	c_rtol
1332  0247 1e2f          	ldw	x,(OFST+7,sp)
1333  0249 cd0000        	call	c_itolx
1335  024c 96            	ldw	x,sp
1336  024d 1c0005        	addw	x,#OFST-35
1337  0250 cd0000        	call	c_lsub
1339  0253 cd0000        	call	c_ltof
1341  0256 96            	ldw	x,sp
1342  0257 1c0033        	addw	x,#OFST+11
1343  025a cd0000        	call	c_fmul
1345  025d 96            	ldw	x,sp
1346  025e 5c            	incw	x
1347  025f cd0000        	call	c_rtol
1349  0262 1e2f          	ldw	x,(OFST+7,sp)
1350  0264 cd0000        	call	c_itof
1352  0267 96            	ldw	x,sp
1353  0268 5c            	incw	x
1354  0269 cd0000        	call	c_fsub
1356  026c cd0000        	call	c_ftoi
1358  026f 1f2f          	ldw	(OFST+7,sp),x
1359                     ; 186   minimum += (((long)maximum-minimum)*hysteresis);
1361  0271 1e31          	ldw	x,(OFST+9,sp)
1362  0273 cd0000        	call	c_itolx
1364  0276 96            	ldw	x,sp
1365  0277 1c0005        	addw	x,#OFST-35
1366  027a cd0000        	call	c_rtol
1368  027d 1e2f          	ldw	x,(OFST+7,sp)
1369  027f cd0000        	call	c_itolx
1371  0282 96            	ldw	x,sp
1372  0283 1c0005        	addw	x,#OFST-35
1373  0286 cd0000        	call	c_lsub
1375  0289 cd0000        	call	c_ltof
1377  028c 96            	ldw	x,sp
1378  028d 1c0033        	addw	x,#OFST+11
1379  0290 cd0000        	call	c_fmul
1381  0293 96            	ldw	x,sp
1382  0294 5c            	incw	x
1383  0295 cd0000        	call	c_rtol
1385  0298 1e31          	ldw	x,(OFST+9,sp)
1386  029a cd0000        	call	c_itof
1388  029d 96            	ldw	x,sp
1389  029e 5c            	incw	x
1390  029f cd0000        	call	c_fadd
1392  02a2 cd0000        	call	c_ftoi
1394  02a5 1f31          	ldw	(OFST+9,sp),x
1395                     ; 188   for (i=0;i<size;i++)
1397  02a7 5f            	clrw	x
1399  02a8 cc03f1        	jra	L145
1400  02ab               L535:
1401                     ; 190     vzorka=Buffer[i];
1403  02ab 58            	sllw	x
1404  02ac 72fb29        	addw	x,(OFST+1,sp)
1405  02af fe            	ldw	x,(x)
1406  02b0 1f1d          	ldw	(OFST-11,sp),x
1407                     ; 191     if ((m>=n) && (vzorka<minimum)) n=i;
1409  02b2 96            	ldw	x,sp
1410  02b3 1c000d        	addw	x,#OFST-27
1411  02b6 cd0000        	call	c_ltor
1413  02b9 96            	ldw	x,sp
1414  02ba 1c0011        	addw	x,#OFST-23
1415  02bd cd0000        	call	c_lcmp
1417  02c0 2512          	jrult	L545
1419  02c2 1e1d          	ldw	x,(OFST-11,sp)
1420  02c4 1331          	cpw	x,(OFST+9,sp)
1421  02c6 2e0c          	jrsge	L545
1424  02c8 1e27          	ldw	x,(OFST-1,sp)
1425  02ca cd0000        	call	c_uitolx
1427  02cd 96            	ldw	x,sp
1428  02ce 1c0011        	addw	x,#OFST-23
1429  02d1 cd0000        	call	c_rtol
1431  02d4               L545:
1432                     ; 192     if ((m<=n) && (vzorka>maximum)) m=i;
1434  02d4 96            	ldw	x,sp
1435  02d5 1c000d        	addw	x,#OFST-27
1436  02d8 cd0000        	call	c_ltor
1438  02db 96            	ldw	x,sp
1439  02dc 1c0011        	addw	x,#OFST-23
1440  02df cd0000        	call	c_lcmp
1442  02e2 2212          	jrugt	L745
1444  02e4 1e1d          	ldw	x,(OFST-11,sp)
1445  02e6 132f          	cpw	x,(OFST+7,sp)
1446  02e8 2d0c          	jrsle	L745
1449  02ea 1e27          	ldw	x,(OFST-1,sp)
1450  02ec cd0000        	call	c_uitolx
1452  02ef 96            	ldw	x,sp
1453  02f0 1c000d        	addw	x,#OFST-27
1454  02f3 cd0000        	call	c_rtol
1456  02f6               L745:
1457                     ; 193     if ((m<n) && (maxperiodold>=minperiodold) && (vzorka<=middle))
1459  02f6 96            	ldw	x,sp
1460  02f7 1c000d        	addw	x,#OFST-27
1461  02fa cd0000        	call	c_ltor
1463  02fd 96            	ldw	x,sp
1464  02fe 1c0011        	addw	x,#OFST-23
1465  0301 cd0000        	call	c_lcmp
1467  0304 246c          	jruge	L155
1469  0306 96            	ldw	x,sp
1470  0307 1c0023        	addw	x,#OFST-5
1471  030a cd0000        	call	c_ltor
1473  030d 96            	ldw	x,sp
1474  030e 1c001f        	addw	x,#OFST-9
1475  0311 cd0000        	call	c_lcmp
1477  0314 255c          	jrult	L155
1479  0316 1e1d          	ldw	x,(OFST-11,sp)
1480  0318 cd0000        	call	c_itolx
1482  031b 96            	ldw	x,sp
1483  031c 1c0009        	addw	x,#OFST-31
1484  031f cd0000        	call	c_lcmp
1486  0322 224e          	jrugt	L155
1487                     ; 195         if (minperiodold)
1489  0324 96            	ldw	x,sp
1490  0325 1c001f        	addw	x,#OFST-9
1491  0328 cd0000        	call	c_lzmp
1493  032b 2739          	jreq	L355
1494                     ; 197           if (minperiod)
1496  032d 96            	ldw	x,sp
1497  032e 1c0015        	addw	x,#OFST-19
1498  0331 cd0000        	call	c_lzmp
1500  0334 271d          	jreq	L555
1501                     ; 198             minperiod = (i-minperiodold+minperiod)/2;
1503  0336 1e27          	ldw	x,(OFST-1,sp)
1504  0338 cd0000        	call	c_uitolx
1506  033b 96            	ldw	x,sp
1507  033c 1c001f        	addw	x,#OFST-9
1508  033f cd0000        	call	c_lsub
1510  0342 96            	ldw	x,sp
1511  0343 1c0015        	addw	x,#OFST-19
1512  0346 cd0000        	call	c_ladd
1514  0349 3400          	srl	c_lreg
1515  034b 3601          	rrc	c_lreg+1
1516  034d 3602          	rrc	c_lreg+2
1517  034f 3603          	rrc	c_lreg+3
1520  0351 200c          	jp	LC001
1521  0353               L555:
1522                     ; 200             minperiod = i-minperiodold;
1524  0353 1e27          	ldw	x,(OFST-1,sp)
1525  0355 cd0000        	call	c_uitolx
1527  0358 96            	ldw	x,sp
1528  0359 1c001f        	addw	x,#OFST-9
1529  035c cd0000        	call	c_lsub
1531  035f               LC001:
1532  035f 96            	ldw	x,sp
1533  0360 1c0015        	addw	x,#OFST-19
1534  0363 cd0000        	call	c_rtol
1536  0366               L355:
1537                     ; 202         minperiodold = i;
1539  0366 1e27          	ldw	x,(OFST-1,sp)
1540  0368 cd0000        	call	c_uitolx
1542  036b 96            	ldw	x,sp
1543  036c 1c001f        	addw	x,#OFST-9
1544  036f cd0000        	call	c_rtol
1546  0372               L155:
1547                     ; 204     if ((m>n) && (maxperiodold<=minperiodold) && (vzorka>=middle))
1549  0372 96            	ldw	x,sp
1550  0373 1c000d        	addw	x,#OFST-27
1551  0376 cd0000        	call	c_ltor
1553  0379 96            	ldw	x,sp
1554  037a 1c0011        	addw	x,#OFST-23
1555  037d cd0000        	call	c_lcmp
1557  0380 236c          	jrule	L165
1559  0382 96            	ldw	x,sp
1560  0383 1c0023        	addw	x,#OFST-5
1561  0386 cd0000        	call	c_ltor
1563  0389 96            	ldw	x,sp
1564  038a 1c001f        	addw	x,#OFST-9
1565  038d cd0000        	call	c_lcmp
1567  0390 225c          	jrugt	L165
1569  0392 1e1d          	ldw	x,(OFST-11,sp)
1570  0394 cd0000        	call	c_itolx
1572  0397 96            	ldw	x,sp
1573  0398 1c0009        	addw	x,#OFST-31
1574  039b cd0000        	call	c_lcmp
1576  039e 254e          	jrult	L165
1577                     ; 206         if (maxperiodold)
1579  03a0 96            	ldw	x,sp
1580  03a1 1c0023        	addw	x,#OFST-5
1581  03a4 cd0000        	call	c_lzmp
1583  03a7 2739          	jreq	L365
1584                     ; 208           if (maxperiod)
1586  03a9 96            	ldw	x,sp
1587  03aa 1c0019        	addw	x,#OFST-15
1588  03ad cd0000        	call	c_lzmp
1590  03b0 271d          	jreq	L565
1591                     ; 209             maxperiod = (i-maxperiodold+maxperiod)/2;
1593  03b2 1e27          	ldw	x,(OFST-1,sp)
1594  03b4 cd0000        	call	c_uitolx
1596  03b7 96            	ldw	x,sp
1597  03b8 1c0023        	addw	x,#OFST-5
1598  03bb cd0000        	call	c_lsub
1600  03be 96            	ldw	x,sp
1601  03bf 1c0019        	addw	x,#OFST-15
1602  03c2 cd0000        	call	c_ladd
1604  03c5 3400          	srl	c_lreg
1605  03c7 3601          	rrc	c_lreg+1
1606  03c9 3602          	rrc	c_lreg+2
1607  03cb 3603          	rrc	c_lreg+3
1610  03cd 200c          	jp	LC002
1611  03cf               L565:
1612                     ; 211             maxperiod = i-maxperiodold;
1614  03cf 1e27          	ldw	x,(OFST-1,sp)
1615  03d1 cd0000        	call	c_uitolx
1617  03d4 96            	ldw	x,sp
1618  03d5 1c0023        	addw	x,#OFST-5
1619  03d8 cd0000        	call	c_lsub
1621  03db               LC002:
1622  03db 96            	ldw	x,sp
1623  03dc 1c0019        	addw	x,#OFST-15
1624  03df cd0000        	call	c_rtol
1626  03e2               L365:
1627                     ; 213         maxperiodold = i;
1629  03e2 1e27          	ldw	x,(OFST-1,sp)
1630  03e4 cd0000        	call	c_uitolx
1632  03e7 96            	ldw	x,sp
1633  03e8 1c0023        	addw	x,#OFST-5
1634  03eb cd0000        	call	c_rtol
1636  03ee               L165:
1637                     ; 188   for (i=0;i<size;i++)
1639  03ee 1e27          	ldw	x,(OFST-1,sp)
1640  03f0 5c            	incw	x
1641  03f1               L145:
1642  03f1 1f27          	ldw	(OFST-1,sp),x
1645  03f3 132d          	cpw	x,(OFST+5,sp)
1646  03f5 2403cc02ab    	jrult	L535
1647                     ; 216   if (maxperiod && minperiod)
1649  03fa 96            	ldw	x,sp
1650  03fb 1c0019        	addw	x,#OFST-15
1651  03fe cd0000        	call	c_lzmp
1653  0401 2719          	jreq	L175
1655  0403 96            	ldw	x,sp
1656  0404 1c0015        	addw	x,#OFST-19
1657  0407 cd0000        	call	c_lzmp
1659  040a 2710          	jreq	L175
1660                     ; 217     return (maxperiod+minperiod);
1662  040c 96            	ldw	x,sp
1663  040d 1c0019        	addw	x,#OFST-15
1664  0410 cd0000        	call	c_ltor
1666  0413 96            	ldw	x,sp
1667  0414 1c0015        	addw	x,#OFST-19
1668  0417 cd0000        	call	c_ladd
1671  041a 2016          	jra	L06
1672  041c               L175:
1673                     ; 218 return((maxperiod+minperiod)*2);
1675  041c 96            	ldw	x,sp
1676  041d 1c0019        	addw	x,#OFST-15
1677  0420 cd0000        	call	c_ltor
1679  0423 96            	ldw	x,sp
1680  0424 1c0015        	addw	x,#OFST-19
1681  0427 cd0000        	call	c_ladd
1683  042a 3803          	sll	c_lreg+3
1684  042c 3902          	rlc	c_lreg+2
1685  042e 3901          	rlc	c_lreg+1
1686  0430 3900          	rlc	c_lreg
1688  0432               L06:
1689  0432 be02          	ldw	x,c_lreg+2
1691  0434 5b2a          	addw	sp,#42
1692  0436 81            	ret	
1827                     ; 225 double GetDataFromEvalBoardfrequency(PParam pparam, double frequencycca, unsigned int channel)
1827                     ; 226 {
1828                     	switch	.text
1829  0437               _GetDataFromEvalBoardfrequency:
1831  0437 89            	pushw	x
1832  0438 5242          	subw	sp,#66
1833       00000042      OFST:	set	66
1836                     ; 232   unsigned char repeats = 10;
1838  043a a60a          	ld	a,#10
1839  043c 6b0d          	ld	(OFST-53,sp),a
1840                     ; 234   double frequencysum = 0;
1842  043e 5f            	clrw	x
1843  043f 1f1a          	ldw	(OFST-40,sp),x
1844  0441 1f18          	ldw	(OFST-42,sp),x
1845                     ; 235   double frequencyexact = 0;
1847  0443 96            	ldw	x,sp
1848  0444 1c001e        	addw	x,#OFST-36
1849  0447 cd0000        	call	c_ltor
1851                     ; 237   frequencycca *= 0.9; //sample longer to sample more than expected 2 periods
1853  044a ae000c        	ldw	x,#L356
1854  044d cd0000        	call	c_ltor
1856  0450 96            	ldw	x,sp
1857  0451 1c0047        	addw	x,#OFST+5
1858  0454 cd0000        	call	c_fgmul
1860                     ; 238   memcpy(&tempparam, pparam, sizeof(tempparam));
1862  0457 96            	ldw	x,sp
1863  0458 1c0023        	addw	x,#OFST-31
1864  045b bf00          	ldw	c_x,x
1865  045d 1643          	ldw	y,(OFST+1,sp)
1866  045f 90bf00        	ldw	c_y,y
1867  0462 ae0020        	ldw	x,#32
1868  0465               L46:
1869  0465 5a            	decw	x
1870  0466 92d600        	ld	a,([c_y.w],x)
1871  0469 92d700        	ld	([c_x.w],x),a
1872  046c 5d            	tnzw	x
1873  046d 26f6          	jrne	L46
1874                     ; 239   tempparam.StartInputChannel = channel;     // first conversion from this channel
1876  046f 7b4c          	ld	a,(OFST+10,sp)
1877  0471 6b23          	ld	(OFST-31,sp),a
1878                     ; 240   tempparam.InputChannelCount = 1;     // only one channel
1880  0473 a601          	ld	a,#1
1881  0475 6b24          	ld	(OFST-30,sp),a
1882                     ; 241   Buffer = tempparam.AddrADCDataStart;
1884  0477 1e25          	ldw	x,(OFST-29,sp)
1885  0479 1f16          	ldw	(OFST-44,sp),x
1886                     ; 243   for (i=1; i<=repeats; i++)
1888  047b 6b22          	ld	(OFST-32,sp),a
1890  047d cc0584        	jra	L366
1891  0480               L756:
1892                     ; 245     if(frequencycca<1) // if frequency is < 1 Hz
1894  0480 a601          	ld	a,#1
1895  0482 cd0000        	call	c_ctof
1897  0485 96            	ldw	x,sp
1898  0486 1c0009        	addw	x,#OFST-57
1899  0489 cd0000        	call	c_rtol
1901  048c 96            	ldw	x,sp
1902  048d 1c0047        	addw	x,#OFST+5
1903  0490 cd0000        	call	c_ltor
1905  0493 96            	ldw	x,sp
1906  0494 1c0009        	addw	x,#OFST-57
1907  0497 cd0000        	call	c_fcmp
1909  049a 2e06          	jrsge	L766
1910                     ; 246       return(0);
1912  049c ae004a        	ldw	x,#L576
1915  049f cc05c4        	jra	L201
1916  04a2               L766:
1917                     ; 247     InitEvalBoardparam(&tempparam,tempparam.NumOfConversions,1,frequencycca,2); //2 periods sampling
1919  04a2 ae0002        	ldw	x,#2
1920  04a5 89            	pushw	x
1921  04a6 1e4b          	ldw	x,(OFST+9,sp)
1922  04a8 89            	pushw	x
1923  04a9 1e4b          	ldw	x,(OFST+9,sp)
1924  04ab 89            	pushw	x
1925  04ac ae0001        	ldw	x,#1
1926  04af 89            	pushw	x
1927  04b0 1e34          	ldw	x,(OFST-14,sp)
1928  04b2 89            	pushw	x
1929  04b3 96            	ldw	x,sp
1930  04b4 1c002d        	addw	x,#OFST-21
1931  04b7 cd0157        	call	_InitEvalBoardparam
1933  04ba 5b0a          	addw	sp,#10
1934                     ; 248     InitEvalBoardcard(&tempparam, 1,tempparam.NumOfConversions,&smplerr); // 1 channel
1936  04bc 96            	ldw	x,sp
1937  04bd 1c000e        	addw	x,#OFST-52
1938  04c0 89            	pushw	x
1939  04c1 1e2e          	ldw	x,(OFST-20,sp)
1940  04c3 89            	pushw	x
1941  04c4 ae0001        	ldw	x,#1
1942  04c7 89            	pushw	x
1943  04c8 96            	ldw	x,sp
1944  04c9 1c0029        	addw	x,#OFST-25
1945  04cc cd00d7        	call	_InitEvalBoardcard
1947  04cf 5b06          	addw	sp,#6
1948                     ; 249     GetDataFromEvalBoard(&tempparam);
1950  04d1 96            	ldw	x,sp
1951  04d2 1c0023        	addw	x,#OFST-31
1952  04d5 cd00c1        	call	_GetDataFromEvalBoard
1955  04d8               L307:
1956                     ; 250     while(ConvertInProgress(&tempparam));
1958  04d8 96            	ldw	x,sp
1959  04d9 1c0023        	addw	x,#OFST-31
1960  04dc cd00cf        	call	_ConvertInProgress
1962  04df 4d            	tnz	a
1963  04e0 26f6          	jrne	L307
1964                     ; 252     GetMinMaxData(Buffer,tempparam.NumOfConversions,&m,&n);
1966  04e2 96            	ldw	x,sp
1967  04e3 1c0014        	addw	x,#OFST-46
1968  04e6 89            	pushw	x
1969  04e7 1d0002        	subw	x,#2
1970  04ea 89            	pushw	x
1971  04eb 1e30          	ldw	x,(OFST-18,sp)
1972  04ed 89            	pushw	x
1973  04ee 1e1c          	ldw	x,(OFST-38,sp)
1974  04f0 cd01b8        	call	_GetMinMaxData
1976  04f3 5b06          	addw	sp,#6
1977                     ; 253     PeriodIndex = GetPeriodIndex(Buffer,tempparam.NumOfConversions,m,n,0.01);
1979  04f5 ce000a        	ldw	x,L317+2
1980  04f8 89            	pushw	x
1981  04f9 ce0008        	ldw	x,L317
1982  04fc 89            	pushw	x
1983  04fd 1e18          	ldw	x,(OFST-42,sp)
1984  04ff 89            	pushw	x
1985  0500 1e18          	ldw	x,(OFST-42,sp)
1986  0502 89            	pushw	x
1987  0503 1e34          	ldw	x,(OFST-14,sp)
1988  0505 89            	pushw	x
1989  0506 1e20          	ldw	x,(OFST-34,sp)
1990  0508 cd0202        	call	_GetPeriodIndex
1992  050b 5b0a          	addw	sp,#10
1993  050d 1f1c          	ldw	(OFST-38,sp),x
1994                     ; 254     if (!PeriodIndex)
1996  050f 2616          	jrne	L717
1997                     ; 256       frequencycca *= 0.8;
1999  0511 ae0004        	ldw	x,#L527
2000  0514 cd0000        	call	c_ltor
2002  0517 96            	ldw	x,sp
2003  0518 1c0047        	addw	x,#OFST+5
2004  051b cd0000        	call	c_fgmul
2006                     ; 257       i=0;
2008  051e 0f22          	clr	(OFST-32,sp)
2009                     ; 258       frequencysum = 0;
2011  0520 5f            	clrw	x
2012  0521 1f1a          	ldw	(OFST-40,sp),x
2013  0523 1f18          	ldw	(OFST-42,sp),x
2014                     ; 259       continue;
2016  0525 2059          	jra	L166
2017  0527               L717:
2018                     ; 261     frequencyexact = frequencycca / ( (1+smplerr)*(PeriodIndex) / tempparam.NumOfConversions);
2020  0527 1e2c          	ldw	x,(OFST-22,sp)
2021  0529 cd0000        	call	c_uitof
2023  052c 96            	ldw	x,sp
2024  052d 1c0009        	addw	x,#OFST-57
2025  0530 cd0000        	call	c_rtol
2027  0533 1e1c          	ldw	x,(OFST-38,sp)
2028  0535 cd0000        	call	c_uitof
2030  0538 96            	ldw	x,sp
2031  0539 1c0005        	addw	x,#OFST-61
2032  053c cd0000        	call	c_rtol
2034  053f 96            	ldw	x,sp
2035  0540 1c000e        	addw	x,#OFST-52
2036  0543 cd0000        	call	c_ltor
2038  0546 ae0000        	ldw	x,#L537
2039  0549 cd0000        	call	c_fadd
2041  054c 96            	ldw	x,sp
2042  054d 1c0005        	addw	x,#OFST-61
2043  0550 cd0000        	call	c_fmul
2045  0553 96            	ldw	x,sp
2046  0554 1c0009        	addw	x,#OFST-57
2047  0557 cd0000        	call	c_fdiv
2049  055a 96            	ldw	x,sp
2050  055b 5c            	incw	x
2051  055c cd0000        	call	c_rtol
2053  055f 96            	ldw	x,sp
2054  0560 1c0047        	addw	x,#OFST+5
2055  0563 cd0000        	call	c_ltor
2057  0566 96            	ldw	x,sp
2058  0567 5c            	incw	x
2059  0568 cd0000        	call	c_fdiv
2061  056b 96            	ldw	x,sp
2062  056c 1c001e        	addw	x,#OFST-36
2063  056f cd0000        	call	c_rtol
2065                     ; 262     frequencysum += frequencyexact;
2067  0572 96            	ldw	x,sp
2068  0573 1c001e        	addw	x,#OFST-36
2069  0576 cd0000        	call	c_ltor
2071  0579 96            	ldw	x,sp
2072  057a 1c0018        	addw	x,#OFST-42
2073  057d cd0000        	call	c_fgadd
2075  0580               L166:
2076                     ; 243   for (i=1; i<=repeats; i++)
2078  0580 0c22          	inc	(OFST-32,sp)
2079  0582 7b22          	ld	a,(OFST-32,sp)
2080  0584               L366:
2083  0584 110d          	cp	a,(OFST-53,sp)
2084  0586 2203cc0480    	jrule	L756
2085                     ; 264   frequencyexact = frequencysum/repeats;
2087  058b 7b0d          	ld	a,(OFST-53,sp)
2088  058d 5f            	clrw	x
2089  058e 97            	ld	xl,a
2090  058f cd0000        	call	c_itof
2092  0592 96            	ldw	x,sp
2093  0593 1c0009        	addw	x,#OFST-57
2094  0596 cd0000        	call	c_rtol
2096  0599 96            	ldw	x,sp
2097  059a 1c0018        	addw	x,#OFST-42
2098  059d cd0000        	call	c_ltor
2100  05a0 96            	ldw	x,sp
2101  05a1 1c0009        	addw	x,#OFST-57
2102  05a4 cd0000        	call	c_fdiv
2104  05a7 96            	ldw	x,sp
2105  05a8 1c001e        	addw	x,#OFST-36
2106  05ab cd0000        	call	c_rtol
2108                     ; 265   pparam->SignalFrequency = frequencyexact;
2110  05ae 1e43          	ldw	x,(OFST+1,sp)
2111  05b0 7b21          	ld	a,(OFST-33,sp)
2112  05b2 e711          	ld	(17,x),a
2113  05b4 7b20          	ld	a,(OFST-34,sp)
2114  05b6 e710          	ld	(16,x),a
2115  05b8 7b1f          	ld	a,(OFST-35,sp)
2116  05ba e70f          	ld	(15,x),a
2117  05bc 7b1e          	ld	a,(OFST-36,sp)
2118  05be e70e          	ld	(14,x),a
2119                     ; 266   return(frequencyexact);
2121  05c0 96            	ldw	x,sp
2122  05c1 1c001e        	addw	x,#OFST-36
2125  05c4               L201:
2126  05c4 cd0000        	call	c_ltor
2128  05c7 5b44          	addw	sp,#68
2129  05c9 81            	ret	
2154                     	xdef	_GetPeriodIndex
2155                     	xdef	_GetMinMaxData
2156                     	xref	_ADCStart
2157                     	xref	_InitADCTimerTrigger
2158                     	xdef	_GetDataFromEvalBoardfrequency
2159                     	xdef	_GetDataFromEvalBoard
2160                     	xdef	_InitEvalBoardparam
2161                     	xdef	_InitEvalBoardcard
2162                     	xdef	_ConvertInProgress
2163                     	xdef	_AllocateEvalBoardBuffer
2164                     	xdef	_UnAllocateDataBuffer
2165                     	xdef	_AllocateDataBuffer
2166                     	xdef	_SetCPUClock
2167                     	xdef	_param
2168                     	xref	_memcpy
2169                     	xref	_ceil
2170                     	xref	_malloc
2171                     	xref	_free
2172                     	xref	_printf
2173                     .const:	section	.text
2174  0000               L537:
2175  0000 3f800000      	dc.w	16256,0
2176  0004               L527:
2177  0004 3f4ccccc      	dc.w	16204,-13108
2178  0008               L317:
2179  0008 3c23d70a      	dc.w	15395,-10486
2180  000c               L356:
2181  000c 3f666666      	dc.w	16230,26214
2182  0010               L704:
2183  0010 4b742400      	dc.w	19316,9216
2184  0014               L143:
2185  0014 47c35000      	dc.w	18371,20480
2186  0018               L712:
2187  0018 4d656d6f7279  	dc.b	"Memory unallocated"
2188  002a 206572726f72  	dc.b	" error",10,0
2189  0032               L761:
2190  0032 4d656d6f7279  	dc.b	"Memory allocated e"
2191  0044 72726f720a00  	dc.b	"rror",10,0
2192  004a               L576:
2193  004a 00000000      	dc.w	0,0
2194                     	xref.b	c_lreg
2195                     	xref.b	c_x
2196                     	xref.b	c_y
2216                     	xref	c_fgadd
2217                     	xref	c_ctof
2218                     	xref	c_fgmul
2219                     	xref	c_ladd
2220                     	xref	c_lzmp
2221                     	xref	c_lcmp
2222                     	xref	c_fadd
2223                     	xref	c_ltof
2224                     	xref	c_lsub
2225                     	xref	c_itof
2226                     	xref	c_itolx
2227                     	xref	c_sdivy
2228                     	xref	c_sdivx
2229                     	xref	c_fmul
2230                     	xref	c_imul
2231                     	xref	c_fsub
2232                     	xref	c_uitof
2233                     	xref	c_ftoi
2234                     	xref	c_fcmp
2235                     	xref	c_fdiv
2236                     	xref	c_ladc
2237                     	xref	c_llsh
2238                     	xref	c_ltor
2239                     	xref	c_rtol
2240                     	xref	c_uitolx
2241                     	end
