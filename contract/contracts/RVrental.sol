// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract RVrental {
//set owner

address owner;
uint ownerBalance;

constructor () {
    owner = msg.sender;
//    address(this).balance = 0;
}


//add self as renter

struct Renter {

    address payable walletAddress;
    string firstName;
    string lastName;
    bool canRent;
    bool active;
    uint balance;
    uint due;
    uint start;
    uint end;

}

    mapping (address => Renter) public renters;

    function addRenter(address payable walletAddress, string memory firstName, string memory lastName, bool canRent, bool active, uint balance, uint due, uint start, uint end) public {
        renters[walletAddress] = Renter(walletAddress, firstName, lastName, canRent, active, balance, due, start, end);
    }

    modifier isRenter(address walletAddress) {
        require(msg.sender == walletAddress, "You can only manage your account");
        _;
    }

    modifier onlyOwner () {
        require(msg.sender == owner, "You are not allowed to access this");
        _;
    }
    
    //check out RV

function checkOut(address walletAddress) public isRenter (walletAddress) {
        require(renters[walletAddress].due == 0, "You have a pending balance.");
        require(renters[walletAddress].canRent == true, "You cannot rent at this time.");
        renters[walletAddress].active = true;
        renters[walletAddress].start = block.timestamp;
        renters[walletAddress].canRent = false;
    }
//check in RV

 function checkIn(address walletAddress) public isRenter (walletAddress) {
        require(renters[walletAddress].active == true, "Please check out an RV first.");
        renters[walletAddress].active = false;
        renters[walletAddress].end = block.timestamp;
        setDue(walletAddress);
    }
//get total duration of RV use

function renterTimespan(uint start, uint end) internal pure returns(uint) {
        return end - start;
    }

    function getTotalDuration(address walletAddress) public isRenter (walletAddress) view returns(uint) {
        if (renters[walletAddress].start == 0 || renters[walletAddress].end == 0) {
            return 0;
        }
        else {

     //   require(renters[walletAddress].active == false, "RV is currently checked out.");
        uint timespan = renterTimespan(renters[walletAddress].start, renters[walletAddress].end);
        uint timespanInMinutes = timespan / 60;
        //changed to 3600 from 60 to convert to hours instead of minutes
        return timespanInMinutes;
    }
    }

//get contract balance

function balanceOf() view public onlyOwner returns(uint) {
        return address(this).balance;
    }

function getOwnerBalance () view public onlyOwner returns (uint) {
        return ownerBalance;
}

function withdrawOwnerBalance () payable public {
    payable(owner).transfer(ownerBalance);
    ownerBalance = 0;
}

//get renter's balance

function balanceOfRenter(address walletAddress) public  isRenter(walletAddress) view returns(uint) {
        return renters[walletAddress].balance;
    }

//set amount due

function setDue(address walletAddress) internal {
        uint timespanMinutes = getTotalDuration(walletAddress);
        uint fiveMinuteIncrements = timespanMinutes / 5;
        renters[walletAddress].due = fiveMinuteIncrements * 5000000000000000;
    }

    function canRentRV(address walletAddress) public isRenter (walletAddress) view returns(bool) {
        return renters[walletAddress].canRent;
    }

//deposit to contract

 function deposit(address walletAddress) isRenter (walletAddress) payable public {
        renters[walletAddress].balance += msg.value;
    }

//make payment
function makePayment(address walletAddress, uint amount)  public  isRenter (walletAddress) {
        require(renters[walletAddress].due > 0, "You do not have anything due at this time.");
        require(renters[walletAddress].balance > amount, "You do not have enough funds to cover payment. Please make a deposit.");
        renters[walletAddress].balance -= amount;
        ownerBalance += amount;
        renters[walletAddress].canRent = true;
        renters[walletAddress].due = 0;
        renters[walletAddress].start = 0;
        renters[walletAddress].end = 0;
    }

    function getDue (address walletAddress) public isRenter (walletAddress) view returns (uint) {

        return renters[walletAddress].due;

    }

    function getRenter (address walletAddress) public isRenter (walletAddress) view returns (string memory firstName, string memory lastName, bool canRent, bool active){
        firstName = renters[walletAddress].firstName;
        lastName = renters[walletAddress].lastName;
        canRent = renters[walletAddress].canRent;
        active = renters[walletAddress].active;
        
    }

    function renterExists (address walletAddress) public isRenter (walletAddress) view returns (bool) {
        if (renters[walletAddress].walletAddress != address(0)) {
            return true;
        }
        else
            return false;
    }
}