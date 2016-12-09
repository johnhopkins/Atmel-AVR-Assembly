# Timer methods

##8 Bit timers

The ATmega328 has 2, 8-bit timers: Counter0 and Counter2. These timers are controlled by the following registers.

|Counter 0|Counter 2|Description|
|---------|---------|-----------|
|TCCR0A|TCCR2A|Timer/Counter Control Register A|
|TCCR0B|TCCR2B|Timer/Counter Control Register B|
|TCNT0|TCNT2|Timer/Counter Register|
|OCR0A|OCR2A|Output Compare Register A|
|OCR0B|OCR2B|Output Compare Register B|
|TIMSK0|TIMSK2|Timer/Counter Interrupt Mask Register|
|TIFR0|TIFR2|Timer/Counter Interrupt Flag Register|

The following applies equally to both timers 0 and 2. Substitute n for whichever timer you are working with.

TCCRnA and TCCRnB are used to configure the respective timer.
TIMSKn controls the interrupts to be enabled. Each counter has 3 interrupts, one for each Output Compare Register and one for overflow.

|bit|7|6|5|4|3|2|1|0|
|---|---|---|---|---|---|---|---|---|
|TCCRnA|COMnA1|COMnA0|COMnB1|COMnB0|||WGM01|WGM00|
|TCCRnB|FOCnA|FOCnB|||WGM02|CS02|CS01|CS00|
|TIMSKn|||||OCIEnB|OCIEnA|TOIEn|

WGM02, WGM01 and WGM00 are used to set the counters mode.

|WGM02|	WGM01|	WGM00|	Description|
|---|---|---|---|
|0	|0	|0	|Normal|
|0	|0	|1	|PWM, Phase Correct|
|0	|1	|0	|Clear Timer on Compare (CTC)|
|0	|1	|1	|Fast PWM|
|1	|0	|0	|Reserved|
|1	|0	|1	|PWM, Phase Correct|
|1	|1	|0	|Reserved|
|1	|1	|1	|Fast PWM|

An ATmega328 without an external crystal runs at 8MHz. This means that the timer increments 8 million times per second. If we set CS02, CS01 and CS00 then we can slow down this rate to make the timer more flexible for our potential needs. This is known as the prescaler which simply divides the clock by a set amount. For example using divide by 8 would mean that the timer is incremented only 1 million times per second.

|CS02	|CS01	|CS00	|Description|
|---|---|---|---|
|0	|0	|0	|No clock source (Timer/Counter stopped)|
|0	|0	|1	|Clock(No prescaling)|
|0	|1	|0	|Clock/8 (From prescaler)|
|0	|1	|1	|Clock/64 (From prescaler)|
|1	|0	|0	|Clock/256 (From prescaler)|
|1	|0	|1	|Clock/1024 (From prescaler)|
|1	|1	|0	|External clock source on T0 pin. Clock on falling edge.|
|1	|1	|1	|External clock source on T0 pin. Clock on rising edge.|

COMnA1, COMnA0, COMnB1 and COMnB0 control the behavior of the OCnA (PD6) and OCnB (PD5) pins. These pins can be controlled from the Output Compare Registers (OCRnA/OCRnB).

TCNTn is our actual timer. It is is a simple 8 bit register that increments by 1 on every clock cycle of the MCU. Therefore will count to a maximum of 255 before overflowing back to 0 and repeating indefinitely.

OCRnA and OCRnB are also 8 bit registers that simply hold a user defined value between 0 and 255. These values are compared with the value that the counter is currently at on every clock cycle. If a match is found then depending on how we hace configured the TCCRnA, TCCRnB, and TIMSKn registers will define what happens next.

##16 Bit timer

The ATmega328 has one 16 bit timer. It works like the 8 bit timer, but as it is 16 bit counts to 65335 rather than 255. The registers used by this timer are:

|Counter1	|Description|
|---|---|
|TCCR1A	|Timer/Counter 1 Control Register A|
|TCCR1B	|Timer/Counter 1 Control Register B|
|TCCR1C	|Timer/Counter 1 Control Register C|
|TCNT1H	|Timer/Counter 1 High Register|
|TCNT1L	|Timer/Counter 1 Low Register|
|OCR1AH	|Output Compare Register 1 A High|
|OCR1AL	|Output Compare Register 1 A Low|
|OCR1BH	|Output Compare Register 1 B High|
|OCR1BL	|Output Compare Register 1 B Low|
|ICR1H	|Input Capture Register 1 High|
|ICR1L	|Input Capture Register 1 Low|
|TIMSK1	|Timer/Counter Interrupt Mask Register|
|TIFR1	|Timer/Counter Interrupt Flag Register|

In essence it is very similar to counters 0 and 2. The main differences being that as the MCU's are 8 bit we need to use two bytes to store in some of the registers. These are simply the High and Low registers of each respective word.

TCCR1A, TCCR1B and TCCR1C play a similar role to TCCR0A and TCCR0B. These are shown below.

|bit	|7	|6	|5	|4	|3	|2	|1	|0|
|---|---|---|---|---|---|---|---|---|
|TCCR1A	|COM1A1	|COM1A0	|COM1B1	|COM1B0	|	|	|WGM11	|WGM10|
|TCCR1B	|ICNC1	|ICES1	|	|WGM13	|WGM12	|CS12	|CS11	|CS10|
|TCCR1C	|FOC1A	|FOC1B	|	|	|	|	|	| |

Some of the differences include

4 mode bits instead of 3 (ie more modes)
The Force Output Compare bits are in TCCR1C
Input Capture Noise Canceler bit in TCCR1B (outside the scope of this tutorial)
Input Capture Edge Select in TCCR1B (outside the scope of this tutorial)
TCNT1H and TCNT1L are similar to TCNT0, but being a 16 bit counter they are split across 2 registers. Similarly with OCR1AH, OCR1AL, OCR1BH and OCR1BL.

ICR1H and ICR1L don't have any equivalent in the 8 bit timers and allow you to capture the timer value on certain events.

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

