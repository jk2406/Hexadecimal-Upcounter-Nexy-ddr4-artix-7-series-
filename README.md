# Hexadecimal Up Counter on Nexys
This project implements an 8-digit hexadecimal up counter on the Nexys DDR4 FPGA board.
The counter drives the onboard seven-segment display (SSD) and continuously counts up in hexadecimal (0–F).

The design is written in SystemVerilog and makes use of modular coding practices with separate modules for:

- Display driver (`NDigitDisplay.sv`)

- Hexadecimal to 7-segment conversion (`hexaDisplay.sv`)

- Counter logic (`CounterSSD_NDigits.sv`)
## Features
- Displays an 8-digit hexadecimal counter (`00000000 → FFFFFFFF`)

- Uses time-multiplexing for 7-segment display scanning

- Clock divider for generating proper refresh rates

- Reset button (`rstn`) to restart counter

- Parameterizable for N_DIGITS (`default = 8`)

- Fully synthesizable on Xilinx Nexys DDR4 (`Artix-7 FPGA`)
## How it works
### 1.Counter Module (`CounterSSD_NDigits`)
- Implements a free-running counter.
- Divides the 100 MHz board clock to a slower rate.
- Splits counter value into 8 hexadecimal digits.
### 2.Display Driver ( `NDigitDisplay`)
 * Performs **time-multiplexed scanning** of 8 SSD digits.
 * Uses a clock divider to set refresh frequency.
* Ensures only one digit is ON at a time.

3. **Hexadecimal Display Mapping (`hexaDisplay` package)**

   * Converts 4-bit nibble → 7-segment LED encoding.
   * Supports digits `0–9` and letters `A–F`.

---

##  Simulation

You can simulate this design using **Vivado Simulator,and Verilator with GTKWave**.Verilator can provide nice debugging warnings and exact locations of bugs.

```bash
# Example with Verilator(Run in linux only);Remove -Wall if you don't want to see warnings but only error
verilator --binary 8digitSSD.sv ssdCounter.sv ssdFunctions.sv -top NDigitDisplay -Wall
```

---
**Note**: For simulation you need to create a dumpfile(add $dumpfile("Name.vcd") at the end and $dumpvars(0,NDigitDisplay)) if you are aiming to test it using a testbench
## 🔧 Constraints File (Nexys DDR4)

Key pin mappings from `constraints.xdc`:

* **Clock:** `clk100mhz → E3`
* **7-seg segments:** `seg[0..6] → T10, R10, K16, K13, P15, T11, L18`
* **7-seg enables:** `an[0..7] → J17, J18, T9, J14, P14, T14, K2, U13`
* **Reset button:** `btnc → N17`

---

## Demo (Example Output)

On power-up, press the centre button from 5 buttons,the counter will start and the sequence will be:

```
00000000
00000001
00000002
...
FFFFFFFF
```

Each digit updates in **hexadecimal**, rolling over after `F`.

---

##  Getting Started

1. Clone the repo:

   ```bash
   git clone https://github.com/<your-username>/hex-counter-nexysddr4.git
   cd hex-counter-nexysddr4
   ```
2. Open project in **Xilinx Vivado**.
3. Add all `.sv` files and `constraints.xdc`.
4. Synthesize, Implement, and Generate Bitstream.
5. Program the **Nexys DDR4 FPGA** via USB.

---

## Tools & Requirements

* **FPGA Board**: Nexys DDR4 (Xilinx Artix-7 XC7A100T)
* **HDL Language**: SystemVerilog (IEEE 1800-2012)
* **Software**: Xilinx Vivado Design Suite
* **Simuator**:Verilator(Runs in linux only) and gtkWave for waveforms

---

##  Learning Outcomes

* Basics of **FPGA-based digital design**
* Understanding **7-segment multiplexing**
* Writing **SystemVerilog modules & packages**
* Using **Vivado constraint files (XDC)**

---


