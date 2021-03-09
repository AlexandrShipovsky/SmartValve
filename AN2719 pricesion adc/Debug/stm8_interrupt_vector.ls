   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.6 - 08 Apr 2008
   3                     ; Optimizer V4.2.6 - 08 Apr 2008
  35                     ; 17 @far @interrupt void NonHandledInterrupt (void)
  35                     ; 18 {
  36                     	switch	.text
  37  0000               f_NonHandledInterrupt:
  41                     ; 22 	return;
  44  0000 80            	iret	
  68                     ; 28 @far @interrupt void TrapInterruptHandler (void)
  68                     ; 29 {
  69                     	switch	.text
  70  0001               f_TrapInterruptHandler:
  74                     ; 30   _asm("halt\n");
  77  0001 8e            	halt	
  79                     ; 31   return;
  82  0002 80            	iret	
 106                     ; 34 @far @interrupt void TLIInterruptHandler (void)
 106                     ; 35 {
 107                     	switch	.text
 108  0003               f_TLIInterruptHandler:
 112                     ; 36   _asm("nop\n");
 115  0003 9d            	nop	
 117                     ; 37   return;
 120  0004 80            	iret	
 122                     .const:	section	.text
 123  0000               __vectab:
 124  0000 82            	dc.b	130
 126  0001 00            	dc.b	page(__stext)
 127  0002 0000          	dc.w	__stext
 128  0004 82            	dc.b	130
 130  0005 01            	dc.b	page(f_TrapInterruptHandler)
 131  0006 0001          	dc.w	f_TrapInterruptHandler
 132  0008 82            	dc.b	130
 134  0009 03            	dc.b	page(f_TLIInterruptHandler)
 135  000a 0003          	dc.w	f_TLIInterruptHandler
 136  000c 82            	dc.b	130
 138  000d 00            	dc.b	page(f_NonHandledInterrupt)
 139  000e 0000          	dc.w	f_NonHandledInterrupt
 140  0010 82            	dc.b	130
 142  0011 00            	dc.b	page(f_NonHandledInterrupt)
 143  0012 0000          	dc.w	f_NonHandledInterrupt
 144  0014 82            	dc.b	130
 146  0015 00            	dc.b	page(f_NonHandledInterrupt)
 147  0016 0000          	dc.w	f_NonHandledInterrupt
 148  0018 82            	dc.b	130
 150  0019 00            	dc.b	page(f_NonHandledInterrupt)
 151  001a 0000          	dc.w	f_NonHandledInterrupt
 152  001c 82            	dc.b	130
 154  001d 00            	dc.b	page(f_NonHandledInterrupt)
 155  001e 0000          	dc.w	f_NonHandledInterrupt
 156  0020 82            	dc.b	130
 158  0021 00            	dc.b	page(f_NonHandledInterrupt)
 159  0022 0000          	dc.w	f_NonHandledInterrupt
 160  0024 82            	dc.b	130
 162  0025 00            	dc.b	page(f_NonHandledInterrupt)
 163  0026 0000          	dc.w	f_NonHandledInterrupt
 164  0028 82            	dc.b	130
 166  0029 00            	dc.b	page(f_NonHandledInterrupt)
 167  002a 0000          	dc.w	f_NonHandledInterrupt
 168  002c 82            	dc.b	130
 170  002d 00            	dc.b	page(f_NonHandledInterrupt)
 171  002e 0000          	dc.w	f_NonHandledInterrupt
 172  0030 82            	dc.b	130
 174  0031 00            	dc.b	page(f_NonHandledInterrupt)
 175  0032 0000          	dc.w	f_NonHandledInterrupt
 176  0034 82            	dc.b	130
 178  0035 00            	dc.b	page(f_NonHandledInterrupt)
 179  0036 0000          	dc.w	f_NonHandledInterrupt
 180  0038 82            	dc.b	130
 182  0039 00            	dc.b	page(f_NonHandledInterrupt)
 183  003a 0000          	dc.w	f_NonHandledInterrupt
 184  003c 82            	dc.b	130
 186  003d 00            	dc.b	page(f_NonHandledInterrupt)
 187  003e 0000          	dc.w	f_NonHandledInterrupt
 188  0040 82            	dc.b	130
 190  0041 00            	dc.b	page(f_NonHandledInterrupt)
 191  0042 0000          	dc.w	f_NonHandledInterrupt
 192  0044 82            	dc.b	130
 194  0045 00            	dc.b	page(f_NonHandledInterrupt)
 195  0046 0000          	dc.w	f_NonHandledInterrupt
 196  0048 82            	dc.b	130
 198  0049 00            	dc.b	page(f_NonHandledInterrupt)
 199  004a 0000          	dc.w	f_NonHandledInterrupt
 200  004c 82            	dc.b	130
 202  004d 00            	dc.b	page(f_NonHandledInterrupt)
 203  004e 0000          	dc.w	f_NonHandledInterrupt
 204  0050 82            	dc.b	130
 206  0051 00            	dc.b	page(f_NonHandledInterrupt)
 207  0052 0000          	dc.w	f_NonHandledInterrupt
 208  0054 82            	dc.b	130
 210  0055 00            	dc.b	page(f_NonHandledInterrupt)
 211  0056 0000          	dc.w	f_NonHandledInterrupt
 212  0058 82            	dc.b	130
 214  0059 00            	dc.b	page(f_NonHandledInterrupt)
 215  005a 0000          	dc.w	f_NonHandledInterrupt
 216  005c 82            	dc.b	130
 218  005d 00            	dc.b	page(f_NonHandledInterrupt)
 219  005e 0000          	dc.w	f_NonHandledInterrupt
 220  0060 82            	dc.b	130
 222  0061 00            	dc.b	page(f_ADCInterrupt)
 223  0062 0000          	dc.w	f_ADCInterrupt
 224  0064 82            	dc.b	130
 226  0065 00            	dc.b	page(f_NonHandledInterrupt)
 227  0066 0000          	dc.w	f_NonHandledInterrupt
 228  0068 82            	dc.b	130
 230  0069 00            	dc.b	page(f_NonHandledInterrupt)
 231  006a 0000          	dc.w	f_NonHandledInterrupt
 232  006c 82            	dc.b	130
 234  006d 00            	dc.b	page(f_NonHandledInterrupt)
 235  006e 0000          	dc.w	f_NonHandledInterrupt
 236  0070 82            	dc.b	130
 238  0071 00            	dc.b	page(f_NonHandledInterrupt)
 239  0072 0000          	dc.w	f_NonHandledInterrupt
 240  0074 82            	dc.b	130
 242  0075 00            	dc.b	page(f_NonHandledInterrupt)
 243  0076 0000          	dc.w	f_NonHandledInterrupt
 244  0078 82            	dc.b	130
 246  0079 00            	dc.b	page(f_NonHandledInterrupt)
 247  007a 0000          	dc.w	f_NonHandledInterrupt
 248  007c 82            	dc.b	130
 250  007d 00            	dc.b	page(f_NonHandledInterrupt)
 251  007e 0000          	dc.w	f_NonHandledInterrupt
 302                     	xdef	__vectab
 303                     	xref	__stext
 304                     	xdef	f_TLIInterruptHandler
 305                     	xdef	f_TrapInterruptHandler
 306                     	xdef	f_NonHandledInterrupt
 307                     	xref	f_ADCInterrupt
 326                     	end
