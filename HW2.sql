-- HW2.sql -- Homework 2
--
-- Robert Earl Reed Jr. 
-- UT EID: rer945, UTCS username: robby35u
-- C S f347, Summer 2013, Dr. P. Cannata
-- Department of Computer Science, The University of Texas at Austin
--
--Problem 1
SELECT *
FROM vendors JOIN invoices
    ON vendors.vendor_id = invoices.vendor_id;
--
--Problem 2
SELECT vendor_name, invoice_number, invoice_date, 
    invoice_total - payment_total - credit_total AS balance_due
FROM vendors join invoices
    ON vendors.vendor_id = invoices.vendor_id
WHERE invoice_total - payment_total - credit_total <> 0
ORDER BY vendor_name;
--
--Problem 4
SELECT vendor_name, invoice_date, invoice_number, 
    invoice_sequence AS li_sequence, line_item_amt AS li_amount
FROM vendors ven 
    JOIN invoices inv
        ON ven.vendor_id = inv.vendor_id
    JOIN invoice_line_items li
        ON inv.invoice_id = li.invoice_id
ORDER BY vendor_name, invoice_date, invoice_number, li_sequence;
--
--Problem 6
SELECT acc.account_number, account_description 
FROM general_ledger_accounts acc 
    LEFT JOIN invoice_line_items li
        ON acc.account_number = li.account_number
WHERE li.account_number IS NULL
ORDER BY acc.account_number;
--
--Problem 7
