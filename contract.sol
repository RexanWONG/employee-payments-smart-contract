//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.14;

contract EmployeePayments{
    address owner;
    event LogEmployeeSalaryReceived(address addr, uint amount, uint contractBalance);

    constructor() { 
        owner = msg.sender;
    }

    struct Employee {
        address payable walletAddress;
        string firstName;   
        string lastName;
        uint salary;
    }

    Employee[] public employees;
  
    function addEmployee(address payable walletAddress, string memory firstName, string memory lastName, uint salary) public {
        employees.push(Employee(walletAddress, firstName, lastName, salary));
    } 

    function checkBalance() public view returns(uint) {
        return address(this).balance;
    } 

    function deposit(address walletAddress) payable public { 
        addToEmployeeBalance(walletAddress); 
    } 
    
    function addToEmployeeBalance(address walletAddress) private {    
        for (uint i = 0 ; i < employees.length ; i++){
            if (employees[i].walletAddress == walletAddress){
                employees[i].salary += msg.value;
                emit LogEmployeeSalaryReceived(walletAddress, msg.value, checkBalance());
            }
        }
    }
}    
    
