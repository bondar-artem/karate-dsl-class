
Feature: Tests for the home page

    Background: Define URL
        Given url apiUrl

    Scenario: Get all tags
        Given path 'tags'
        When method Get
        Then status 200
        And match response.tags == "#array"
        And match each response.tags == "#string"

    Scenario: Get 10 articles from the page
        * def timeValidator = read('classpath:helpers/timeValidator.js')

        Given params { limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        And match response == { "articles": "#[10]", "articlesCount": 500}
        And match each response.articles ==
        """
            {
                "title": "#string",
                "slug": "#string",
                "body": "#string",
                "createdAt": "#? timeValidator(_)",
                "updatedAt": "#? timeValidator(_)",
                "tagList": "#array",
                "description": "#string",
                "author": {
                    "username": "#string",
                    "bio": "##string",
                    "image": "#string",
                    "following": '#boolean'
                },
                "favorited": '#boolean',
                "favoritesCount": '#number'
            }
        """

    Scenario: Conditional logic
        Given params { limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        * def favoritesCount = response.articles[0].favoritesCount
        * def article = response.articles[0]

        #* if (favoritesCount == 0) karate.call('classpath:helpers/AddLikes.feature', article)

        * def result = favoritesCount == 0 ? karate.call('classpath:helpers/AddLikes.feature', article).likesCount : favoritesCount

        Given params { limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].favoritesCount == result
@ignore
    Scenario: Retry call
        * configure retry = { count: 10, interval: 5000 }
        
        Given params { limit: 10, offset: 0}
        Given path 'articles'
        And retry until response.articles[0].favoritesCount == 1
        When method Get
        Then status 200

    Scenario: Sleep call
        * def sleep = function(pause){ java.lang.Thread.sleep(pause) }
        
        Given params { limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        * eval sleep(10000)
        Then status 200

    Scenario: Number to string
        * def foo = 10
        * def json = {"bar": #(foo+'')}
        * match json == {"bar": '10' }

    Scenario: String to number
        * def foo = '10'
        * def json = {"bar": #(foo*1)}
        * def json2 = {"bar": #(~~parseInt(foo))}
        * match json == {"bar": 10 }
        * match json2 == {"bar": 10 }