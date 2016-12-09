.org 0x0000
				jmp		reset			; RESET VECTOR

.org OC1Aaddr
				jmp		timer1_match		; TIMER COMPARE MATCH VECTOR

reset:
				LDI		R16, HIGH(RAMEND)	; INITALISE STACK POINTER
				OUT		SPH, R16
				LDI		R16, LOW(RAMEND)
				OUT		SPL, R16
				SBI		DDRB, 0X05		; SET PORTB0 FOR OUTPUT

				ldi		r17, 0x3d		; SET THE COMPARE A REG TO 0X3D08	
				ldi		r16, 0x08		; WITH A PRESCALE OF 1024 THIS
				sts		ocr1ah, r17		; EQUALS EXACTLY 1 SECOND
				sts		ocr1al, r16			
				ldi		r16, 0x02		; ENABLE TIMER COMPARE A INTERRUPT
				sts		timsk1, r16
				ldi		r16, 0x0d		; SET TCCR1B TO COMPARE MODE WITH
				sts		tccr1b, r16		; PRESCALE OF 1024
				sei					; TURN ON GLOBAL INTERRUPTS
				jmp		main_loop

main_loop:
				nop					; DO NOTHING
				rjmp		main_loop

timer1_match:
				SBI		PINB, 5			; FLIP THE 0 BIT
				reti
