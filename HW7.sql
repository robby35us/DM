-- HW7.sql -- Homework 7
--
-- Robert Earl Reed Jr. 
-- UT EID: rer945, UTCS username: robby35u
-- C S f347, Summer 2013, Dr. P. Cannata
-- Department of Computer Science, The University of Texas at Austin
--
--Problem 5-1
SELECT vendor_id, SUM(invoice_total) AS invoice_total_amt
FROM invoices
GROUP BY vendor_id;
--
--PROBLEM 5-3
SELECT vendor_name, COUNT(*) AS number_of_invoices, 
    SUM(invoice_total) AS invoice_total_amt
FROM vendors v JOIN invoices i
     ON v.vendor_id = i.vendor_id
GROUP BY vendor_name
ORDER BY invoice_total_amt DESC;
--
--Problem 5-5
SELECT account_description, COUNT(*) AS number_of_invoices,
    SUM(line_item_amt) AS line_items_total_amt
FROM general_ledger_accounts gla JOIN invoice_line_items ila
    ON gla.account_number = ila.account_number
GROUP BY account_description
HAVING COUNT(*) > 1
ORDER BY line_items_total_amt DESC;
--
--Problem 6-1
SELECT vendor_name
FROM vendors
WHERE vendor_id IN
    (SELECT vendor_id
     FROM invoices)
ORDER BY vendor_name;
--
--Problem 6-3
SELECT account_number, account_description
FROM general_ledger_accounts
WHERE NOT EXISTS
    (SELECT *
     FROM invoice_line_items
     WHERE invoice_line_items.account_number 
         = general_ledger_accounts.account_number)
ORDER BY account_number;
