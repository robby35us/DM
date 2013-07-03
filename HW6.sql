-- HW6.sql -- Homework 6
--
-- Robert Earl Reed Jr. 
-- UT EID: rer945, UTCS username: robby35u
-- C S f347, Summer 2013, Dr. P. Cannata
-- Department of Computer Science, The University of Texas at Austin
--
SET SERVEROUTPUT ON;
--
--Problem 1
CREATE OR REPLACE TRIGGER invoices_before_update_payment
BEFORE UPDATE OF payment_total
ON invoices
FOR EACH ROW
WHEN (NEW.credit_total + NEW.payment_total > NEW.invoice_total)
BEGIN
    RAISE_APPLICATION_ERROR(-20001,
        'invoice_credit + payment_total may not exceed the maximum ' ||
        ' invoice_total value');
END;
/
--
UPDATE invoices
SET payment_total = 170
WHERE invoice_id = 1;
--
--Problem 2
CREATE OR REPLACE TRIGGER invoices_after_update_payment
FOR UPDATE OF payment_total
ON invoices
COMPOUND TRIGGER
    TYPE invoice_ids_table   IS TABLE OF invoices.invoice_id%TYPE;
    invoice_ids              invoice_ids_table;
    
    counter NUMBER := 1;
    AFTER EACH ROW IS
    BEGIN
        IF :NEW.payment_total > :OLD.payment_total THEN
            invoice_ids(counter) := NEW.invoice_id;
            counter := counter + 1;
        END IF;
    END AFTER EACH ROW;

    AFTER STATEMENT IS
    BEGIN
        SELECT vendor_name, invoice_number, payment_table
        FROM invoices inv JOIN vendors v
            USING vendor_id
        WHERE invoice_id IN invoice_ids_table;
    END AFTER STATEMENT;
END;
/
