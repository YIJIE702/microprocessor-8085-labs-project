# 8085 Microprocessor Mini Project – Private Elevator System

## 📌 Introduction
This project simulates a **Private Elevator System** using the 8085 microprocessor.  
The elevator requires user identification via a password before operation, making it suitable for **VVIP access** or **restricted government buildings**.  
The system demonstrates microprocessor-based control logic, input validation, and safety features through simulation.

---

## 🎯 Objectives
- Study and simulate the operation and improvement of an elevator system.  
- Investigate design approaches for secure access control.  
- Simulate emergency handling using interrupts to represent a hacking attempt.  

---

## 🛠️ System Design
The project is implemented using **My1sim85 Simulator** and **8085 Assembly Language**.

- **Hardware Simulation Components**:  
  - 1 port of button  
  - 1 port of switch  
  - 3 ports of LEDs  
  - 5 seven-segment displays  
  - 1 keypad  
  - 1 interrupt line  

- **Memory**:  
  - 2 × 8KB RAM → 16KB total  
  - 2 × 8KB ROM → 16KB total  

- **Peripheral Devices**:  
  - Utilizes 5 × 8255 PPIs  

---

## ⚙️ Methodology
1. User enters a password via the keypad.  
2. **Password Verification**:  
   - If incorrect → LED2 blinks and “Error” is shown on seven-segment display.  
   - If correct → elevator is activated.  
3. **Elevator Operation**:  
   - Current floor displayed on seven-segment display.  
   - Switches control floor selection (Level 1 → 4).  
   - Floor increment → left shift of LED indicators.  
   - Floor decrement → right shift of LED indicators.  
4. **Emergency Simulation**:  
   - Interrupt signal is triggered to simulate hacking or emergency conditions.  

---

## 📐 Approach (Design & Theory)
- **Definable & Detailed-Oriented** – clear modular design for readability and testing.  
- **Easy Handling** – simple user interaction via keypad, switches, and LEDs.  
- **Safety Measures** – password-protected entry with interrupt-based emergency handling.  

---

## ✅ Conclusion
- Gained practical experience in **8085 microprocessor programming** and system simulation.  
- Demonstrated how **minimal hardware** can be optimized for secure and efficient design.  
- Established a framework for future microprocessor-based access control systems.  

---

## 📂 Project Structure
📁 microprocessor-8085-elevator
┣ 📄 README.md
┣ 📄 Elevator.asm # 8085 Assembly source code
┣ 📄 Elevator.lst # Listing file
┣ 📄 Simulation.png # Screenshot of simulation
┗ 📄 Report.pdf # Detailed project documentation

---

## 🚀 How to Run
1. Open the project in **My1sim85 simulator**.  
2. Assemble and load `Elevator.asm` into the simulator.  
3. Interact with the system:  
   - Enter password via keypad.  
   - Use switches to control floor selection.  
   - Observe LED and seven-segment outputs.  

---

## 📜 License

These projects are for educational purposes under NMJ21704 - Microprocessor Systems coursework.
You may modify and use this project for learning, but proper credit to the author is appreciated.
