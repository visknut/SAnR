//////////////////////////////////////////////////////////////////////////////
//
// Parsing tests for .sanr files.
// @brief        This file contains tests for parsing .sanr files to an AST
// @contributor  Quinten Heijn - samuel.heijn@gmail.com - UvA
// @date         01-06-2018
//
//////////////////////////////////////////////////////////////////////////////

module sanr::tests::Parser

import sanr::language::AST;
import sanr::DataStructures;

//////////////////////////////////////////////////////////////////////////////
// Tests for parser.
//////////////////////////////////////////////////////////////////////////////

public test bool tryParsingAdjacency()
{
	/* Arrange */
	loc fileLocation = |project://SAnR/src/sanr/tests/testData/adjacency.sanr|;
		
	/* Act */
	parseSAnRToAST(fileLocation);
	
	/* Assert */
	return true;
}

public test bool tryParsingOccurrence()
{
	/* Arrange */
	loc fileLocation = |project://SAnR/src/sanr/tests/testData/occurrence.sanr|;
		
	/* Act */
	parseSAnRToAST(fileLocation);
	
	/* Assert */
	return true;
}

public test bool tryParsingOccurrenceAndContainment()
{
	/* Arrange */
	loc fileLocation = |project://SAnR/src/sanr/tests/testData/occurrenceAndContainment.sanr|;
		
	/* Act */
	parseSAnRToAST(fileLocation);
	
	/* Assert */
	return true;
}
