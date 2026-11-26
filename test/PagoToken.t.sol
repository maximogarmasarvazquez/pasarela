
 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {PagoToken} from "../src/PagoToken.sol";

contract PagoTokenTest is Test {
    PagoToken token;

    address owner = makeAddr("owner");
    address alice = makeAddr("alice");

    uint256 constant INITIAL_SUPPLY = 1_000_000e6;

    event Transfer(address indexed from, address indexed to, uint256 value);

    function setUp() public {
        token = new PagoToken(owner, INITIAL_SUPPLY);
    }

    // Verifica suministro inicial y decimales.
    function test_InitialSupplyGoesToOwner() public view {
        assertEq(token.balanceOf(owner), INITIAL_SUPPLY);
        assertEq(token.totalSupply(), INITIAL_SUPPLY);
        assertEq(token.decimals(), 6);
    }

    // Verifica approve y transferFrom.
    function test_ApproveAndTransferFrom() public {
        vm.prank(owner);
        token.approve(alice, 50e6);

        vm.prank(alice);
        token.transferFrom(owner, alice, 30e6);

        assertEq(token.balanceOf(alice), 30e6);
        assertEq(token.allowance(owner, alice), 20e6);
    }

    // Verifica que el suministro no aumente al transferir.
    function test_SupplyRemainsFixedAfterTransfer() public {
        vm.prank(owner);
        token.transfer(alice, 100e6);

        assertEq(token.totalSupply(), INITIAL_SUPPLY);
    }

    // Verifica transferencia con evento Transfer.
    function test_EmitsTransferEvent() public {
        uint256 amount = 100e6;

        vm.expectEmit(true, true, false, true, address(token));
        emit Transfer(owner, alice, amount);

        vm.prank(owner);
        token.transfer(alice, amount);
    }

    // Verifica que no se pueda transferir más del saldo.
    function test_TransferRevertsIfInsufficientBalance() public {
        uint256 amount = INITIAL_SUPPLY + 1;

        vm.expectRevert(
            abi.encodeWithSelector(
                bytes4(keccak256("ERC20InsufficientBalance(address,uint256,uint256)")),
                owner,
                INITIAL_SUPPLY,
                amount
            )
        );

        vm.prank(owner);
        token.transfer(alice, amount);
    }

    // Verifica permit mediante una firma EIP-2612.
    function test_Permit() public {
        (address signer, uint256 privateKey) = makeAddrAndKey("signer");

        address spender = alice;
        uint256 value = 50e6;
        uint256 deadline = block.timestamp + 1 days;

        bytes32 structHash = keccak256(
            abi.encode(
                keccak256(
                    "Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"
                ),
                signer,
                spender,
                value,
                token.nonces(signer),
                deadline
            )
        );

        bytes32 digest = keccak256(
            abi.encodePacked(
                "\x19\x01",
                token.DOMAIN_SEPARATOR(),
                structHash
            )
        );

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(privateKey, digest);

        token.permit(signer, spender, value, deadline, v, r, s);

        assertEq(token.allowance(signer, spender), value);
        assertEq(token.nonces(signer), 1);
    }

    // Test fuzz: prueba transferencias con diferentes cantidades.
    function testFuzz_Transfer(uint256 amount) public {
        amount = bound(amount, 0, INITIAL_SUPPLY);

        vm.prank(owner);
        token.transfer(alice, amount);

        assertEq(token.balanceOf(alice), amount);
    }
}
