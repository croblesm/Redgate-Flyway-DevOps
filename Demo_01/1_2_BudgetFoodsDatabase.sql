
-- ==============================================================================
-- 
-- Script name   :   1_2_BudgetFoodsDatabase.sql
-- Description   :   Check BudgetFoods database after Flyway migrations
-- Author        :   Carlos Robles
-- Email         :   crobles@dbamastery.com
-- Twitter       :   @dbamastery
-- Date          :   20200701
--   
-- Notes         :   N/A
-- 
-- ==============================================================================

-- Checking customers, products and orders
SELECT * FROM public.customers;
SELECT * FROM public.products;
SELECT * FROM public.orders;