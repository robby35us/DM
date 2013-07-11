-- HW8.sql -- Homework 8
--
-- Robert Earl Reed Jr. 
-- UT EID: rer945, UTCS username: robby35u
-- C S f347, Summer 2013, Dr. P. Cannata
-- Department of Computer Science, The University of Texas at Austin
--
SET SERVEROUTPUT ON;
--
-- Problem 1
BEGIN
    UPDATE vendors
    SET vendor_name = 'FedUP'
    WHERE vendor_id = 122;
    
    UPDATE invoices
    SET vendor_id = 122
    WHERE vendor_id = 123;
    
    DELETE FROM vendors
    WHERE vendor_id = 123;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('The transaction was committed.');
EXCEPTION
    WHEN OTHERS THEN
       ROLLBACK;
       DBMS_OUTPUT.PUT_LINE('The transaction was rolled back.');
END;
/
--
-- Problem 2
BEGIN   
    DELETE FROM invoice_line_items
    WHERE invoice_id = 114;
    
    DELETE FROM invoices
    WHERE invoice_id = 114;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('The transaction was committed.');
EXCEPTION
    WHEN OTHERS THEN
       ROLLBACK;
       DBMS_OUTPUT.PUT_LINE('The transaction was rolled back.');
END;
/