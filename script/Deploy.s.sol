// SPDX-License-Identifier:MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {FlowVault} from "../src/FlowVault.sol";

contract DeployFlowVault is Script{
    address uSDT = 0xcedfB56113143d55b2358b8CFbb0dEB5Ad2f55a7;
    uint256 deployerPrivateKey = vm.envUint("PrivateKey");
    function run() external returns(FlowVault){

        vm.startBroadcast(deployerPrivateKey);
        FlowVault flowy = new FlowVault(uSDT);
        vm.stopBroadcast();
        
        return flowy;
    }

}