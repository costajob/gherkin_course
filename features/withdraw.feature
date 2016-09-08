Feature: withdraw cash from account
  In order to get some cash
  As a bank account user
  I want to withdraw a given amount

Background:
  Given i have $100 in my account

Scenario: Successful withdrawal from an account
  When i request $20
  Then my balance should be $80

Scenario:
  But my PIN is blocked
  When i withdraw $50
  Then my request should be refuted
  And i am forced to reset my PIN
