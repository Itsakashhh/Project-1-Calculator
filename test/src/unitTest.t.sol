// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.9.0;
import {Test} from "../../lib/forge-std/src/Test.sol";
import {MyCalculator} from "../../src/calculator.s.sol";
import {CalculatorPoint} from "../../src/Token.s.sol";


contract MyCalculatorTest is Test {

    // Reference
    MyCalculator public myCalculator;
    CalculatorPoint public calculatorpoint;

    function setUp() public {
        calculatorpoint = new CalculatorPoint();

        // Pass the token address to the MyCalculator contract
        myCalculator = new MyCalculator(address(calculatorpoint));
    }

    function transferAndApproveCP(uint256 amount) private {

        // Transfer CP to this contract (test wallet) from deployer
        calculatorpoint.transfer(address(this), 100); // Transfer some CP to the test contract
        
        // Approve MyCalculator contract to spend CP
        calculatorpoint.approve(address(myCalculator), amount); // Approve amount for the operation
    }


    function testAddition() public {
        uint256 a = 5;
        uint256 b = 10;
        
        // Set up CP for testing
        transferAndApproveCP(10); // Transfer and approve 10 CP for Addition

        uint256 result = myCalculator.addition(a, b);
        assert(result == 15);
    }

    function testSubtraction() public {
        int256 a = 10;
        int256 b = 5;

        // Set up CP for testing
        transferAndApproveCP(15); // Transfer and approve 15 CP for Subtraction

        int256 result = myCalculator.subtraction(a, b);
        assert(result == 5);
    }

     function testMultiplication() public {
        uint256 a = 5;
        uint256 b = 10;

        // Set up CP for testing
        transferAndApproveCP(20); // Transfer and approve 20 CP for testMultiplication

        uint256 result = myCalculator.multiplication(a, b);
        assert(result == 50);
    }

    function testDivision() public {
        uint256 a = 10;
        uint256 b = 5;

        // Set up CP for testing
        transferAndApproveCP(30); // Transfer and approve 10 CP for Divition

        uint256 result = myCalculator.division(a, b);
        assert(result == 2);
    }

    function testAdditionResultByCount () public {
        uint256 a = 10;
        uint256 b = 5;

        // Set up CP for testing
        transferAndApproveCP(10); // Transfer and approve 10 CP for getAdditionResultByCount
        
        myCalculator.addition (a, b);

        //check result stored in mapping by count
        uint256 resultByCount = myCalculator.getAdditionResultByCount(1);
        assert(resultByCount == 15);
    }

    function testSubtractionResultByCount () public {
        int256 a = 10;
        int256 b = 5;

        // Set up CP for testing
        transferAndApproveCP(15); // Transfer and approve 15 CP for testSubtractionResultByCount

        myCalculator.subtraction (a, b);

        //check result stored in mapping by count
        int256 resultByCount = myCalculator.getSubtractionResultByCount(1);
        assert (resultByCount == 5);
    }

    function testMultiplicationResultByCount () public {
        uint256 a = 10;
        uint256 b = 5;

        // Set up CP for testing
        transferAndApproveCP(20); // Transfer and approve 20 CP for getMultiplicationResultByCount
        myCalculator.multiplication (a, b);

        //check result stored in mapping by count
        uint256 resultByCount = myCalculator.getMultiplicationResultByCount(1);
        assert (resultByCount == 50);
    }

    function testDivisionResultByCount () public {
        uint256 a = 10;
        uint256 b = 5;

        // Set up CP for testing
        transferAndApproveCP(30); // Transfer and approve 10 CP for testDivisionResultByCount

        myCalculator.division (a, b);

        //check result stored in mapping by count
        uint256 resultByCount = myCalculator.getDivisionResultByCount(1);
        assert (resultByCount == 2);
    }

    function testErroeWhileDivideByZero() public {
        uint256 a = 10;
        uint256 b = 0;
        vm.expectRevert();
        myCalculator.division(a, b);
    }

    function testSubtractionNegativeResult() public {
        int256 a = 5;
        int256 b = 10;

        // Set up CP for testing
        transferAndApproveCP(15); // Transfer and approve 15 CP for testSubtractionNegativeResult

        int256 result = myCalculator.subtraction(a, b);
        assert(result == -5);
    }
    function testGetAdditionResult () public {
        uint256 a = 10;
        uint256 b = 5;

        // Set up CP for testing
        transferAndApproveCP(10); // Transfer and approve 10 CP for testGetAdditionResult
        
        myCalculator.addition (a, b);
        uint256 result = myCalculator.getAdditionResult();
        assert(result == 15);
    }

    function testGetSubtractionResult () public {
        int256 a = 10;
        int256 b = 5;

        // Set up CP for testing
        transferAndApproveCP(15); // Transfer and approve 15 CP for testGetSubtractionResult

        myCalculator.subtraction (a, b);
        int256 result = myCalculator.getSubtractionResult();
        assert (result == 5);
    }

    function testGetMultiplicationResult () public {
        uint256 a = 10;
        uint256 b = 5;

        // Set up CP for testing
        transferAndApproveCP(20); // Transfer and approve 20 CP for testGetMultiplicationResult

        myCalculator.multiplication (a, b);
        uint256 result = myCalculator.getMultiplicationResult();
        assert (result == 50);
    }

    function testGetDivisionResult () public {
        uint256 a = 10;
        uint256 b = 5;

        // Set up CP for testing
        transferAndApproveCP(30); // Transfer and approve 10 CP for testGetDivisionResult

        myCalculator.division (a, b);
        uint256 result = myCalculator.getDivisionResult();
        assert (result == 2);
    }

    function testGetAdditionCount () public {
        uint256 a = 10;
        uint256 b = 5;

        // Set up CP for testing
        transferAndApproveCP(10); // Transfer and approve 10 CP for testGetAdditionCount
        
        myCalculator.addition (a, b);
        uint256 result = myCalculator.getAdditionCount();
        assert(result == 1);
    }

    function testGetSubtractionCount () public {
        int256 a = 10;
        int256 b = 5;

         // Set up CP for testing
        transferAndApproveCP(15); // Transfer and approve 15 CP for testGetSubtractionCount

        myCalculator.subtraction (a, b);
        int256 result = myCalculator.getSubtractionCount();
        assert (result == 1);
    }

    function testGetMultiplicationCount () public {
        uint256 a = 10;
        uint256 b = 5;

        // Set up CP for testing
        transferAndApproveCP(20); // Transfer and approve 20 CP for testGetMultiplicationCount

        myCalculator.multiplication (a, b);
        uint256 result = myCalculator.getMultiplicationCount();
        assert (result == 1);
    }

    function testGetDivisionCount () public {
        uint256 a = 10;
        uint256 b = 5;

        // Set up CP for testing
        transferAndApproveCP(30); // Transfer and approve 10 CP for testGetDivisionCount

        myCalculator.division (a, b);
        uint256 result = myCalculator.getDivisionCount();
        assert (result == 1);
    }


                ///////////////////////////////////////////////
                ////////// Test For Token Contract ////////////
                ///////////////////////////////////////////////
                
        function testDecimals() public view {
        uint8 expectedDecimals = 0; // Expected value based on your contract
        uint8 actualDecimals = calculatorpoint.decimals();
        assert(actualDecimals == expectedDecimals);
    }

    function testTotalSupply() public view {
    uint256 expectedTotalSupply = 10000 * (10 ** calculatorpoint.decimals()); // Calculate expected total supply
    uint256 actualTotalSupply = calculatorpoint.totalSupply(); // Call the totalSupply function
    assert(actualTotalSupply == expectedTotalSupply); // Assert that they are equal
}

}
