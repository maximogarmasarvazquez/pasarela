
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script, console} from "forge-std/Script.sol";
import {PagoToken} from "../src/PagoToken.sol";

contract DeployPagoToken is Script {
    function run() external returns (PagoToken token) {
        vm.startBroadcast();

        (, address deployer,) = vm.readCallers();

        token = new PagoToken(deployer, 1_000_000e6);

        vm.stopBroadcast();

        console.log("PagoToken desplegado en:", address(token));
        console.log("Owner:", token.owner());
    }
}
