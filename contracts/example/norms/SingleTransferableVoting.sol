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
** Creating proposal structure.
*/

	struct PropInfo {
        bool    init;
        uint    voteCount;
        uint    secondVote;
	}

/*
** Creating vote structure to be able to transfer votes to second choices when
** it is necessary.
*/
	struct oneVote {
	    uint firstChoice;
	    uint secondChoice;
	}
	
	uint    totalVotes;
    mapping (uint => PropInfo) ballot;




/*
** Constructor function receives the number of proposals.
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
    }
        
    function Vote(uint firstChoice, uint secondChoice) {

        if (ballot[firstChoice].init == true)
            ballot[firstChoice].voteCount++;
        if (ballot[secondChoice].init == true)
            ballot[secondChoice].secondVote++;
        if (ballot[firstChoice].init == true || ballot[secondChoice].init == true)
            totalVotes++;
    }

    function endBallot() returns (uint firstPlace, uint secondPlace) {
            firstPlace = getWinner();
    }
    
    function getWinner() returns (uint firstPlace) {
        uint requiredVotes = (totalVotes / 3) + 1;
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
            foundWinner = false; //Just to compile for now
    }
    
    function removeLoser () {
        
        
    }
}
