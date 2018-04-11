CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;

-------------------------------------------------------------
-- PLEASE DO NOT CHANGE ANY SQL STATEMENTS ABOVE THIS LINE --
-------------------------------------------------------------

-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT a.name as name, b.size as size from dogs as a, sizes as b
    where a.height > b.min and a.height <= b.max;

-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_height AS
  SELECT a.name as name from dogs as a, parents as b, dogs as c
    where a.name = b.child and b.parent = c.name
    order by c.height DESC ;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
    with 
      chart(name, parents, size) as (
        select a.child, a.parent, b.size from parents as a, size_of_dogs as b, dogs as c
          where c.name = a.child and c.name = b.name order by b.size 
          )
    select x.name || " and " || y.name || " are " || x.size || " siblings"
      from chart as x, chart as y
        where x.name < y.name and x.parents = y.parents and x.size = y.size;

-- Ways to stack 4 dogs to a height of at least 170, ordered by total height
CREATE TABLE stacks AS
  with 
    chart(number_dog, name, height, total) as(
      select 1, a.name, a.height, a.height from dogs as a UNION
      select x.number_dog+1, x.name || ", " || a.name, a.height, x.total+a.height
      from chart as x, dogs as a 
        where x.height<a.height
      )
  select x.name, x.total from chart as x where x.number_dog = 4 and x.total > 170 order by x.total;
