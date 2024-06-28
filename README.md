The goal of this project is to create a network of virtual machines (VMs) using the Jailhouse hypervisor. 
The system will be highly scalable, allowing you to add and manage a variable number of VMs. 
Each VM will be able to communicate bidirectionally both with the outside and with each other using the IVSHMEM protocol for efficient data exchange. 
The project also guarantees compatibility with orchestrators for the centralized control and management of VMs.
Tests were conducted to evaluate performance with TCP and UDP protocols, analyzing bandwidth, connection stability and the effects of various types of stress on the system.
