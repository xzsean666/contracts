// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "./interfaces/IACL.sol";

contract YourUpgradeableContractV1 is Initializable, UUPSUpgradeable {
    IACL public acl;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(address _aclAddress) public initializer {
        acl = IACL(_aclAddress);
        __UUPSUpgradeable_init();
    }

    // 实现 UUPS 所需的授权检查
    function _authorizeUpgrade(address newImplementation) internal override {
        require(acl.isAdmin(msg.sender), "Caller is not admin");
    }

    // 你的业务逻辑
    function someFunction() public {
        require(acl.isAdmin(msg.sender), "Caller is not admin");
        // 业务逻辑
    }
}
