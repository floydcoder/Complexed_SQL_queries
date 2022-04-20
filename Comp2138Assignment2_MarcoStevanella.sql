-- Marco Stevanella 1013079490

-- ASGMT 2

SET SERVEROUTPUT ON;

-- Q 1

Select * from categories;
CREATE OR REPLACE PROCEDURE add_category
(
new_category_param  categories.category_name%TYPE
)
AS
BEGIN
  INSERT INTO categories 
  VALUES(category_id_seq.nextval, new_category_param);
  COMMIT;
END;
CALL add_category('Pianos');
CALL add_category('Trumpets');

-- Q 2

CREATE OR REPLACE FUNCTION discount_price(
  item_id_param order_items.item_id%TYPE 
) RETURN NUMBER
AS discount NUMBER;
BEGIN
  SELECT
    (item_price - discount_amount)
  INTO discount
  FROM order_items
  WHERE item_id = item_id_param;
  RETURN discount;
  EXCEPTION 
  WHEN no_data_found THEN RETURN 0;
END;

SELECT item_id, discount_price(item_id) AS discount FROM order_items;

-- Q 3

CREATE OR REPLACE TRIGGER products_before_update
BEFORE UPDATE OF discount_percent ON products
FOR EACH ROW
BEGIN
  IF (:new.discount_percent < 0)
  THEN
    raise_application_error(-20001,'Discount has to be greter or equal to 0');
  ELSIF (:new.discount_percent > 100)
  THEN
    raise_application_error(-20001,'Discount has to be less or equal then 100');
  ELSIF ((:new.discount_percent > 0) AND (:new.discount_percent < 1))
  THEN
  :new.discount_percent := :new.discount_percent * 100;
  DBMS_OUTPUT.PUT_LINE('The discount has been changed to' || :new.discount_percent);
  END IF;
END;

UPDATE products SET discount_percent = -8 WHERE product_id = 1;
UPDATE products SET discount_percent = 9 WHERE product_id = 1;
UPDATE products SET discount_percent = 177 WHERE product_id = 1;