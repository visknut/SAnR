//////////////////////////////////////////////////////////////////////////////
//
// Property Validation
// @brief        This file contains the function that validate a sanr property.
// @contributor  Quinten Heijn - samuel.heijn@gmail.com - UvA
// @date         22-05-2018
//
//////////////////////////////////////////////////////////////////////////////

module sanr::PropertyValidation

import IO;
import List;
import Set;
import sanr::DataStructures;
import sanr::language::AST;

public bool checkProperty
(
	property(Condition condition, TileSet setInfo), 
	list[ReportState] history,
	Map currentTileMap
)
{
	/* Create set from all matching tiles. */
	set[Location] tileSet = {<x, y>
		| int x <- [0 .. size(currentTileMap[0])], 
		int y <- [0 .. size(currentTileMap)], 
		currentTileMap[y][x] == setInfo.tileName};

	/* Apply filters. */
	tileSet = filterNow(setInfo.filterNow, currentTileMap, tileSet);
	tileSet = filterWhere(setInfo.filterWhere, history, tileSet);

	/* Check condition. */
	switch (condition)
	{
		case exact(int setSize):
		{
			return size(tileSet) == setSize;
		}
		case atLeast(int setSize):
		{
			return size(tileSet) >= setSize;
		}
		case atMost(int setSize):
		{
			return size(tileSet) <= setSize;
		}
	}
}

//////////////////////////////////////////////////////////////////////////////
// Filter now.
//////////////////////////////////////////////////////////////////////////////

public set[Location] filterNow
(
	nowAny(),
	Map currentTileMap,
	set[Location] tileSet
)
{
	return tileSet;
}

public set[Location] filterNow
(
	nowAdjacent(str tileName),
	Map currentTileMap,
	set[Location] tileSet
)
{
	for (Location l <- tileSet)
	{
		if (! ((((l.y > 0) ? currentTileMap[l.y-1][l.x] : NULL) == tileName)
				|| (((l.y < size(currentTileMap) - 1) ? currentTileMap[l.y+1][l.x] : NULL) == tileName)
				|| (((l.x > 0) ? currentTileMap[l.y][l.x-1] : NULL) == tileName)
				|| (((l.x < size(currentTileMap[0]) -1) ? currentTileMap[l.y][l.x+1] : NULL) == tileName)))
		{
		tileSet = tileSet - {l};
		}
	}
	return tileSet;
}

//////////////////////////////////////////////////////////////////////////////
// Filter where.
//////////////////////////////////////////////////////////////////////////////

public set[Location] filterWhere
(
	everAny(),
	list[ReportState] history,
	set[Location] tileSet
)
{
	return tileSet;
}

public set[Location] filterWhere
(
	everRule(str ruleName),
	list[ReportState] history,
	set[Location] tileSet
)
{
	set[Location] filteredSet = {};
	for (Location l <- tileSet)
	{
		for (ReportState state <- history)
		{
			if (state.mapStates.ruleMap[l.y][l.x] == ruleName)
			{
				filteredSet = filteredSet + {l};
				break;
			}
		}
	}
	return filteredSet;
}