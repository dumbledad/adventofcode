# Advent of Code 2022

Advent of Code 2022 as part of getting back into Python https://adventofcode.com/

## Notes

- Python naming conventions
  - https://github.com/naming-convention/naming-convention-guides/tree/master/python (based on
  Guido's conventions)
  - https://softwareengineering.stackexchange.com/a/399583/50096
  - https://stackoverflow.com/a/48721872/575530 (variables)

## TODO

- [ ] Write unit tests
  - [x] For utility functions
  - [x] For the main functionality in parts 1 and 2
- [ ] Have these examples and answers served by Django, VueJS, and SVG
- [ ] Dockerize
- [ ] Use a cloud VM rather than local
- [ ] Make maximum use of
  - [ ] Functional programming style built in list etc. handling (e.g. `map`)
  - [ ] NumPy
  - [ ] Pandas

## Reflections

### Day 1

- Careful about the end of inputs, does the final `add` get triggered correctly
- Pandas `nlargest` was useful and [more performant](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.nlargest.html#pandas.DataFrame.nlargest) than sorting.
- Make sure the debugger is working

### Day 3

- `@classmethod` is handy to make things testable
- Use `pytest` and write simple unit tests as I go along so I have confidence about the utility methods

### Day 4

- Other code niceties are `_private_methods` (a convention) `@property` and `from functools import cached_property`
- Good tests really sped this up, but

### Day 5

- Edge conditions not present in test data floored me repeatedly. When I refactor it's important that tests catch new errors
- Are regexes simpler/better than raw indexes?
- `[::-1]` looked cryptic, but is just the `[start:stop:step]` and reverses the list
