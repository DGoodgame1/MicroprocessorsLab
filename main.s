	#include <xc.inc>

psect	code, abs
	
main:
	org	0x0
	goto	start

	org	0x100		    ; Main code starts here at address 0x100
start:
	; movlw	0xFF
	; movwf	TRISE, A	    ; option to input max number to port E
	movlw 	0x00
	movwf	TRISJ, A	    ; Port C all outputs
	
	bra 	test
loop:
	movff 	0x06, PORTJ
	incf 	0x06, W, A
	bra	test
	
loop_dec:
	movff	0x06, PORTJ
	decf	0x06, W, A
	bra	test2
    
test:
	movwf	0x06, A	    ; Test for end of loop condition
	movlw 	0xFF
	; movf	PORTE, W, A	
	cpfseq 	0x06, A
	bra 	loop		    ; Not yet finished goto start of loop again
	bra	loop_dec

test2:	
	movwf	0x06, A	    ; Test for end of loop condition
	movlw 	0x00	; movf	PORTE, W, A	
	cpfseq 	0x06, A	    
	bra	loop_dec
	goto 	0x0		    ; Re-run program from start

    
	end	main
