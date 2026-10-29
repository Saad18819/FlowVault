// SPDX-License-Identifier:MIT
pragma solidity ^0.8.19;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract FlowVault{

    error not_Owner();
    error amnt_Settled();
    error deposit_TxnFailed();
    error release_FundSettled();
    error releaseFund_txnFailed();
    error refund_FundSettled();
    error refund_txnFailed();
    error deadline_notPassed();
    error invalid_deadline();

uint256 private invoiceId;

address public immutable usdtToken;

    struct Invoice{
        address client;
        address vendor;
        uint256 amntlocked;
        uint256 dueDate;
        bool isSettled;
    }
mapping(uint256 id => Invoice business) public idToInv;


constructor(address uSDT){
    usdtToken = uSDT;
}

event invoiceCreated(address indexed client, address indexed vendor,uint256 indexed Id,uint256 deadline,uint256 amnt);
event depositFund(address indexed client , uint256 indexed id, uint256 amnt);
event releaseFund(address indexed vendor , uint256  amnt , uint256 indexed id);
event refundFund(address indexed client , uint256 indexed id , uint256 amnt);




function createInvoice(address vend,uint256 lockamnt,uint256 deadline) public returns(uint256){
    
if(deadline <= block.timestamp){
    revert invalid_deadline();
}

    uint256 currentId = invoiceId;
    idToInv[currentId] = Invoice({
        client:msg.sender,
        vendor:vend,
        amntlocked:lockamnt,
        dueDate:deadline,
        isSettled:false
    });
   emit invoiceCreated(msg.sender,vend,currentId,deadline,lockamnt);
invoiceId++;

return currentId;
}



function deposit(uint256 Id) public{
Invoice storage inv = idToInv[Id];
if(msg.sender != inv.client){
revert not_Owner();
}else if(inv.isSettled){
    revert amnt_Settled();
}

bool success = IERC20(usdtToken).transferFrom(msg.sender,address(this),inv.amntlocked);
if(!success){
    revert deposit_TxnFailed();
}
emit depositFund(msg.sender ,Id,inv.amntlocked);

}



function releaseFund(uint256 id) public{

    Invoice storage inv = idToInv[id];

    if(msg.sender != inv.client || inv.isSettled){
        revert release_FundSettled();
    }

inv.isSettled = true;

bool success = IERC20(usdtToken).transfer(inv.vendor, inv.amntlocked);
if(!success){
    revert releaseFund_txnFailed();
}

emit releaseFund(inv.vendor ,inv.amntlocked,id);

}

function refundFund(uint256 id) public{
    Invoice storage inv = idToInv[id];

    if(msg.sender != inv.client){
        revert not_Owner();
    }

    if(inv.isSettled){
        revert refund_FundSettled();
    }

    else if(block.timestamp <= inv.dueDate){
revert deadline_notPassed();
    }

    inv.isSettled = true;
    bool success = IERC20(usdtToken).transfer(inv.client,inv.amntlocked);
    if(!success){
        revert refund_txnFailed();
    }
emit refundFund(inv.client ,id ,inv.amntlocked);
}



}