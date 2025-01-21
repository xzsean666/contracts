// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IACL {
    /**
     * @dev 当角色被授予时触发的事件
     */
    event RoleGranted(
        bytes32 indexed role,
        address indexed account,
        address indexed sender
    );

    /**
     * @dev 当角色被撤销时触发的事件
     */
    event RoleRevoked(
        bytes32 indexed role,
        address indexed account,
        address indexed sender
    );

    /**
     * @dev 检查账户是否拥有特定角色
     */
    function hasRole(
        bytes32 role,
        address account
    ) external view returns (bool);

    /**
     * @dev 检查账户是否是管理员
     */
    function isAdmin(address account) external view returns (bool);

    /**
     * @dev 返回管理员角色的标识符
     */
    function ADMIN_ROLE() external view returns (bytes32);

    /**
     * @dev 获取拥有特定角色的地址数量
     */
    function getRoleMemberCount(bytes32 role) external view returns (uint256);

    /**
     * @dev 获取特定角色的成员地址
     * @param role 要查询的角色
     * @param index 成员索引
     */
    function getRoleMember(
        bytes32 role,
        uint256 index
    ) external view returns (address);

    /**
     * @dev 授予角色给指定地址
     */
    function grantRole(bytes32 role, address account) external;

    /**
     * @dev 撤销指定地址的角色
     */
    function revokeRole(bytes32 role, address account) external;

    /**
     * @dev 放弃自己的角色
     */
    function renounceRole(bytes32 role) external;

    /**
     * @dev 检查一个角色是否存在
     */
    function roleExists(bytes32 role) external view returns (bool);
}
