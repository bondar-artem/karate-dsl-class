
Feature: Articles

    Background: Define URL
        Given url 'https://conduit.productionready.io/api/'
        Given path 'users/login'
        And request {"user": {"email": "karate@test.com","password": "karate123"}}
        When method Post
        Then status 200
        * def token = response.user.token

    Scenario: Create a new article
        Given header Authorization = 'Token ' + token
        Given path 'articles'
        And request {"article": {"tagList": [],"title": "Bla bla","description": "test test","body": "body"}}
        When method Post
        Then status 200
        And match response.article.title == 'Bla bla'