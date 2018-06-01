//////////////////////////////////////////////////////////////////////////////
//
// The AST used for parsing .sanr files.
// @brief        This file contains the data structure needed for imploding
//							 a parsed .sanr tree.
// @contributor  Quinten Heijn - samuel.heijn@gmail.com - UvA
// @date         18-05-2018
//
//////////////////////////////////////////////////////////////////////////////

module sanr::language::AST

import sanr::language::Syntax;
import ParseTree;

//////////////////////////////////////////////////////////////////////////////
// APIs
//////////////////////////////////////////////////////////////////////////////

public sanr::language::AST::LevelSpecification implodeSAnR(Tree tree)
  = implode(#sanr::language::AST::LevelSpecification, tree);
  
public sanr::language::AST::LevelSpecification parseSAnRToAST(loc location)
	= implodeSAnR(parseSAnR(location));

//////////////////////////////////////////////////////////////////////////////
// AST
//////////////////////////////////////////////////////////////////////////////

anno loc Property@location;

data LevelSpecification
	= specification(list[Property] properties);
	
data Property
	= property(Condition condition, TileSet tileset);
	
data Condition
	= none()
	| count(int size);
	
data TileSet
	= tileSet(str tileName, FilterNow filterNow, FilterWhere filterWhere);
	
data FilterNow
	= nowAny()
	| nowAdjacent(str tileName);
	
data FilterWhere
	= everAny()
	| everRule(str ruleName);