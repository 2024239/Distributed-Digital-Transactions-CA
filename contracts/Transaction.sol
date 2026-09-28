pragma solidity ^0.8.0;

contract VotingSystem {
    address public electionOfficial;
    mapping(address => bool) public hasVoted;

    uint256 public votesForCandidateA;
    uint256 public votesForCandidateB;

    constructor() {
        electionOfficial = msg.sender;
    }

    // vote
    function vote(uint256 _candidateOption) public {
        require(!hasVoted[msg.sender], "You have already voted in this election.");
        require(_candidateOption == 1 || _candidateOption == 2, "Invalid option. Pick 1 or 2.");

        hasVoted[msg.sender] = true;

        if (_candidateOption == 1) {
            votesForCandidateA++;
        } else {
            votesForCandidateB++;
        }
    }

    //results
    function getResults() public view returns (uint256, uint256) {
        return (votesForCandidateA, votesForCandidateB);
    }
}
