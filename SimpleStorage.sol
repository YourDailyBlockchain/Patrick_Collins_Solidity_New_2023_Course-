// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// EVM, ethereum Virtual Machine
// Avalanche, Fantom, Polygon

contract SimpleStorage {
    // boolean, uint, string, int, address, bytes

    // variableType then Visibility of Object then variableName then Value
    bool hasFavoriteNumber = true;
    uint256 favoriteNumber;   // gets initialized to 0

mapping(string => uint256) public nameToFavoriteNumber;
    struct People {
        uint256 favoriteNumber;
        string name;
    }

    // People Array called people
    //uint256[] public favoriteNumbersList;
    People[] public people;

        // takes input _favoriteNumber and assigns it to the global favoriteNumber variable below from above.
    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
        favoriteNumber = favoriteNumber +1;
    }
    
    function retrieve() public view returns (uint256){
        return favoriteNumber;
    }

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        people.push(People(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}