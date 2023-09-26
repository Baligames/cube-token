// SPDX-License-Identifier: MIT
pragma solidity >=0.4.25 <0.9.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/CubeToken.sol";

contract TestCubeToken {
  function testInitialBalanceUsingDeployedContract() {
    CubeToken meta = CubeToken(DeployedAddresses.CubeToken());

    uint expected = 1_000_000_000;

    Assert.equal(meta.getBalance(tx.origin), expected, "Owner should have 1,000,000,000 CubeToken initially");
  }

  function testInitialBalanceWithNewCubeToken() {
    CubeToken meta = new CubeToken();

    uint expected = 1_000_000_000;

    Assert.equal(meta.getBalance(tx.origin), expected, "Owner should have 1,000,000,000 CubeToken initially");
  }
}