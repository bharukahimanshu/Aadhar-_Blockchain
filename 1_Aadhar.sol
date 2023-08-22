//SPDX-License-Identifier:MIT
pragma solidity >=0.4.21;
pragma experimental ABIEncoderV2;

contract Aadhar {
    address public admin;

    struct Organization {
        uint type_org;
        string name;
        bool isVerified;
    }

    struct Person {
        string name;
        string AadharNo;
        address ethAddress;
    }

    mapping(address => Person) public address_person_map;
    mapping(address => Organization) public address_org_map;

    constructor() {
        admin = msg.sender;
    }

    function registerOrg(address org_address, string memory name, uint type_org) public {
        Organization memory org = Organization(type_org, name, false);
        address_org_map[org_address] = org;
    }

    function registerPerson(address person_address, string memory name, string memory AadharNo) public {
        Person memory per = Person(name, AadharNo, person_address);
        address_person_map[person_address] = per;
    }

    function getPerson(address person_address) public view returns (Person memory) {
        return address_person_map[person_address];
    }

    function getOrg(address org_address) public view returns (Organization memory) {
        return address_org_map[org_address];
    }

    modifier onlyAdmin() {
        require(msg.sender == admin);
        _;
    }
}