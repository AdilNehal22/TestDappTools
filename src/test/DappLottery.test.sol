// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import "../DappLottery.sol";
import "./mocks/LinkToken.sol";
import "./mocks/MockVRFCoordinator.sol";
import "./utils/MockVRFOracle.sol";

contract DappLotteryTest is DSTest {

    DappLottery public dappLottery;

    bytes32 public keyHash;
    MockVRFCoordinator public vrfCoordinatorMock;
    LinkToken public linkToken;
    uint256 public fee;

    function setup() public {
        linkToken = new LinkToken();
        vrfCoordinatorMock = new MockVRFCoordinator(address(linkToken));
        dappLottery = new DappLottery(
            keyHash,
            address(vrfCoordinatorMock),
            address(linkToken),
            fee
        );
    }

    function testLotteryStart() public {
        linkToken.transfer(address(dappLottery), 1000000000000000000);
        bytes32 requestId = dappLottery.startLottery();
        assertTrue(requestId != "0x");
    }

}