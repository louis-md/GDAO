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
/*
	function testVoteForUnknown() {

		// Init one dummy proposal.
		var proposal = new DummyProposal(1);

		// Try to vote before proposing it.
		newVoting.vote(proposal);

		// Check that it didn't vote.
		Assert.equal(newVoting.getVotersNumber(), 0, "Total Voters should be zero (unknown proposal)");
		Assert.equal(newVoting.getProposalVotes(proposal), 0, "Total votes for proposal should be zero (unknown proposal)");
	}

	function testVoteAndGetWinner() {
		//	Init two dummy proposals.
		var proposal = new DummyProposal(1);
		var proposal2 = new DummyProposal(2);

		// Propose both and vote twice for 1st, once for 2nd.
		newVoting.propose(proposal);
		newVoting.propose(proposal2);
		newVoting.vote(proposal);
		newVoting.vote(proposal);
		newVoting.vote(proposal2);

		// Check number of votes required to pass.
		Assert.equal(newVoting.getVotesRequiredToPass(), 2, "Total votes required to pass should be 2 (3/2+1)");
		Assert.isFalse(newVoting.isPassed(proposal2), "Proposal2 should not be passed");
		Assert.isTrue(newVoting.isPassed(proposal), "Proposal should be passed");

	}
*/
}
