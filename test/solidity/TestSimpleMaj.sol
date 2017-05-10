pragma solidity ^0.4.8;
import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../../contracts/NormCorpus.sol";
import "../../contracts/GDAO.sol";
import "../../contracts/Legislator.sol";
import "../../contracts/example/norms/SimpleMajorityVoting.sol";
import "../../contracts/example/proposals/DummyProposal.sol";

contract TestSimpleMaj{
	LegislatorInterface legislator;
	NormCorpus normCorpus;
	SimpleMajorityVoting newVoting;

	function beforeEach() {
		legislator = LegislatorInterface(DeployedAddresses.Legislator());
		normCorpus = NormCorpus(DeployedAddresses.NormCorpus());
		var proxy = GDAO(DeployedAddresses.GDAO());
		newVoting = new SimpleMajorityVoting(proxy);
		normCorpus.burnOwner();
		Legislator(legislator).burnOwner();
	}

	function testSimpleMaj() {
		var proposal = new DummyProposal(1);
		var proposal2 = new DummyProposal(2);
		newVoting.propose(proposal);
		newVoting.vote(proposal);
		newVoting.vote(proposal);
		Assert.equal(newVoting.getVotersNumber(), 2, "Should have 2 voters");
		Assert.equal(newVoting.getProposalVotes(proposal), 2, "Should have 2 voters");
		newVoting.vote(proposal2);
		Assert.equal(newVoting.getProposalVotes(proposal2), 0, "Should have 0 voters");
		Assert.equal(newVoting.getVotersNumber(), 2, "Should have 2 voters");
		newVoting.propose(proposal2);
		newVoting.vote(proposal2);
		newVoting.vote(proposal2);
		Assert.equal(newVoting.getVotersNumber(), 4, "Should have 2 voters");	
	}
}
