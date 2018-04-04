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
pragma solidity 0.4.19;

import "./lib/ERC20Token.sol";
import "./tokenRegistry.sol";


/// @title Token Register Contract
/// @dev This contract maintains a list of tokens the Protocol supports.
/// @author Kongliang Zhong - <kongliang@loopring.org>,
/// @author Daniel Wang - <daniel@loopring.org>.
contract TokenCreator {

    address[] public tokens;
    address   public tokenRegistryAddr;

    ////////////////////////////////////////////////////////////////////////////
    /// Events                                                               ///
    ////////////////////////////////////////////////////////////////////////////

    event ERC20TokenCreated(address addr);

    ////////////////////////////////////////////////////////////////////////////
    /// Public Functions                                                     ///
    ////////////////////////////////////////////////////////////////////////////

    /// @dev Disable default function.
    function () payable public {
        revert();
    }

    /// This method must be called immediately upon deployment.
    function setTokenRegistry(address _tokenRegistryAddr) public
    {
        require(tokenRegistryAddr == 0x0 && _tokenRegistryAddr != 0x0);
        tokenRegistryAddr = _tokenRegistryAddr;
    }

    function createToken(
        string  _name,
        string  _symbol,
        uint8   _decimals,
        uint    _totalSupply,
        address _firstHolder
        )
        public
        returns (ERC20Token)
    {
        ERC20Token token = new ERC20Token(
            _name,
            _symbol,
            _decimals,
            _totalSupply,
            _firstHolder
        );
        address addr = address(token);
        TokenRegistry(tokenRegistryAddr).registerCreatedToken(addr, _symbol);
        tokens.push(addr);
        ERC20TokenCreated(addr);
        return token;
    }
}
