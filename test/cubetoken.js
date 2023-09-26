const CubeToken = artifacts.require("CubeToken");

contract("CubeToken", (accounts) => {
  it("should put 1000000000 CubeToken in the first account", async () => {
    const CubeTokenInstance = await CubeToken.deployed();
    const balance = await CubeTokenInstance.getBalance.call(accounts[0]);

    assert.equal(balance.valueOf(), 1000000000, "1000000000 wasn't in the first account");
  });
  it("should call a function that depends on a linked library", async () => {
    const CubeTokenInstance = await CubeToken.deployed();
    const CubeTokenBalance = (
      await CubeTokenInstance.getBalance.call(accounts[0])
    ).toNumber();
    const CubeTokenEthBalance = (
      await CubeTokenInstance.getBalanceInEth.call(accounts[0])
    ).toNumber();

    assert.equal(
      CubeTokenEthBalance,
      2 * CubeTokenBalance,
      "Library function returned unexpected function, linkage may be broken"
    );
  });
  it("should send coin correctly", async () => {
    const CubeTokenInstance = await CubeToken.deployed();

    // Setup 2 accounts.
    const accountOne = accounts[0];
    const accountTwo = accounts[1];

    // Get initial balances of first and second account.
    const accountOneStartingBalance = (
      await CubeTokenInstance.getBalance.call(accountOne)
    ).toNumber();
    const accountTwoStartingBalance = (
      await CubeTokenInstance.getBalance.call(accountTwo)
    ).toNumber();

    // Make transaction from first account to second.
    const amount = 10;
    await CubeTokenInstance.sendCoin(accountTwo, amount, { from: accountOne });

    // Get balances of first and second account after the transactions.
    const accountOneEndingBalance = (
      await CubeTokenInstance.getBalance.call(accountOne)
    ).toNumber();
    const accountTwoEndingBalance = (
      await CubeTokenInstance.getBalance.call(accountTwo)
    ).toNumber();

    assert.equal(
      accountOneEndingBalance,
      accountOneStartingBalance - amount,
      "Amount wasn't correctly taken from the sender"
    );
    assert.equal(
      accountTwoEndingBalance,
      accountTwoStartingBalance + amount,
      "Amount wasn't correctly sent to the receiver"
    );
  });
});