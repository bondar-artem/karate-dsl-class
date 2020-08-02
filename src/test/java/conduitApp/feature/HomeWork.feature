
Feature: Home Work

    Background: Preconditions
        * url apiUrl 

    Scenario: Favorite articles
        # Step 1: Get atricles of the global feed
        # Step 2: Get the favorites count and slug ID for the first arice, save it to variables
        # Step 3: Make POST request to increse favorites count for the first article
        # Step 4: Verify response schema
        # Step 5: Verify that favorites article incremented by 1
            #Example
            * def initialCount = 0
            * def response = {"favoritesCount": 1}
            * match response.favoritesCount == initialCount + 1

        # Step 6: Get all favorite articles
        # Step 7: Verify response schema
        # Step 8: Verify that slug ID from Step 2 exist in one of the favorite articles

    Scenario: Comment articles
        # Step 1: Get atricles of the global feed
        # Step 2: Get the slug ID for the first arice, save it to variable
        # Step 3: Make a GET call to 'comments' end-point to get all comments
        # Step 4: Verify response schema
        # Step 5: Get the count of the comments array lentgh and save to variable
            #Example
            * def responseWithComments = [{"article": "first"}, {article: "second"}]
            * def articlesCount = responseWithComments.length
        # Step 6: Make a POST request to publish a new comment
        # Step 7: Verify response schema that should contain posted comment text
        # Step 8: Get the list of all comments for this article one more time
        # Step 9: Verify number of comments increased by 1 (similar like we did with favorite counts)
        # Step 10: Make a DELETE request to delete comment
        # Step 11: Get all comments again and verify number of comments decreased by 1