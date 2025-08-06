Feature: simple request
Scenario: Check status and response
  Given url 'http://jsonplaceholder.typicode.com/posts'
  When method get
  Then status 200

Scenario: Check status and response
  Given url 'http://jsonplaceholder.typicode.com/posts/1'
  When method get
  Then status 200
  And match response ==
    """
    {
  "userId": 1,
  "id": 1,
  "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
  "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
    }
    """
 Scenario: Check status and response
  Given url 'http://jsonplaceholder.typicode.com/posts/1/comments'
  When method get
  Then status 200
  And match response contains 
 """
 [{ 
  postId: 1, 
  id: 2, 
  name: "quo vero reiciendis velit similique earum", 
  email: "Jayne_Kuhic@sydney.com", 
  body: "est natus enim nihil est dolore omnis voluptatem numquam\net omnis occaecati quod ullam at\nvoluptatem error expedita pariatur\nnihil sint nostrum voluptatem reiciendis et" 
}]
  """
Scenario: Send POST request with JSON data
  Given url 'http://jsonplaceholder.typicode.com/posts'
  And request { title: 'foo', body: 'bar', userId: 1 }
  When method post
  Then status 201
  And match response ==
  """
  {"title":"foo","body":"bar","userId":1,"id":101}
  """
  

Scenario: Put Delete
  Given url 'http://jsonplaceholder.typicode.com/posts/1'
  And request { "id":1, "name":"mahesh" }
  When method put
  Then status 200
  And match response == 
  """
    {
  "id":1,
  "name":"mahesh"
    }
  """


Scenario: Delete Request
  Given url 'http://jsonplaceholder.typicode.com/posts/1'
  When method delete
  Then status 200
  And match response contains 
  """
  { }
  """

  Scenario: Send POST request to login endpoint
    * configure ssl = true
    Given url 'https://dummyjson.com/auth/login'
    And request { username: 'emilys', password: 'emilyspass' }
    When method post
    Then status 200
    * def accessToken = response.accessToken
    * karate.log('Access Token:', accessToken)

    Given url 'https://dummyjson.com/auth/me'
    And header Authorization = 'Bearer ' + accessToken
    When method get
    Then status 200
    * karate.log('User profile:', response)