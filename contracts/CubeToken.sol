// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

// ERC20 API 
// https://docs.openzeppelin.com/contracts/4.x/api/token/erc20#IERC20-transferFrom-address-address-uint256-

/// @custom:security-contact developer@baligames.xyz
contract CubeToken is ERC20, ERC20Burnable, Pausable, Ownable, ERC20Permit {

    uint public total_Supply = 1_000_000_000; // 1 Billions

    event Burn(address indexed from, uint256 amount);

    constructor() ERC20("Cube Token Baligames", "CUBE") ERC20Permit("CubeToken") {
        mint(msg.sender, total_Supply * 10 ** decimals()); // decimals value 18
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function burn(address account, uint256 amount) public onlyOwner {

        require(amount > 0, "Amount to burn must be greater than 0");
        require(balanceOf(msg.sender) >= amount, "Insufficient balance to burn");

        _burn(msg.sender, amount);
        total_Supply -= amount;

        emit Burn(msg.sender, amount);
    
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(from, to, amount);
    }
}