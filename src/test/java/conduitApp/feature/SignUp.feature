
Feature: Sign Up new user

    Background: Preconditions
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * def timeValidator = read('classpath:helpers/timeValidator.js')
        * url apiUrl
@debug
    Scenario: New user Sign Up
        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomUsername = dataGenerator.getRandomUsername()

        Given path 'users'
        And request
        """
            {
                "user": {
                    "email": #(randomEmail),
                    "password": "123Karate123",
                    "username": #(randomUsername)
                }
            }
        """
        When method Post
        Then status 200
        And match response ==
        """
            {
                "user": {
                    "id": "#number",
                    "email": #(randomEmail),
                    "createdAt": "#? timeValidator(_)",
                    "updatedAt": "#? timeValidator(_)",
                    "username": #(randomUsername),
                    "bio": null,
                    "image": null,
                    "token": "#string"
                }
            }
        """