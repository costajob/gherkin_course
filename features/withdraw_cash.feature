Feature: withdraw cash from ATM
  In order to get some cash
  As a bank account user
  I want to withdraw from ATM

Scenario: Successful withdrawal from an account
    Given i have $100 in my account
    When i request $20
    Then $20 should be dispensed
