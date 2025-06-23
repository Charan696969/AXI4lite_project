<p align="center">
  <img src="https://raw.githubusercontent.com/hdlbits/hdlbits.github.io/main/assets/images/systemverilog-logo.png" alt="SystemVerilog Logo" height="100"/>

  <img src="https://raw.githubusercontent.com/uvmcookbook/uvmcookbook.github.io/main/images/uvm_logo.png" alt="UVM Logo" height="100"/>

  <br>
  <h1 align="center">AXI4-Lite UVM Verification Project</h1>
  <p align="center">📦 A complete UVM testbench to verify a custom AXI4-Lite slave design</p>
</p>

---

<p align="center">
  <img alt="Language" src="https://img.shields.io/badge/SystemVerilog-2017-orange.svg?logo=verilog">
  <img alt="License" src="https://img.shields.io/badge/license-MIT-green.svg">
  <img alt="UVM" src="https://img.shields.io/badge/UVM-1.2-blue.svg">
  <img alt="Build" src="https://img.shields.io/badge/simulated-on--vcs-success.svg">
</p>

---

## 📁 Project Overview

This project showcases the functional verification of a custom **AXI4-Lite slave** using **UVM (Universal Verification Methodology)**. The DUT supports AXI-compliant read/write transactions with full byte-level `WSTRB` support, internal memory, and response signaling.

---

## 🏗️ Directory Structure

```text
AXI4lite_project/
└── axi4lite_design.sv                # AXI4-Lite Slave DUT
└── axi4lite_sample_log.md            # Simulated log from EDAplayground's Synopsys VCS Tool 
├── UVM/
│   ├── axi4lite_interface.sv     # Virtual interface
│   ├── axi4lite_seq_item.sv      # Transaction object
│   ├── axi4lite_sequence.sv      # Generates sequences
│   ├── axi4lite_sequencer.sv     # Controls item flow
│   ├── axi4lite_driver.sv        # Drives DUT signals
│   ├── axi4lite_monitor.sv       # Monitors bus
│   ├── axi4lite_agent.sv         # Bundles sequencer/driver/monitor
│   ├── axi4lite_scoreboard.sv    # Checks correctness
│   ├── axi4lite_env.sv           # Testbench environment
|   ├── axi4lite_test.sv          # Test Class
│   └── top.sv                    # Top testbench wrapper
└── README.md                     # You're here!
