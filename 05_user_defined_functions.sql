-- ==========================================================
-- FILE: 05_user_defined_functions.sql
-- DESCRIPTION: Creating and using a custom UDF (User-Defined Function)
-- ==========================================================

-- First, we need to change the delimiter so MySQL doesn't get confused 
-- by the semicolons inside the function body.
DELIMITER //

-- Creating a function that takes the original price and a discount rate (like 0.15)
-- and returns the final price.
CREATE FUNCTION CalculateDiscountedPrice(original_price DECIMAL(10,2), discount_rate DECIMAL(5,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE final_price DECIMAL(10,2);
    
    -- If discount is null or 0, just return the original price
    IF discount_rate IS NULL OR discount_rate = 0 THEN
        SET final_price = original_price;
    ELSE
        -- Calculate the price after discount (Price - (Price * Discount))
        SET final_price = original_price - (original_price * discount_rate);
    END IF;
    
    RETURN final_price;
END //

-- Change the delimiter back to normal
DELIMITER ;

-- ----------------------------------------------------------
-- USING THE FUNCTION
-- Let's test it out. We will look at the OrderItems table and 
-- calculate exactly how much the customer paid after the discount.
-- ----------------------------------------------------------
SELECT 
    oi.OrderID,
    p.ProductName,
    p.Price AS OriginalPrice,
    oi.Quantity,
    oi.Discount,
    -- Calling our custom function here!
    CalculateDiscountedPrice(p.Price, oi.Discount) AS PriceAfterDiscount,
    -- Calculating the total for that line item
    (CalculateDiscountedPrice(p.Price, oi.Discount) * oi.Quantity) AS TotalLineCost
FROM OrderItems oi
JOIN Products p ON oi.ProductID = p.ProductID;
