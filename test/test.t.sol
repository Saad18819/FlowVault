// SPDX-License-Identifier:MIT
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {DeployFlowVault} from "../script/Deploy.s.sol";
import {FlowVault} from "../src/FlowVault.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MockUSDT is ERC20{
    constructor(uint256 supply){"Mock USDT","mUSDT"){
        _mint(msg.sender,supply);
    }
}


contract FlowVaulttesting is Test{
FlowVault public vault;
MockUSDT public mocky;

function setUp() external{
    
}
}
