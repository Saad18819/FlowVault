// SPDX-License-Identifier:MIT
pragma solidity ^0.8.19;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract FlowVault is IERC20{

uint256 private invoiceId;

address public immutable usdtToken

    struct Invoice{
        address client,
        address vendor,
        uint256 amntlocked,
        uint256 dueDate,
        bool isSettled
    }
mapping(uint256 id => Invoice business) public idToInv;


constructor(address uSDT){
    usdtToken = uSDT;
}

function createInvoice(address vend,uint256 lockamnt,uint256 deadline) public returns(uint256){
    uint256 currentId = invoiceId;
    idToInv[currentId] = Invoice({
        client:msg.sender,
        vendor:vend,
        amntlocked:lockamnt,
        dueDate:deadline,
        isSettled:false
    });
invoiceId++;
return currentId;
}

function deposit(uint256 Id) public{
idT
}





}