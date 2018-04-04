/*

  Copyright 2017 Loopring Project Ltd (Loopring Foundation).

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.

*/
pragma solidity 0.4.21;

import "./lib/ERC20Token.sol";
import "./tokenRegistry.sol";


/// @title ERC20 Token Mint
/// @dev This contract deploys ERC20 token contract and registered the contract
///      so the token can be traded with Loopring Protocol.
/// @author Kongliang Zhong - <kongliang@loopring.org>,
/// @author Daniel Wang - <daniel@loopring.org>.
contract TokenMint {
    address[] public tokens;
    address   public tokenRegistryAddr;

    event TokenMinted(
        address addr,
        string  name,
        string  symbol,
        uint8   decimals,
        uint    totalSupply
    );

    /// @dev Disable default function.
    function () payable public {
        revert();
    }

    /// @dev Initialize TokenRegistry address.
    ///      This method sjhall be called immediately upon deployment.
    function setTokenRegistry(address _tokenRegistryAddr) public
    {
        require(tokenRegistryAddr == 0x0 && _tokenRegistryAddr != 0x0);
        tokenRegistryAddr = _tokenRegistryAddr;
    }

    /// @dev Deploy an ERC20 token contract, register it with TokenRegistry, 
    ///      and returns the new token's address.
    /// @param name The name of the token
    /// @param symbol The symbol of the token.
    /// @param decimals The decimals of the token.
    /// @param totalSupply The total supply of the token.
    function mintToken(
        string  name,
        string  symbol,
        uint8   decimals,
        uint    totalSupply
        )
        public
        returns(address addr)
    {
        ERC20Token token = new ERC20Token(
            name,
            symbol,
            decimals,
            totalSupply,
            tx.origin
        );

        addr = address(token);
        TokenRegistry(tokenRegistryAddr).registerCreatedToken(addr, symbol);
        tokens.push(addr);

        emit TokenMinted(
            addr,
            name,
            symbol,
            decimals,
            totalSupply
        );
    }
}
