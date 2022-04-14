.ORG 0x0000
				JMP		RESET				; RESET VECTOR
.ORG OC0Aaddr
				JMP		TIM0_CPA			; TIMER MATCH REG B VECTOR

RESET:
				LDI		R16, HIGH(RAMEND)	; INITALISE STACK POINTER
				OUT		SPH, R16
				LDI		R16, LOW(RAMEND)
				OUT		SPL, R16

				SBI		DDRB, 0X05			; SET PORTB0 FOR OUTPUT
				
				LDI		R16, 0X20			; SET COMPARE VALUE (20 RANDOM VALUE
				OUT		OCR0A, R16			; FOR TESTING)
				
				LDI		R16, 0x02			; SET TIMER INTERRUPT MASK TO COMPARE MODE
				STS		TIMSK0, R16
				
				LDI		R16, 0x02			; SET TIMER CONTROL REGISTER "A"
				OUT		TCCR0A, R16			; TO CLEAR COUNTER ON COMPARE MODE

				LDI		R16, 0X01			; SET PRESCALER TO NO PRESCALING
				OUT		TCCR0B, R16			; TIMER/COUNTER CONTROL REGISTER "B"			

				SEI							; ENABLE INTERUPTS GLOBALLY
				JMP		MAIN_LOOP			; START MAIN LOOP

MAIN_LOOP:
				NOP							; DO NOTHING
				JMP		MAIN_LOOP

TIM0_CPA:
				SBI		PINB, 5				; FLIP THE 0 BIT
				RETI
