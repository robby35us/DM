-- HW4.sql -- Homework 4
--
-- Robert Earl Reed Jr. 
-- UT EID: rer945, UTCS username: robby35u
-- C S f347, Summer 2013, Dr. P. Cannata
-- Department of Computer Science, The University of Texas at Austin
--
-- Problem 1
SET SERVEROUTPUT ON;

DECLARE 
    count_invoices NUMBER;
BEGIN
    SELECT COUNT(invoice_id)
    INTO count_invoices
    FROM invoices 
    WHERE invoice_total - payment_total - credit_total >= 5000; 
    
DBMS_OUTPUT.PUT_LINE(count_invoices || ' invoices exceed $5,000.');
END;
/
--
-- Problem 2
DECLARE 
    count_invoices_due NUMBER;
    sum_invoices_due NUMBER;
BEGIN
    SELECT COUNT(invoice_id), SUM(invoice_total - payment_total - credit_total)
    INTO count_invoices_due, sum_invoices_due
    FROM invoices 
    WHERE invoice_total - payment_total - credit_total > 0;

    IF sum_invoices_due >= 50000 THEN
        DBMS_OUTPUT.PUT_LINE('Number of unpaid invoices is ' 
            || count_invoices_due || '.');
        DBMS_OUTPUT.PUT_LINE('Total balance due is $' 
            || TO_CHAR(sum_invoices_due, '$99,999.99') || '.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Total balance due is less than $50,000.');
    END IF;
END;
/  
--
-- Problem 3
DECLARE 
    CURSOR invoices_cursor IS
        SELECT vendor_name, invoice_number, 
            invoice_total - payment_total - credit_total AS balance_due
        FROM invoices i JOIN vendors v
            ON i.vendor_id = v.vendor_id
        WHERE invoice_total - payment_total - credit_total >= 5000
        ORDER BY balance_due DESC;
        
    invoice_row invoices%ROWTYPE;
    
BEGIN
    FOR invoice_row IN invoices_cursor LOOP
        DBMS_OUTPUT.PUT_LINE(TO_CHAR(invoice_row.balance_due, '$99,999.99')
            || '   ' || invoice_row.invoice_number || '   ' 
            || invoice_row.vendor_name);
    END LOOP;
END;
/  
--
-- Problem 4
DECLARE     
    CURSOR invoices_cursor_above_20000 IS
        SELECT vendor_name, invoice_number, 
            invoice_total - payment_total - credit_total AS balance_due
        FROM invoices i JOIN vendors v
            ON i.vendor_id = v.vendor_id
        WHERE invoice_total - payment_total - credit_total >= 20000
        ORDER BY balance_due DESC;
        
    CURSOR invoices_cursor_above_10000 IS
        SELECT vendor_name, invoice_number, 
            invoice_total - payment_total - credit_total AS balance_due
        FROM invoices i JOIN vendors v
            ON i.vendor_id = v.vendor_id
        WHERE invoice_total - payment_total - credit_total
             BETWEEN 10000 AND 19999.99
        ORDER BY balance_due DESC;
  
    CURSOR invoices_cursor_above_5000 IS
        SELECT vendor_name, invoice_number, 
            invoice_total - payment_total - credit_total AS balance_due
        FROM invoices i JOIN vendors v
            ON i.vendor_id = v.vendor_id
        WHERE invoice_total - payment_total - credit_total
            BETWEEN 5000 AND 9999.99
        ORDER BY balance_due DESC;
        
    invoice_row invoices%ROWTYPE;
    
BEGIN
    -- FIRST GROUP
    DBMS_OUTPUT.PUT_LINE('$20,000 or More');
    FOR invoice_row IN invoices_cursor_above_20000 LOOP
        DBMS_OUTPUT.PUT_LINE(TO_CHAR(invoice_row.balance_due, '$99,999.99')
            || '   ' || invoice_row.invoice_number || '   ' 
            || invoice_row.vendor_name);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');
    
    -- SECOND GROUP
    DBMS_OUTPUT.PUT_LINE('$10,000 to $20,000');
    FOR invoice_row IN invoices_cursor_above_10000 LOOP
        DBMS_OUTPUT.PUT_LINE(TO_CHAR(invoice_row.balance_due, '$99,999.99')
            || '   ' || invoice_row.invoice_number || '   ' 
            || invoice_row.vendor_name);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');
    
    -- THIRD GROUP
    DBMS_OUTPUT.PUT_LINE('$5,000 to $10,000');
    FOR invoice_row IN invoices_cursor_above_5000 LOOP
        DBMS_OUTPUT.PUT_LINE(TO_CHAR(invoice_row.balance_due, '$99,999.99')
            || '   ' || invoice_row.invoice_number || '   ' 
            || invoice_row.vendor_name);
    END LOOP;
END;
/  
--
-- Problem 5
VARIABLE min_balance_due NUMBER;
BEGIN
    :min_balance_due := &minimum_balance_due;
END;
/

DECLARE
    CURSOR invoices_cursor IS
        SELECT vendor_name, invoice_number, 
            invoice_total - payment_total - credit_total AS balance_due
        FROM invoices i JOIN vendors v
            ON i.vendor_id = v.vendor_id
        WHERE invoice_total - payment_total - credit_total >= :min_balance_due
        ORDER BY balance_due DESC;
        
    invoice_row invoices%ROWTYPE;
    
BEGIN
    DBMS_OUTPUT.PUT_LINE('Invoice amounts greater than or equal to '
        || TO_CHAR(:min_balance_due, '$99,999.99'));
    FOR invoice_row IN invoices_cursor LOOP
        DBMS_OUTPUT.PUT_LINE(TO_CHAR(invoice_row.balance_due, '$99,999.99')
            || '   ' || invoice_row.invoice_number || '   ' 
            || invoice_row.vendor_name);
    END LOOP;
END;
/  