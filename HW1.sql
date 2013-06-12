-- HW1.sql -- Homework 1
--
-- Robert Earl Reed Jr. 
-- UT EID: rer945, UTCS username: robby35u
-- C S f347, Summer 2013, Dr. P. Cannata
-- Department of Computer Science, The University of Texas at Austin
--
-- Problem 5
SELECT vendor_name, vendor_contact_last_name, vendor_contact_first_name
FROM vendors
ORDER BY vendor_contact_last_name, vendor_contact_first_name;
--
-- Problem 6
SELECT vendor_contact_last_name || ', ' || vendor_contact_first_name 
    AS full_name
FROM vendors
WHERE vendor_contact_last_name < 'F' AND NOT SUBSTR(vendor_contact_last_name, 1, 1) = 'D'
ORDER BY full_name;
--
-- Problem 7
SELECT invoice_due_date AS "Due Date", invoice_total AS "Invoice Total",
    invoice_total / 10 AS "10%", invoice_total * 1.1 AS "Plus 10%"
FROM invoices
WHERE invoice_total BETWEEN 500 AND 1000
ORDER BY invoice_due_date DESC;
--
-- Problem 8
SELECT invoice_number AS "Number", invoice_total AS "Total", 
    payment_total + credit_total AS "Credits", 
    invoice_total - (payment_total + credit_total) AS "Balance Due"
FROM (SELECT * FROM invoices
      WHERE invoice_total - (payment_total + credit_total) >= 500
      ORDER BY invoice_total - (payment_total + credit_total) DESC)
WHERE ROWNUM <= 10
ORDER BY "Balance Due" DESC;
--
--Problem 9
SELECT invoice_total - (payment_total + credit_total) AS "Balance Due",
    payment_date
FROM invoices
WHERE payment_date IS NULL 
    AND invoice_total - (payment_total + credit_total) = 0;
--
--EXTRA CREDIT
--Problem 10
SELECT "Starting Principal", "Starting Principal" * 1.1 AS "New Principal",
    "Starting Principal" * .0715 AS "Interest", 
    "Starting Principal" * (1.1 + .0715) AS "Principal + Interest",
    TO_CHAR(SYSDATE, 'dd-mon-yyy hh24:mi:ss') AS "System Date"
FROM (SELECT 51000 AS "Starting Principal" 
      FROM dual);