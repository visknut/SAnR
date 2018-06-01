//////////////////////////////////////////////////////////////////////////////
//
// Property validation test
// @brief        This file contains test to confirm the expected output
//							 from PropertyValidation.rsc
// @contributor  Quinten Heijn - samuel.heijn@gmail.com - UvA
// @date         01-06-2018
//
//////////////////////////////////////////////////////////////////////////////

module sanr::tests::Validation

import sanr::language::AST;
import sanr::PropertyValidation;
import sanr::DataStructures;

//////////////////////////////////////////////////////////////////////////////
// Tests for complete validation.
//////////////////////////////////////////////////////////////////////////////

public test bool completeProperty()
{
	/* Arrange */
	Property property = property(count(1), tileSet("t1", nowAdjacent("t1"), everRule("r1")));
	Map ruleMap = [["r0", "r0"], 
								 ["r0", "r1"]];
	ExtendedTileMaps mapStates =	extendedTileMaps([[]], ruleMap);
	list[ReportState] history = [reportState(mapStates, [])]; 
	Map currentTileMap = [["t0", "t1"], 
								 				["t0", "t1"]];							 				
	
	/* Act & Assert */
	return checkProperty(property, history, currentTileMap);
}

//////////////////////////////////////////////////////////////////////////////
// Tests for filter now.
//////////////////////////////////////////////////////////////////////////////

public test bool filterOnAdjacencyTrue()
{
	/* Arrange */
	FilterNow adjacencyFilter = nowAdjacent("2");
	Map currentTileMap = [["0", "0"], 
												["2", "1"]];
	set[Location] tileSet = {<1,1>};
	
	set[Location] expectedResult = tileSet;	
	
	/* Act */
	set[Location] result = filterNow(adjacencyFilter, currentTileMap, tileSet);
	
	/* Assert */
	return expectedResult == result;
}

public test bool filterOnAdjacencyFalse()
{
	/* Arrange */
	FilterNow adjacencyFilter = nowAdjacent("2");
	Map currentTileMap = [["2", "0"], 
												["0", "1"]];
	set[Location] tileSet = {<1,1>};
	
	set[Location] expectedResult = {};	
	
	/* Act */
	set[Location] result = filterNow(adjacencyFilter, currentTileMap, tileSet);
	
	/* Assert */
	return expectedResult == result;
}

//////////////////////////////////////////////////////////////////////////////
// Tests for filter where.
//////////////////////////////////////////////////////////////////////////////

public test bool filterOnContainmentTrue()
{
	/* Arrange */
	FilterWhere containmentFilter = everRule("1");
	Map ruleMap = [["0", "0"], 
								 ["0", "1"]];
	ExtendedTileMaps mapStates =	extendedTileMaps([[]], ruleMap);
	list[ReportState] history = [reportState(mapStates, [])];
	set[Location] tileSet = {<1,1>};
	
	set[Location] expectedResult = {<1,1>};
	
	/* Act */
	set[Location] result = filterWhere(containmentFilter, history, tileSet);

	/* Assert */
	return expectedResult == result;
}

public test bool filterOnContainmentFalse()
{
	/* Arrange */
	FilterWhere containmentFilter = everRule("1");
	Map ruleMap = [["0", "0"], 
								 ["0", "0"]];
	ExtendedTileMaps mapStates =	extendedTileMaps([[]], ruleMap);
	list[ReportState] history = [reportState(mapStates, [])];
	set[Location] tileSet = {<1,1>};
	
	set[Location] expectedResult = {};	
	
	/* Act */
	set[Location] result = filterWhere(containmentFilter, history, tileSet);

	/* Assert */
	return expectedResult == result;
}