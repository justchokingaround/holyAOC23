Bool CheckChains(U8 *chain1, U8 *chain2)
{
  // if the two chains aren't of the same length, return
  if (StrLen(chain1) != StrLen(chain2))
  {
	"the lengths of the two chains don't match\n";
	return FALSE;
  }

  // iterate through each character in the first chain
  // and return false if the character which is at the 
  // corresponding position in the second chain doesn't
  // match the nucleotide
  I64 i;
  for (i = 0; i < StrLen(chain1); i++)
  {
	I8 *char = chain1[i];
	switch (char)
	{
	  case 'A':
	    if(chain2[i] != 'T')
	    {
		return FALSE;
	    }; break;
	  case 'T':
	    if(chain2[i] != 'A')
	    {
		return FALSE;
	    }; break;
	  case 'G':
	    if(chain2[i] != 'C')
	    {
		return FALSE;
	    }; break;

	  case 'C':
	    if(chain2[i] != 'G')
	    {
		return FALSE;
	    }; break;
	}
  }
  return TRUE;
}

U8 CreateMatchingSequence(U8 *inputChain)
{
  I64 i;
  I64 len = StrLen(inputChain);
  // initialize a char array with the length of the inputChain
  U8 matchingChain[len];

  // for each character in the inputChain, we will check its value
  // and assign the corresponding pair at the same index in the
  // matchingChain char array
  for (i = 0; i < len; i++)
  {
    switch(inputChain[i])
    {
      case 'A':
	matchingChain[i] = 'T'; break;
      case 'T':
	matchingChain[i] = 'A'; break;
      case 'G':
	matchingChain[i] = 'C'; break;
      case 'C':
	matchingChain[i] = 'G'; break;
    }

  }

  return matchingChain;

}


U8 GetChainInput()
{
  U8 *chain = StrNew(""); // without initializing this string like this, the first length == 0 check will fail
  while (StrLen(chain) == 0)
  {
    chain = GetStr("enter your chain:");
  }

  return chain;
}


// sample inputs from the exercise
U8 *chain1 = "ACGTT";
U8 *chain2 = "TGCAA";
U8 *chain3 = "GTTAC";

// throughout this implementation i decided to use PopUpOk()
// instead of simply printing strings to stdout. this is just
// because i wanted to goof around with it, simply printing
// "welcome to holy dna!\n";
// like it is done above will work just fine

PopUpOk("welcome to holy dna!");

Bool ChainsMatch = CheckChains(chain1, chain3);
if(ChainsMatch)
{
  PopUpOk("The chains are compatible.\n");
}
else
{
  PopUpOk("The chains are not compatible.\n");
}