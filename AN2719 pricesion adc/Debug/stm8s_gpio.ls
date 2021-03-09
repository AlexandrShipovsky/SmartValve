   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.6 - 08 Apr 2008
   3                     ; Optimizer V4.2.6 - 08 Apr 2008
  99                     ; 65 void GPIO_DeInit(GPIO_TypeDef* GPIOx)
  99                     ; 66 {
 101                     	switch	.text
 102  0000               _GPIO_DeInit:
 106                     ; 67   GPIOx->ODR = GPIO_ODR_RESET_VALUE; /* Reset Output Data Register */
 108  0000 7f            	clr	(x)
 109                     ; 68   GPIOx->DDR = GPIO_DDR_RESET_VALUE; /* Reset Data Direction Register */
 111  0001 6f02          	clr	(2,x)
 112                     ; 69   GPIOx->CR1 = GPIO_CR1_RESET_VALUE; /* Reset Control Register 1 */
 114  0003 6f03          	clr	(3,x)
 115                     ; 70   GPIOx->CR2 = GPIO_CR2_RESET_VALUE; /* Reset Control Register 2 */
 117  0005 6f04          	clr	(4,x)
 118                     ; 71 }
 121  0007 81            	ret	
 361                     ; 92 void GPIO_Init(GPIO_TypeDef* GPIOx,
 361                     ; 93                GPIO_Pin_TypeDef GPIO_Pin,
 361                     ; 94                GPIO_Mode_TypeDef GPIO_Mode)
 361                     ; 95 {
 362                     	switch	.text
 363  0008               _GPIO_Init:
 365  0008 89            	pushw	x
 366       00000000      OFST:	set	0
 369                     ; 100   assert_param(IS_GPIO_MODE_OK(GPIO_Mode));
 371                     ; 101   assert_param(IS_GPIO_PIN_OK(GPIO_Pin));
 373                     ; 107   if ((((u8)(GPIO_Mode)) & (u8)0x80) != (u8)0x00) /* Output mode */
 375  0009 7b06          	ld	a,(OFST+6,sp)
 376  000b 2a18          	jrpl	L771
 377                     ; 109     if ((((u8)(GPIO_Mode)) & (u8)0x10) != (u8)0x00) /* High level */
 379  000d a510          	bcp	a,#16
 380  000f 2705          	jreq	L102
 381                     ; 111       GPIOx->ODR |= GPIO_Pin;
 383  0011 f6            	ld	a,(x)
 384  0012 1a05          	or	a,(OFST+5,sp)
 386  0014 2006          	jra	L302
 387  0016               L102:
 388                     ; 114       GPIOx->ODR &= (u8)(~(GPIO_Pin));
 390  0016 1e01          	ldw	x,(OFST+1,sp)
 391  0018 7b05          	ld	a,(OFST+5,sp)
 392  001a 43            	cpl	a
 393  001b f4            	and	a,(x)
 394  001c               L302:
 395  001c f7            	ld	(x),a
 396                     ; 117     GPIOx->DDR |= GPIO_Pin;
 398  001d 1e01          	ldw	x,(OFST+1,sp)
 399  001f e602          	ld	a,(2,x)
 400  0021 1a05          	or	a,(OFST+5,sp)
 402  0023 2007          	jra	L502
 403  0025               L771:
 404                     ; 121     GPIOx->DDR &= (u8)(~(GPIO_Pin));
 406  0025 1e01          	ldw	x,(OFST+1,sp)
 407  0027 7b05          	ld	a,(OFST+5,sp)
 408  0029 43            	cpl	a
 409  002a e402          	and	a,(2,x)
 410  002c               L502:
 411  002c e702          	ld	(2,x),a
 412                     ; 128   if ((((u8)(GPIO_Mode)) & (u8)0x40) != (u8)0x00) /* Pull-Up or Push-Pull */
 414  002e 7b06          	ld	a,(OFST+6,sp)
 415  0030 a540          	bcp	a,#64
 416  0032 2706          	jreq	L702
 417                     ; 130     GPIOx->CR1 |= GPIO_Pin;
 419  0034 e603          	ld	a,(3,x)
 420  0036 1a05          	or	a,(OFST+5,sp)
 422  0038 2005          	jra	L112
 423  003a               L702:
 424                     ; 133     GPIOx->CR1 &= (u8)(~(GPIO_Pin));
 426  003a 7b05          	ld	a,(OFST+5,sp)
 427  003c 43            	cpl	a
 428  003d e403          	and	a,(3,x)
 429  003f               L112:
 430  003f e703          	ld	(3,x),a
 431                     ; 140   if ((((u8)(GPIO_Mode)) & (u8)0x20) != (u8)0x00) /* Interrupt or Slow slope */
 433  0041 7b06          	ld	a,(OFST+6,sp)
 434  0043 a520          	bcp	a,#32
 435  0045 2706          	jreq	L312
 436                     ; 142     GPIOx->CR2 |= GPIO_Pin;
 438  0047 e604          	ld	a,(4,x)
 439  0049 1a05          	or	a,(OFST+5,sp)
 441  004b 2005          	jra	L512
 442  004d               L312:
 443                     ; 145     GPIOx->CR2 &= (u8)(~(GPIO_Pin));
 445  004d 7b05          	ld	a,(OFST+5,sp)
 446  004f 43            	cpl	a
 447  0050 e404          	and	a,(4,x)
 448  0052               L512:
 449  0052 e704          	ld	(4,x),a
 450                     ; 148 }
 453  0054 85            	popw	x
 454  0055 81            	ret	
 498                     ; 166 void GPIO_Write(GPIO_TypeDef* GPIOx, u8 PortVal)
 498                     ; 167 {
 499                     	switch	.text
 500  0056               _GPIO_Write:
 502  0056 89            	pushw	x
 503       00000000      OFST:	set	0
 506                     ; 168   GPIOx->ODR = PortVal;
 508  0057 1e01          	ldw	x,(OFST+1,sp)
 509  0059 7b05          	ld	a,(OFST+5,sp)
 510  005b f7            	ld	(x),a
 511                     ; 169 }
 514  005c 85            	popw	x
 515  005d 81            	ret	
 562                     ; 187 void GPIO_WriteHigh(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 562                     ; 188 {
 563                     	switch	.text
 564  005e               _GPIO_WriteHigh:
 566  005e 89            	pushw	x
 567       00000000      OFST:	set	0
 570                     ; 189   GPIOx->ODR |= PortPins;
 572  005f f6            	ld	a,(x)
 573  0060 1a05          	or	a,(OFST+5,sp)
 574  0062 f7            	ld	(x),a
 575                     ; 190 }
 578  0063 85            	popw	x
 579  0064 81            	ret	
 626                     ; 208 void GPIO_WriteLow(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 626                     ; 209 {
 627                     	switch	.text
 628  0065               _GPIO_WriteLow:
 630  0065 89            	pushw	x
 631       00000000      OFST:	set	0
 634                     ; 210   GPIOx->ODR &= (u8)(~PortPins);
 636  0066 7b05          	ld	a,(OFST+5,sp)
 637  0068 43            	cpl	a
 638  0069 f4            	and	a,(x)
 639  006a f7            	ld	(x),a
 640                     ; 211 }
 643  006b 85            	popw	x
 644  006c 81            	ret	
 691                     ; 229 void GPIO_WriteReverse(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 691                     ; 230 {
 692                     	switch	.text
 693  006d               _GPIO_WriteReverse:
 695  006d 89            	pushw	x
 696       00000000      OFST:	set	0
 699                     ; 231   GPIOx->ODR ^= PortPins;
 701  006e f6            	ld	a,(x)
 702  006f 1805          	xor	a,(OFST+5,sp)
 703  0071 f7            	ld	(x),a
 704                     ; 232 }
 707  0072 85            	popw	x
 708  0073 81            	ret	
 746                     ; 249 u8 GPIO_ReadOutputData(GPIO_TypeDef* GPIOx)
 746                     ; 250 {
 747                     	switch	.text
 748  0074               _GPIO_ReadOutputData:
 752                     ; 251   return ((u8)GPIOx->ODR);
 754  0074 f6            	ld	a,(x)
 757  0075 81            	ret	
 794                     ; 269 u8 GPIO_ReadInputData(GPIO_TypeDef* GPIOx)
 794                     ; 270 {
 795                     	switch	.text
 796  0076               _GPIO_ReadInputData:
 800                     ; 271   return ((u8)GPIOx->IDR);
 802  0076 e601          	ld	a,(1,x)
 805  0078 81            	ret	
 873                     ; 292 BitStatus GPIO_ReadInputPin(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin)
 873                     ; 293 {
 874                     	switch	.text
 875  0079               _GPIO_ReadInputPin:
 877  0079 89            	pushw	x
 878       00000000      OFST:	set	0
 881                     ; 294   return ((BitStatus)(GPIOx->IDR & (u8)GPIO_Pin));
 883  007a e601          	ld	a,(1,x)
 884  007c 1405          	and	a,(OFST+5,sp)
 887  007e 85            	popw	x
 888  007f 81            	ret	
 966                     ; 314 void GPIO_ExternalPullUpConfig(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, FunctionalState NewState)
 966                     ; 315 {
 967                     	switch	.text
 968  0080               _GPIO_ExternalPullUpConfig:
 970  0080 89            	pushw	x
 971       00000000      OFST:	set	0
 974                     ; 317   assert_param(IS_GPIO_PIN_OK(GPIO_Pin));
 976                     ; 318   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 978                     ; 320   if (NewState != DISABLE) /* External Pull-Up Set*/
 980  0081 7b06          	ld	a,(OFST+6,sp)
 981  0083 2706          	jreq	L174
 982                     ; 322     GPIOx->CR1 |= GPIO_Pin;
 984  0085 e603          	ld	a,(3,x)
 985  0087 1a05          	or	a,(OFST+5,sp)
 987  0089 2007          	jra	L374
 988  008b               L174:
 989                     ; 325     GPIOx->CR1 &= (u8)(~(GPIO_Pin));
 991  008b 1e01          	ldw	x,(OFST+1,sp)
 992  008d 7b05          	ld	a,(OFST+5,sp)
 993  008f 43            	cpl	a
 994  0090 e403          	and	a,(3,x)
 995  0092               L374:
 996  0092 e703          	ld	(3,x),a
 997                     ; 327 }
1000  0094 85            	popw	x
1001  0095 81            	ret	
1014                     	xdef	_GPIO_ExternalPullUpConfig
1015                     	xdef	_GPIO_ReadInputPin
1016                     	xdef	_GPIO_ReadOutputData
1017                     	xdef	_GPIO_ReadInputData
1018                     	xdef	_GPIO_WriteReverse
1019                     	xdef	_GPIO_WriteLow
1020                     	xdef	_GPIO_WriteHigh
1021                     	xdef	_GPIO_Write
1022                     	xdef	_GPIO_Init
1023                     	xdef	_GPIO_DeInit
1042                     	end
