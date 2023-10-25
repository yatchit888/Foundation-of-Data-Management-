CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `gbc_superstore`.`executive_report` AS
    SELECT 
        `a`.`State` AS `State`,
        SUM((CASE
            WHEN (`o`.`OrderDate` BETWEEN '2021-10-01' AND '2021-12-31') THEN `s`.`Sales`
        END)) AS `Sales Current Quarter($)`,
        SUM((CASE
            WHEN (`o`.`OrderDate` BETWEEN '2021-07-01' AND '2021-09-30') THEN `s`.`Sales`
        END)) AS `Sales Last Quarter($)`,
        (SUM((CASE
            WHEN (`o`.`OrderDate` BETWEEN '2021-10-01' AND '2021-12-31') THEN `s`.`Sales`
        END)) - SUM((CASE
            WHEN (`o`.`OrderDate` BETWEEN '2021-07-01' AND '2021-09-30') THEN `s`.`Sales`
        END))) AS `Sales Comparison Last quarter vs. Current quarter(%)`,
        SUM((CASE
            WHEN (`o`.`OrderDate` BETWEEN '2020-10-01' AND '2020-12-31') THEN `s`.`Sales`
        END)) AS `Sales Same Quarter Last Year($)`,
        (SUM((CASE
            WHEN (`o`.`OrderDate` BETWEEN '2021-10-01' AND '2021-12-31') THEN `s`.`Sales`
        END)) - SUM((CASE
            WHEN (`o`.`OrderDate` BETWEEN '2020-10-01' AND '2020-12-31') THEN `s`.`Sales`
        END))) AS `Sales Comparison Last year vs. Actual(%)`,
        ((SUM((CASE
            WHEN (`o`.`OrderDate` BETWEEN '2021-10-01' AND '2021-12-31') THEN `s`.`Profit`
        END)) / SUM((CASE
            WHEN (`o`.`OrderDate` BETWEEN '2021-10-01' AND '2021-12-31') THEN `s`.`Sales`
        END))) * 100) AS `KPI: Net Profit Margin Ratio(%)`,
        ((SUM((CASE
            WHEN (`o`.`OrderDate` BETWEEN '2021-10-01' AND '2021-12-31') THEN `s`.`Price`
        END)) / SUM((CASE
            WHEN (`o`.`OrderDate` BETWEEN '2021-10-01' AND '2021-12-31') THEN `s`.`Sales`
        END))) * 100) AS `KPI: Discount Effective Rate(%)`
    FROM
        (((`gbc_superstore`.`addresses` `a`
        JOIN `gbc_superstore`.`order_records` `orr` ON ((`a`.`PostalCode` = `orr`.`PostalCode`)))
        JOIN `gbc_superstore`.`orders` `o` ON ((`orr`.`OrderID` = `o`.`OrderID`)))
        JOIN `gbc_superstore`.`sales` `s` ON ((`orr`.`OrderNo` = `s`.`OrderNo`)))
    GROUP BY `a`.`State` WITH ROLLUP