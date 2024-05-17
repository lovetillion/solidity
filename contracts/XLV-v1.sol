// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/utils/math/Math.sol";

/// @custom:security-contact support@lovetillion.org
contract Lovetillion is ERC20, ERC20Burnable, Ownable, ERC20Permit {
    using Math for uint256;

    constructor(address initialOwner)
        ERC20("Lovetillion", "XLV")
        Ownable(initialOwner)
        ERC20Permit("Lovetillion")
    {
        _mint(msg.sender, 50 * 10 ** decimals());
    }

    // Ensures the same precision as Bitcoin Satoshis is utilized
    function decimals() public view virtual override returns (uint8) {
        return 8;
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}