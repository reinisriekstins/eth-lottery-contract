pragma solidity ^0.4.17;

contract Lottery {
    address public manager;

    address[] public players;

    function Lottery() public {
        manager = msg.sender;
    }

    function getPlayers() public view returns (address[]) {
        return players;
    }

    function enter() public payable {
        require(msg.value > .01 ether);

        players.push(msg.sender);
    }

    function random() private view returns (uint) {
        uint randomUint = uint(sha3(block.difficulty, now, players));

        return randomUint;
    }

    function pickWinner() public restricted {
        uint idxOfWinnerAddr = random() % players.length;

        address winnerAddress = players[idxOfWinnerAddr];

        winnerAddress.transfer(this.balance);

        players = new address[](0);
    }

    modifier restricted() {
        require(msg.sender == manager);

        _;
    }
}