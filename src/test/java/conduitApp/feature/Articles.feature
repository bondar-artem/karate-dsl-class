
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

    Scenario: Create and delete article
        Given header Authorization = 'Token ' + token
        Given path 'articles'
        And request {"article": {"tagList": [],"title": "Delete Article","description": "test test","body": "body"}}
        When method Post
        Then status 200
        * def articleId = response.article.slug

        Given params { limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title == 'Delete Article'

        Given header Authorization = 'Token ' + token
        Given path 'articles',articleId
        When method Delete
        Then status 200

        Given params { limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title != 'Delete Article'