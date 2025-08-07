Feature: Sample API Testing

Scenario: Delete Request
  Given url 'http://jsonplaceholder.typicode.com/posts/1'
  When method delete
  Then status 200
  And print response
  And match response contains
    """
    { }
    """
