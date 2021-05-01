-- 7
--SELECT DISTINCT [Manufacturer] FROM [Aircraft] WHERE [Manufacturer] IS NOT NULL ORDER BY [Manufacturer] ASC;

-- 6
--SELECT COUNT(*) FROM [ReservedSeat] WHERE [ScheduledFlightID] = 2 AND [Class] = 'Economy';

-- 5
SELECT COALESCE(SUM([Price]), 0) FROM [Reservation] WHERE [CustomerID] = 1 AND [Paid] = 0;

SELECT DISTINCT [Manufacturer] FROM [Aircraft] WHERE [Manufacturer] IS NOT NULL ORDER BY [Manufacturer] ASC;
--SELECT COUNT(DISTINCT [Manufacturer]), COUNT(DISTINCT (CASE WHEN [Manufacturer] IS NOT NULL THEN [Manufacturer] END)) FROM [Aircraft];

SELECT COUNT(DISTINCT [Manufacturer]) FROM [Aircraft] WHERE [Manufacturer] IS NOT NULL;

