.org 0x0000
		rjmp	reset			; RESET VECTOR

.org OC0Aaddr
		rjmp	OutComRegA      	; COMPARE A VECTOR

.org OC0Baddr
		rjmp	OutComRegB      	; COMPARE B VECTOR

reset:
		ldi	r16, 0x06
		sts	timsk0, r16     	; SET UP TIMSK REGISTER
		ldi	r16, 0x20
        	out	ocr0a, r16      	; SET UP COMPARE A REGISTER
		ldi	r16, 0x10
		out	ocr0b, r16      	; SET UP COMPARE B REGISTER
		ldi	r16, 0x02
		out	tccr0a, r16     	; SET COUNTER MODE TO COMPARE
		ldi	r16, 0x01
		out	tccr0b, r16     	; SET COUNTER TO NO PRESCALING AND START
		sei                   		; ENABLE GLOBAL INTERRUPTS
		rjmp	main_loop

main_loop:
		nop                   		; DO NOTHING
		rjmp	main_loop

OutComRegA:
		nop                   		; DO NOTHING
		reti                  		; RETURN TO IMTERRUPT POINTER

OutComRegB:
		nop                   		; DO NOTHING
		reti                  		; RETURN TO INTERRUPT POINTER
