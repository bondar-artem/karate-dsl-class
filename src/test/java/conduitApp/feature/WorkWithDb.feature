@ignore
Feature: work with DB

    Background: connect to db
        * def dbHandler = Java.type('helpers.DbHandler')

    Scenario: Seed database with a new Job
        * eval dbHandler.addNewJobWithName("QA7")


    Scenario: Get level for Job
        * def level = dbHandler.getMinAndMaxLevelsForJob("QA7")
        * print level.minLvl
        * print level.maxLvl
        And match level.minLvl == '80'
        And match level.maxLvl == '120'
