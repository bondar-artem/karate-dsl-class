@ignore
Feature: Sign Up new user

    Background: Preconditions
        Given url apiUrl

    Scenario: New user Sign Up
        Given def userData = {"email":"KarateUser3@test.com", "username":"KarateUser32"}

        Given path 'users'
        And request
        """
            {
                "user": {
                    "email": #(userData.email),
                    "password": "123Karate123",
                    "username": #(userData.username)
                }
            }
        """
        When method Post
        Then status 200