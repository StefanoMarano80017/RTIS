#RTIS

This folder contains material for the course “Real Time Industrial System” (RTIS) at Federico II University.

The goal of this project is to create a network of virtual machines (VMs) using the Jailhouse hypervisor. 
The system will be highly scalable, allowing a variable number of VMs to be added and managed. 
Each VM will be able to communicate bidirectionally with each other, but the ability to communicate with the outside world can be enabled, generally using the IVSHMEM protocol for efficient data exchange, using a cell as the data exchange manager. 

The design also ensures compatibility with orchestrators for centralized control and management of virtual machines.
Tests were conducted to evaluate performance with TCP and UDP protocols, analyzing bandwidth, stability of connections, and the effects of various types of stress on the system.
