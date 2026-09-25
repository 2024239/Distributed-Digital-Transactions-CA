pragma solidity ^0.8.0;

contract VotingSystem {
    address public electionOfficial;
    mapping(address => bool) public hasVoted;

    uint256 public votesForCandidateA;
    uint256 public votesForCandidateB;

    constructor() {
        electionOfficial = msg.sender;
    }

