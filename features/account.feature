Feature: withdraw cash from account
  In order to get some cash
  As a bank account user
  I want to withdraw a given amount

Scenario: Successful withdrawal from an account
    Given i have $100 in my account
    When i request $20
    Then my balance should be $80
