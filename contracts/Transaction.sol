// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingSystem {

    //the admin who deployed the contract
    address public electionOfficial;

    // struct to store candidate information
    struct Candidate {
        uint256 id;
        string name;
        uint256 voteCount;
    }

    // check if an address has already voted (prevents double voting)
    mapping(address => bool) public hasVoted;

    // store candidates by their ID
    mapping(uint256 => Candidate) public candidates;

    // total number of candidates
    uint256 public candidatesCount;

    // events to log actions on the blockchain
    event Voted(address voter, uint256 candidateId);
    event CandidateAdded(uint256 candidateId, string name);

    constructor() {
        electionOfficial = msg.sender;
    }

    //function to add a new candidate (only the admin can do this)
    function addCandidate(string memory _name) public {
        require(msg.sender == electionOfficial, "Only the official can add candidates.");
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
        emit CandidateAdded(candidatesCount, _name);
    }

    // function for a voter (Sender) to cast a vote
    function vote(uint256 _candidateId) public {
        // Check if the voter has already voted
        require(!hasVoted[msg.sender], "You have already voted.");
        // Check if the candidate ID is valid
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate ID.");

        //mark the sender as voted
        hasVoted[msg.sender] = true;

        // increment the vote count for the chosen candidate (Receiver)
        candidates[_candidateId].voteCount += 1;

        emit Voted(msg.sender, _candidateId);
    }

    // function to get candidate details and vote count
    function getCandidate(uint256 _candidateId) public view returns (string memory, uint256) {
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate ID.");
        return (candidates[_candidateId].name, candidates[_candidateId].voteCount);
    }
}