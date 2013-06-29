-- HW5.sql -- Homework 5
--
-- Robert Earl Reed Jr. 
-- UT EID: rer945, UTCS username: robby35u
-- C S f347, Summer 2013, Dr. P. Cannata
-- Department of Computer Science, The University of Texas at Austin
--
SET SERVEROUTPUT ON;
--
-- Problem 1
CREATE OR REPLACE PROCEDURE insert_glaccount
(
    account_number_param      general_ledger_accounts.account_number%TYPE,
    account_description_param general_ledger_accounts.account_description%TYPE
)
AS
BEGIN   
    INSERT INTO general_ledger_accounts
    VALUES (account_number_param, account_description_param);     
END;
/

CALL insert_glaccount(501, 'Just a test');
--
--PROBLEM 2
BEGIN 
    insert_glaccount(account_number_param=>300, 
        account_description_param=>'Just a test account');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('A DUP_VAL_ON_INDEX error occurred.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unknown exception occurred.');
END;
/
--
--PROBLEM 3
CREATE OR REPLACE FUNCTION test_glaccounts_description
(
    candidate_description_param 
        general_ledger_accounts.account_description%TYPE
)
RETURN NUMBER
AS
    test_result NUMBER;
BEGIN
    -- RETUNS 1 if present, 0 otherwise
    SELECT COUNT(*)
    INTO test_result
    FROM general_ledger_accounts
    WHERE account_description = candidate_description_param;
    
    RETURN test_result;
END;
/
--
--PROBLEM 4
DECLARE
    function_result NUMBER;
BEGIN
    function_result := test_glaccounts_description('FICA');
    
    IF function_result = 1 THEN
        DBMS_OUTPUT.PUT_LINE('Account description is already in use');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Account description is available.');
    END IF;
END;
/
--
--PROBLEM 5
CREATE OR REPLACE PROCEDURE insert_glaccount_with_test
(
    account_number_param      general_ledger_accounts.account_number%TYPE,
    account_description_param general_ledger_accounts.account_description%TYPE
)
AS
BEGIN   
    IF test_glaccounts_description(account_description_param) = 1 THEN
        RAISE VALUE_ERROR;
        -- RAISE_APPLICATION_ERROR(-20002, 'Duplicate account description')
    END IF;
        
    INSERT INTO general_ledger_accounts
    VALUES (account_number_param, account_description_param);     
END;
/