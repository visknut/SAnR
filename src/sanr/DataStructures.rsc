//////////////////////////////////////////////////////////////////////////////
//
// SAnR Data Structures
// @brief        This file contains the data structures for validating
//							 the properties of a project.
// @contributor  Quinten Heijn - samuel.heijn@gmail.com - UvA
// @date         24-05-2018
//
//////////////////////////////////////////////////////////////////////////////

module sanr::DataStructures

import sanr::language::AST;

alias Map = list[list[str]];
alias Location = tuple[int x, int y];
alias PropertyStates = list[bool];

/* Constant that is used to talk about all tiles or rules. */
public str ALL = "null";
public str NULL = "null";

//////////////////////////////////////////////////////////////////////////////
// Report
//////////////////////////////////////////////////////////////////////////////

data PropertyReport 
	= propertyReport(LevelSpecification specification, list[ReportState] history);

data ReportState = 
	reportState(ExtendedTileMaps mapStates, PropertyStates propertyStates);

data ExtendedTileMaps
	=	extendedTileMaps(Map tileMap, Map ruleMap);