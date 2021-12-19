# author: Ethosa

{.push size: sizeof(int8).}
type
  ColorStringParseError* = object of CatchableError
{.pop.}