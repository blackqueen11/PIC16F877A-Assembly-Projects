# ADC Potentiometer Reading & LED Display (Assembly)

This project demonstrates how to configure the **Analog-to-Digital Converter (ADC)** module of the PIC16F877A microcontroller using pure Assembly language. The system reads an analog voltage value from a potentiometer and displays the 8-bit digital equivalent on a generic LED bar connected to PORTB.

##  Project Goal
To understand the low-level configuration of ADC registers (`ADCON0`, `ADCON1`) and signal acquisition timing without using high-level libraries.

##  Technical Details
- **Microcontroller:** PIC16F877A
- **Input:** Potentiometer (connected to pin **AN0/RA0**)
- **Output:** 8 LEDs (connected to **PORTB**)
- **ADC Resolution:** 10-bit (We use the 8 Most Significant Bits from `ADRESH`)
- **Justification:** Left Justified (ADFM = 0 via `ADCON1`)
- **Clock Source:** Fosc/32

##  Code Logic
1.  **Initialization:**
    -   `TRISA` is set to Input (for AN0).
    -   `TRISB` is set to Output (for LEDs).
    -   `ADCON1` is configured to set **AN0 as Analog** and others as Digital.
2.  **Acquisition:**
    -   `ADCON0` is configured to select Channel 0 and turn on the ADC module (`ADON`).
    -   A short delay (`GECIKME`) is implemented to allow the acquisition capacitor to charge.
3.  **Conversion:**
    -   The `GO/DONE` bit is set to start conversion.
    -   The program polls the `GO/DONE` bit until it is cleared by hardware (indicating conversion is complete).
4.  **Display:**
    -   The value from the `ADRESH` register is moved to `PORTB` to light up the corresponding LEDs.

##  Simulation (Proteus)
![ADC Simulation](adc.png)
## 🛠 Tools Used
- **IDE:** MPLAB IDE v8.91 (Assembly / MPASM)
- **Simulation:** Proteus ISIS 8
