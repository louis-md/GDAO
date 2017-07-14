pragma solidity ^0.4.11;
import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../../contracts/NormCorpus.sol";
import "../../contracts/GDAO.sol";
import "../../contracts/Legislator.sol";
import "../../contracts/example/norms/MajorityVotingWithMembership.sol";
import "../../contracts/example/proposals/DummyProposal.sol";

contract TestVotingOnMembership {

	//	Casting contract types.
	LegislatorInterface legislator;
	NormCorpus normCorpus;
	MajorityVotingWithMembership newVoting;

	function beforeEach() {

		//	Init contract variables.
		var proxy = GDAO(DeployedAddresses.GDAO());
		legislator = LegislatorInterface(DeployedAddresses.Legislator());
		normCorpus = NormCorpus(DeployedAddresses.NormCorpus());
		newVoting = MajorityVotingWithMembership(DeployedAddresses.MajorityVotingWithMembership());

		//	Burn owners.
		normCorpus.burnOwner();
		Legislator(legislator).burnOwner();
	}

	function testProposeAndVote() {

		//	Init 2 dummy proposals.
		var proposal = new DummyProposal(1);
		var proposal2 = new DummyProposal(2);

		// Propose and vote twice.
		newVoting.propose(proposal);
		newVoting.vote(proposal);
		newVoting.vote(proposal);
		//Assert.equal(newVoting.getVotersNumber(), 2, "Should have 2 voters");
		//Assert.equal(newVoting.getProposalVotes(proposal), 2, "Should have 2 voters");

		// New proposal and vote twice again
		newVoting.propose(proposal2);
		newVoting.vote(proposal2);
		newVoting.vote(proposal2);

		// Testing that we do have 4 total votes, 2 for each.
		//Assert.equal(newVoting.getVotersNumber(), 4, "Should have 2 voters");
		//Assert.equal(newVoting.getProposalVotes(proposal), 2, "Should have 2 voters");
		//Assert.equal(newVoting.getProposalVotes(proposal2), 2, "Should have 2 voters");
	}

	function testVoteForUnknown() {

		// Init 1 dummy proposal.
		var proposal = new DummyProposal(1);

		// Try to vote before proposing it.
		newVoting.vote(proposal);

		// Testing that it didn't vote.
		//Assert.equal(newVoting.getVotersNumber(), 0, "Total Voters should be zero (unknown proposal)");
		//Assert.equal(newVoting.getProposalVotes(proposal), 0, "Total votes for proposal should be zero (unknown proposal)");
	}

	function testVoteAndGetWinner() {
		//	Init 2 dummy proposals.
		var proposal = new DummyProposal(1);
		var proposal2 = new DummyProposal(2);

		// Propose both and vote twice for 1st, once for 2nd.
		newVoting.propose(proposal);
		newVoting.propose(proposal2);
		newVoting.vote(proposal);
		newVoting.vote(proposal);
		newVoting.vote(proposal2);

		// Test number of votes required to pass.
		//Assert.equal(newVoting.getVotesRequiredToPass(), 2, "Total votes required to pass should be 2 (3/2+1)");

		Assert.isFalse(newVoting.isPassed(proposal2), "Proposal2 should not be passed");
		Assert.isTrue(newVoting.isPassed(proposal), "Proposal should be passed");

	}

}
