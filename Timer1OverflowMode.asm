.org 0x0000
      			jmp		reset

.org OVF1addr
			jmp		timer1_overflow

reset:
			LDI		R16, HIGH(RAMEND)	; INITALISE STACK POINTER
			OUT		SPH, R16
			LDI		R16, LOW(RAMEND)
			OUT		SPL, R16
			SBI		DDRB, 0X05		; SET PORTB0 FOR OUTPUT

			ldi		r16, 0x01
			sts		timsk1, r16
			ldi		r16, 0x05
			sts		tccr1b, r16
			sei
			jmp		main_loop

main_loop:
			nop
			rjmp	main_loop

timer1_overflow:
			SBI		PINB, 5			; FLIP THE 0 BIT
			reti
