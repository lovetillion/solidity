// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

// v1 contract to mirror current CashToken setup on BCH
contract XLVToken is ERC20, Ownable {
    using Math for uint256;

    // Defines the maximum tokens per linear emission schedule
    uint256 public constant MAX_SUPPLY = 2100000000000000;

    constructor(uint256 initialSupply, address owner) ERC20("Lovetillion", "XLV") Ownable(owner){
        // Mints the initial supply of tokens directly to the contract deployer
        // Will be used during deployment to issue an initial set of tokens for use in LP
        _mint(owner, initialSupply);
    }

    // Ensures the same precision as Bitcoin Satoshis is utilized
    function decimals() public view virtual override returns (uint8) {
        return 8;
    }

    // Mints XLV tokens (only callable by the contract owner)
    // This function allows the contract owner to manage the token supply for specific purposes.
    function mint(uint256 amount) public onlyOwner returns (bool) {
        // Tracks the total number of XLV tokens currently minted
        uint256 XLV_SUPPLY = totalSupply();

        if (XLV_SUPPLY + amount <= MAX_SUPPLY)
        {
            _mint(msg.sender, amount);
            return true;
        }
        else
        {
            revert("Exceeds Maximum Supply");
        }
    }

    receive() external payable {
        // Unexpected/not implemented
        revert("Function not implemented");
    }

    fallback() external payable {
        // Unexpected/not implemented
        revert("Function not implemented");
    }
}