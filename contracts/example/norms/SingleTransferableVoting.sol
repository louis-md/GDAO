pragma solidity ^0.4.11;

/*
** Note : "ST" stands for Single Transferable.
** This is a first implementation of a ST vote.
** In this example, vote choices will be limited to 2.
** Winners will also be limited to 2.
** The "init" bool allows to make sure we can't vote for non existing proposals.
*/

contract SingleTransferableVoting {
    
/*
** Creating proposal and vote structures.
** It's necessary to separate them in order to transfer and count votes.
*/

	struct PropInfo {
        bool    init;
        uint    voteCount;
        uint    secondVote;
	}
	struct oneVote {
	    uint firstChoice;
	    uint secondChoice;
	}
        uint totalWinners = 0;
        uint totalVoters = 0;
	
/*
** TODO: Gas cost test with array and mapping for the voteList below.
** Maybe the ballot mapping could be replaced with an array too ?
*/

    mapping (uint => PropInfo) ballot;
    mapping (uint => oneVote) voteList;
    mapping (uint => uint) transferCount;    
/*
** Constructor function receives the number of proposals.
** It inits them so they can be voted for.
** TODO : Change this to avoid the need to redeploy the contract for every ballot.
** TODO : Implement non-arbitrary "nbWinners" (preferably not in Constructor)
*/

    function SingleTransferableVoting(uint nbProposals/*, uint nbWinners*/) {
	    while (nbProposals > 0) {
			ballot[nbProposals].init = true;
			nbProposals--;
	    }
    }
    
    function setVotes(uint firstChoice, uint secondChoice) {
        // Can't vote twice for the same proposal
        if (firstChoice == secondChoice)
            secondChoice = 0;
        if (ballot[firstChoice].init == true || ballot[secondChoice].init == true)
            totalVoters++;
        voteList[totalVoters].firstChoice = firstChoice;
        voteList[totalVoters].secondChoice = secondChoice;
    }
    
/*
** findLoser finds the proposal with the lowest nbr of votes then calls removeLoser.
** TODO:
** What if we have 2 equal number of lowest votes?
*/
    function findLoser () {
        uint i = 1;
        uint loser = ballot[i].voteCount;
        
        i++;
        while (ballot[i].init == true)
            {
                if (ballot[i].voteCount < loser)
                    loser = ballot[i].voteCount;
                i++;
            }
            removeLoser(i);
    }
    
    function transferExcess(uint firstPlace, uint excessVotes) {
        uint i = 1;

        while (i <= totalVoters)
            {
                if (voteList[i].firstChoice == firstPlace)
                    transferCount[voteList[i].secondChoice]++;
                i++;
            }
        i = 1;
        while (i <= totalVoters)
        {
            if (voteList[i].firstChoice == firstPlace)
                firstPlace = firstPlace; // JUST TO COMPILE
        }
    }

/*
** removeLoser replace the firstChoice with the secondChoice if the firstChoice is
** the loser.
*/
    function removeLoser (uint loser) {
        uint i = 1;
        
        while (i <= totalVoters)
            {
                if (voteList[i].firstChoice == loser)
                    voteList[i].firstChoice = voteList[i].secondChoice;
                if (voteList[i].secondChoice == loser)
                    voteList[i].secondChoice = 0;
                i++;
            }
    }
    
/*
** Just a tester function for decimal calculations.
** Not to be kept.
*/

    function testMath() returns (uint) {
        uint res;
        
        res = (8/12) * 6;
        return (res);
    }
    
    function countVote() {
        uint i = 1;
        
        while (i <= totalVoters)
        {
            if (ballot[voteList[i].firstChoice].init == true)
                ballot[voteList[i].firstChoice].voteCount++;
            if (ballot[voteList[i].secondChoice].init == true)
                ballot[voteList[i].secondChoice].secondVote++;
            i++;
        }
    }

    function endBallot() returns (uint firstPlace, uint secondPlace) {
            firstPlace = getWinner();
            secondPlace = getWinner();
    }
    
    function getWinner() returns (uint firstPlace) {
        uint requiredVotes = (totalVoters / 3) + 1;
        bool foundWinner = false;

        
        for (uint i = 1; ballot[i].init == true; i++) {
            if (ballot[i].voteCount >= requiredVotes && firstPlace == 0)
            {
                firstPlace = i;
                foundWinner = true;
            }
            else if (ballot[i].voteCount >= requiredVotes && ballot[i].voteCount > ballot[firstPlace].voteCount)
                firstPlace = i;
        }
        if (foundWinner == false)
        {
            findLoser();
            getWinner();
        }
        totalWinners++;
        foundWinner = false; // Not sure this is necessary.
        if (totalWinners < 2)
            transferExcess(firstPlace, (ballot[firstPlace].voteCount - requiredVotes));
    }
}
