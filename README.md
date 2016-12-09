# Timer methods
|Counter 0|Counter 2|Description|
|---------|---------|-----------|
|TCCR0A|TCCR2A|Timer/Counter Control Register A|
|TCCR0B|TCCR2B|Timer/Counter Control Register B|
|TCNT0|TCNT2|Timer/Counter Register|
|OCR0A|OCR2A|Output Compare Register A|
|OCR0B|OCR2B|Output Compare Register B|
|TIMSK0|TIMSK2|Timer/Counter Interrupt Mask Register|
|TIFR0|TIFR2|Timer/Counter Interrupt Flag Register|
##Timer0

###[Timer0OverflowMode.asm](https://github.com/johnhopkins/Atmel-AVR-Assembly/blob/master/Timer0OverflowMode.asm)
A timing sub routine for AVR MCU's, programmed to fire an interrupt every time the counter overflows.

###[ClearTimer0OnCompareMode.asm](https://github.com/johnhopkins/Atmel-AVR-Assembly/blob/master/ClearTimer0OnCompareMode.asm)
A timing subroutine, programmed to fire an interrupt every time the counter compares with a preset.

##Timer1

###[Timer1OverflowMode.asm](https://github.com/johnhopkins/Atmel-AVR-Assembly/blob/master/Timer1OverflowMode.asm)
A timing sub routine for AVR MCU's, programmed to fire an interrupt every time the counter overflows specifically for Timer 1 which uses a 2 byte or 1 word value.

###[ClearTimer1OnCompareMode.asm](https://github.com/johnhopkins/Atmel-AVR-Assembly/blob/master/ClearTimer1OnCompareMode.asm)
A timing subroutine, programmed to fire an interrupt every time the counter compares with a preset specifcally for timer 1 using two bytes or 1 word compare values.

