-- Marco Stevanella 101307949
-- Q1
SET SERVEROUTPUT ON;
DECLARE
min_balance NUMBER := 2000;
CURSOR vendor_invoice_balance IS
SELECT
vendor_name,
invoice_number,
(invoice_total - credit_total - payment_total) AS balance_due
FROM invoices i JOIN vendors v ON i.vendor_id = v.vendor_id
WHERE (invoice_total - credit_total - payment_total) >= min_balance
ORDER BY 3 DESC;   
invoice_row invoices%ROWTYPE;
BEGIN
DBMS_OUTPUT.PUT_LINE('DATE: ' || SYSDATE);
DBMS_OUTPUT.PUT_LINE('My name: Marco Stevanella 101307949');
DBMS_OUTPUT.PUT_LINE('Invoice amounts greater than or equal to $' || min_balance);
DBMS_OUTPUT.PUT_LINE('=====================================');
FOR invoice_row IN vendor_invoice_balance LOOP
DBMS_OUTPUT.PUT_LINE(
TO_CHAR(invoice_row.balance_due, '$99,999.99') || ' - ' || invoice_row.invoice_number || ' - ' || invoice_row.vendor_name
);
END LOOP;
END;