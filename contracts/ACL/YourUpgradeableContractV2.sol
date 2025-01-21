// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "./interfaces/IACL.sol";

contract YourUpgradeableContractV2 is Initializable, UUPSUpgradeable {
    IACL public acl;
    uint256 public newValue; // 新增状态变量

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(address _aclAddress) public initializer {
        acl = IACL(_aclAddress);
        __UUPSUpgradeable_init();
    }

    function _authorizeUpgrade(address newImplementation) internal override {
        require(acl.isAdmin(msg.sender), "Caller is not admin");
    }

    // 新增的函数
    function setNewValue(uint256 _value) public {
        require(acl.isAdmin(msg.sender), "Caller is not admin");
        newValue = _value;
    }
}
