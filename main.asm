.ORG 0x0000
			JMP	RESET			; RESET VECTOR
.ORG OVF0addr
			JMP	TIM0_OFV		; TIMER OVERFLOW VECTOR
RESET:
			LDI	R16, HIGH(RAMEND)	; INITALISE STACK POINTER
			OUT	SPH, R16
			LDI	R16, LOW(RAMEND)
			OUT	SPL, R16
			SBI	DDRB, 0X05		; SET PORTB0 FOR OUTPUT
			LDI	R16, 0X01		; SET PRESCALER   
			OUT	TCCR0B,R16		; TIMER/COUNTER CONTROL REGISTER "B"
			LDI	R16, 0x01		
			STS	TIMSK0, R16		; SET TIMER INTERRUPT MASK
			LDI	R16, 0xF4
			OUT	TCNT0, R16		; START TIMER
			SEI				; ENABLE INTERUPTS GLOBALLY
			JMP	MAIN_LOOP		; START MAIN LOOP
MAIN_LOOP:
			NOP				; DO NOTHING
			JMP	MAIN_LOOP
TIM0_OFV:
			SBI	PINB, 5			; FLIP THE 0 BIT
			LDI	R16, 0XDD		; SET TIMER WITH DIFFERENT VALUE
			OUT	TCNT0, R16
			RETI