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

import "./ERC20.sol";


/// @title ERC20 Token Implementation
/// @dev see https://github.com/ethereum/EIPs/issues/20
/// @author Daniel Wang - <daniel@loopring.org>
contract ERC20Token /*is ERC20*/ {

  string  public name;
  string  public symbol;
  uint8   public decimals;
  uint    public totalSupply;
  mapping(address => uint256) balances;

    function ERC20Token(
        string  _name,
        string  _symbol,
        uint8   _decimals,
        uint    _totalSupply,
        address _firstHolder
        )
        public
    {
        require(bytes(_name).length > 0);
        require(bytes(_symbol).length > 0);
        require(_totalSupply > 0);
        require(_firstHolder != 0x0);

        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _totalSupply;
        balances[_firstHolder] = totalSupply;
    }


    /// TODO(kongliang): Implement this contract
}