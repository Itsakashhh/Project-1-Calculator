// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.9.0;

import {IERC20} from  "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract MyCalculator {

    IERC20 public CalculatorToken;
     address public owner;

    constructor(address _calculatorToken) {
        CalculatorToken = IERC20(_calculatorToken);
        owner = msg.sender; // Set the contract deployer as the owner
     }


    // State variables
    uint256 private additionResult;
    int256 private subtractionResult;
    uint256 private multiplicationResult;
    uint256 private divisionResult;

    // Cost in CP for each operation
    uint256 public constant ADD_COST = 10;
    uint256 public constant SUB_COST = 15;
    uint256 public constant MUL_COST = 20;
    uint256 public constant DIV_COST = 30;

    // Counters
    uint256 private additionCount;
    int256 private subtractionCount;
    uint256 private multiplicationCount;
    uint256 private divisionCount;

    // Mappings
    mapping(uint256 => uint256) private additionResults;
    mapping(int256 => int256) private subtractionResults;
    mapping(uint256 => uint256) private multiplicationResults;
    mapping(uint256 => uint256) private divisionResults;


        //////////////////////////////////////////////////
        ////////////////////  MAIN  //////////////////////
        //////////////////////////////////////////////////

    // Function to handle CP payment for operations
    function payCPforOperations(address _from, uint256 _amount) public {
        require(CalculatorToken.balanceOf(_from) >= _amount, "Insufficient CP balance");
        require(CalculatorToken.transferFrom(_from, address(this), _amount), "CP token transfer failed");
    }

    // Addition (costs 10 CP)
    function addition(uint256 a, uint256 b) public returns (uint256) {
        payCPforOperations(msg.sender, ADD_COST);  // Deduct CP cost
        additionResult = a + b;
        additionCount += 1;
        additionResults[additionCount] = additionResult;
        return additionResult;
    }

    // Subtraction
    function subtraction(int256 a, int256 b) public returns (int256) {
        payCPforOperations(msg.sender, SUB_COST);  // Deduct CP cost
        subtractionResult = a - b;
        subtractionCount+=1;
        subtractionResults[subtractionCount] = subtractionResult;
        return subtractionResult;
    }

    // Multiplication
    function multiplication(uint256 a, uint256 b) public returns (uint256) {
        payCPforOperations(msg.sender, MUL_COST);
        multiplicationResult = a * b;
        multiplicationCount+=1;
        multiplicationResults[multiplicationCount] = multiplicationResult; 
        return multiplicationResult;
    }

    // Division
    function division(uint256 a, uint256 b) public returns (uint256) {
        payCPforOperations(msg.sender, DIV_COST);
        require(b != 0);
        divisionResult = a / b;
        divisionCount+=1;
        divisionResults[divisionCount] = divisionResult;
        return divisionResult;
    }
                    ///////////////////////////////////////////
                    ////Getter functions for the results///////
                    ///////////////////////////////////////////

    function getAdditionResult() public view returns (uint256) {
        return additionResult;
    }

    function getSubtractionResult() public view returns (int256) {
        return subtractionResult;
    }

    function getMultiplicationResult() public view returns (uint256) {
        return multiplicationResult;
    }

    function getDivisionResult() public view returns (uint256) {
        return divisionResult;
    }

    // Getter functions for the counters

    function getAdditionCount() public view returns (uint256) {
        return additionCount;
    }

    function getSubtractionCount() public view returns (int256) {
        return subtractionCount;
    }

    function getMultiplicationCount() public view returns (uint256) {
        return multiplicationCount;
    }

    function getDivisionCount() public view returns (uint256) {
        return divisionCount;
    }

    // Getter functions for results by counter

    function getAdditionResultByCount(uint256 count) public view returns (uint256) {
        return additionResults[count];
    }

    function getSubtractionResultByCount(int256 count) public view returns (int256) {
        return subtractionResults[count];
    }

    function getMultiplicationResultByCount(uint256 count) public view returns (uint256) {
        return multiplicationResults[count];
    }

    function getDivisionResultByCount(uint256 count) public view returns (uint256) {
        return divisionResults[count];
    }
}
