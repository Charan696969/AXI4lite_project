<div align="center">

# 🔍 AXI4-Lite UVM Verification Testbench  
### ✅ Full SystemVerilog + UVM-based Verification Environment

<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/f/f7/AXI_logo.svg/320px-AXI_logo.svg.png" width="160"/>&nbsp;&nbsp;&nbsp;
<img src="https://upload.wikimedia.org/wikipedia/commons/4/4f/Universal_Verification_Methodology_logo.svg" width="180"/>

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Language](https://img.shields.io/badge/SystemVerilog-IEEE%201800--2017-blue.svg)
![UVM](https://img.shields.io/badge/UVM-1.2-green.svg)
![Status](https://img.shields.io/badge/project-DONE-green)

</div>

---

## 📦 Overview

This project implements a **complete UVM testbench** to verify a custom **AXI4-Lite Slave** design.  
The verification environment is modular, scalable, and fully reusable — adhering to **Universal Verification Methodology (UVM)** standards.

---

## 📋 AXI4-Lite DUT Summary

The Design Under Test is a 32-bit AXI4-Lite Slave that supports:

- 10-bit address support (1024-word memory)
- 32-bit write/read data
- Write strobes (`WSTRB`)
- Independent valid/ready handshake logic for AW, W, B, AR, and R channel.
