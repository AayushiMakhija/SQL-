-- ROUND()

-- Take a static value and round up it to 2,1,0 value.

SELECT 3.516 , ROUND(3.516,2) AS round_2,
ROUND(3.516,1) AS round_1,
ROUND(3.516,0) AS round_0

-- ABS()

-- Take a static negative value and make it to absolute value.

SELECT -10 AS negative_value, ABS(-10) AS Absolute_value