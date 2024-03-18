// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

interface IERC20 {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}

contract MassTokenSender is Ownable {

    struct Recipient {
        address wallet;
        uint256 amount;
    }

    constructor(address initialOwner) Ownable(initialOwner) {}

    function massSendTokens(address tokenAddress, Recipient[] calldata recipients) external onlyOwner {
        IERC20 token = IERC20(tokenAddress);

        for (uint i = 0; i < recipients.length; i++) {
            require(token.transferFrom(msg.sender, recipients[i].wallet, recipients[i].amount), "Fallo al enviar los tokens.");
        }
    }
}
