CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `gbc_superstore`.`operational_report` AS
    SELECT 
        `a`.`Region` AS `Region`,
        `a`.`State` AS `State`,
        `a`.`City` AS `City`,
        `p`.`SubCategory` AS `SubCategory`,
        `p`.`ProductName` AS `ProductName`,
        SUM(`s`.`Quantity`) AS `Quantity`,
        SUM(`s`.`Sales`) AS `Sales`,
        SUM(`s`.`Profit`) AS `Profit`
    FROM
        (((`gbc_superstore`.`addresses` `a`
        JOIN `gbc_superstore`.`order_records` `o` ON ((`a`.`PostalCode` = `o`.`PostalCode`)))
        JOIN `gbc_superstore`.`sales` `s` ON ((`o`.`OrderNo` = `s`.`OrderNo`)))
        JOIN `gbc_superstore`.`products` `p` ON ((`o`.`ProductID` = `p`.`ProductID`)))
    GROUP BY `a`.`Region` , `a`.`State` , `a`.`City` , `p`.`SubCategory` , `p`.`ProductName` WITH ROLLUP