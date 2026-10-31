// SPDX-License-Identifier:MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {FlowVault} from "../src/FlowVault.sol";
import {MockUSDT} from "../test/test.t.sol";

contract DeployFlowVault is Script{
  
    function run() external returns(FlowVault){

  address uSDT;
    uint256 deployerPrivateKey = vm.envUint("PrivateKey");

    if(chain.id == 31337){
        vm.startBroadcast();
        MockUSDT mocky = new MockUSDT(1000 * 1e6);
        address uSDT = address(mocky);
        vm.stopBroadcast();
    }else{
        uSDT = 0xcedfB56113143d55b2358b8CFbB0dEB5Ad2f55a7;
    }
        vm.startBroadcast(deployerPrivateKey);
        FlowVault flowy = new FlowVault(uSDT);
        vm.stopBroadcast();

        return flowy;
    }

}