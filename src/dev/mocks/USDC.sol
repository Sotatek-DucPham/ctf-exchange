// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import { ERC20 } from "common/ERC20.sol";
import { Ownable } from "common/auth/Ownable.sol";

contract USDC is ERC20, Ownable {
    constructor() ERC20("USDC", "USDC", 6) Ownable(msg.sender) {
        _mint(msg.sender, 10 ** 9 * 10 ** 6);
    }

    function mint(address _to, uint256 _amount) external {
        _mint(_to, _amount);
    }
}
