//////////////////////////////////////////////////////////////////////////////
//
// Syntax for .sanr files.
// @brief        This files contains the syntax needed for parsing .sanr files.
//							 .sanr files contain the properties of a project
// @contributor  Quinten Heijn - samuel.heijn@gmail.com - UvA
// @date         18-06-2018
//
//////////////////////////////////////////////////////////////////////////////

module sanr::language::Syntax

import ParseTree;

//////////////////////////////////////////////////////////////////////////////
// Parser Rules
//////////////////////////////////////////////////////////////////////////////  
	
start syntax LevelSpecification 
	= specification: Property*;

syntax Property 
	= property: Condition TileSet;

syntax Condition         //required condition
  = none: "no"           //tile set is empty
  | count: INTEGER size "x"; //tile set size is
  
syntax TileSet //defines a set of tiles (now visible)
  = tileSet: IDENTIFIER tileName FilterNow FilterWhere;
  
syntax FilterNow //filters the tile set (now visible)
  = nowAny: //empty alternative, no filter 
  | nowAdjacent: "adjacent" "to" IDENTIFIER tileName;
  
syntax FilterWhere  //filters a tile set (historically)
  = everAny: //empty alternative, no filter
  | everRule: "in" IDENTIFIER ruleName; //topological locations
	
//////////////////////////////////////////////////////////////////////////////
// Lexer Rules
//////////////////////////////////////////////////////////////////////////////

lexical IDENTIFIER
  = @category="Name" ([a-zA-Z_$.] [a-zA-Z0-9_$.]* !>> [a-zA-Z0-9_$.]) \ Keyword;
 
lexical INTEGER
  = [0-9]+;

//////////////////////////////////////////////////////////////////////////////
// Layout
//////////////////////////////////////////////////////////////////////////////  

layout LAYOUTLIST
  = LAYOUT* !>> [\t-\n \r \ ];

lexical LAYOUT
  =  [\t-\n \r \ ];
  
keyword Keyword
  = "in"
  | "x"
  | "adjacent"
  | "to"
  | "no";
  
//////////////////////////////////////////////////////////////////////////////
// API
//////////////////////////////////////////////////////////////////////////////
  
public start[LevelSpecification] parseSAnR(loc file) = 
  parse(#start[LevelSpecification], file);
  
public start[LevelSpecification] parseSAnR(str input, loc location) 
{ 
	return parse(#start[LevelSpecification], input, location); 
}