pragma solidity ^0.4.8;
import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../../contracts/NormCorpus.sol";
import "../../contracts/GDAO.sol";
import "../../contracts/Legislator.sol";
import "../../contracts/example/norms/ReferendumVoting.sol";
import "../../contracts/example/proposals/DummyProposal.sol";

contract TestReferendumVoting {

	//	Casting contract types.
	LegislatorInterface legislator;
	NormCorpus normCorpus;
	ReferendumVoting newVoting;

	function beforeEach() {

		//	Init contract variables.
		var proxy = GDAO(DeployedAddresses.GDAO());
		legislator = LegislatorInterface(DeployedAddresses.Legislator());
		normCorpus = NormCorpus(DeployedAddresses.NormCorpus());
		newVoting = new ReferendumVoting(proxy);

		//	Burn owners.
		normCorpus.burnOwner();
		Legislator(legislator).burnOwner();
	}

	function testProposeAndVote() {

		//	Init one dummy proposals.
		var proposal = new DummyProposal(1);

		// Propose and vote yes twice.
		newVoting.propose(proposal);
		newVoting.voteYes(proposal);
		newVoting.voteYes(proposal);

		// Checking if votes went as expected.
		Assert.equal(newVoting.getTotalVotes(proposal), 2, "Should have 2 votes");
		Assert.equal(newVoting.getYesVotes(proposal), 2, "Should have 2 Yes votes");

		// Vote No and check if it went as expected.
		newVoting.voteNo(proposal);
		Assert.equal(newVoting.getTotalVotes(proposal), 3, "Should have 3 votes");
		Assert.equal(newVoting.getNoVotes(proposal), 1, "Should have 1 No votes");

		// Vote Null and check if it went as expected.
		newVoting.voteNull(proposal);
		Assert.equal(newVoting.getTotalVotes(proposal), 4, "Should have 4 votes");
		Assert.equal(newVoting.getNullVotes(proposal), 1, "Should have 1 Null votes");
	}

	function testVoteForUnknown() {

		// Init one dummy proposal.
		var proposal = new DummyProposal(1);

		// Try to vote before proposing it.
		newVoting.voteYes(proposal);
		newVoting.voteNo(proposal);
		newVoting.voteNull(proposal);

		// Check that it didn't vote.
		Assert.equal(newVoting.getTotalVotes(proposal), 0, "Total Voters should be zero (unknown proposal)");
		Assert.equal(newVoting.getYesVotes(proposal), 0, "Total votes for proposal should be zero (unknown proposal)");
		Assert.equal(newVoting.getNoVotes(proposal), 0, "Total votes for proposal should be zero (unknown proposal)");
		Assert.equal(newVoting.getNullVotes(proposal), 0, "Total votes for proposal should be zero (unknown proposal)");
	}

	function testVoteAndGetWinner() {
		//	Init two dummy proposals.
		var proposal = new DummyProposal(1);

		// Propose twice for yes, once for no, once for null.
		newVoting.propose(proposal);
		newVoting.voteYes(proposal);
		newVoting.voteYes(proposal);
		newVoting.voteNo(proposal);
		newVoting.voteNull(proposal);

		// Check result of vote.
		Assert.equal(newVoting.getWinningProposal(proposal), "yes", "The Yes should have won");
	}
}
