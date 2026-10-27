// SPDX-License-Identifier:MIT
pragma solidity ^0.8.19;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract FlowVault is IERC20{

uint256 private invoiceId;

    struct Invoice{
        address client,
        address vendor,
        uint256 amntlocked,
        uint256 dueDate,
        bool isSettled
    }
mapping(uint256 id => Invoice business) public idToInv;

function createInvoice(address vend,uint256 lockamnt,uint256 deadline,bool state) public{
    uint256 currentId = inoviceId;
    idToInv[currentId] = Invoice
}



}