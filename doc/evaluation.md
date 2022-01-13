## Evaluation

This project evaluation will consist of two ~10 minute presentations each followed by 5-10 minutes of instructor led Q&A. 

### Part 1: Student Presentation

Project teams should break into pairs and each pair will present a single user story from start to finish. Include the following in the presentation:

- Choose a story that was especially difficult or tricky to implement  
- Read through the user story description on the card in the Github project board
- Demo the user story on Heroku, include both happy and sad paths and edge cases if applicable.
- Walk through the tests for the user story, including feature tests and any associated model/unit tests 
- Walk through the implementation of the user story including database schema, models, controllers, and views
- Slides are not required but encouraged as a way to supplement code sharing. 

### Part 2: Q&A

Students should be prepared to answer questions from the instructor surrounding the implementation of the user story focusing on the subject areas listed in the project rubric below. 

## Rubric

| | **Feature Completeness** | **Rails** | **ActiveRecord** | **Testing and Debugging** | **API Consumption** |
| --- | --- | --- | --- | --- | --- |
| **4: Exceptional**  | All User Stories 100% complete including all sad paths and edge cases, and some extension work completed | Students implement strategies not discussed in class and can defend their design decisions (callbacks, scopes, application_helper view methods are created, etc) | At least one ActiveRecord extension is complete | Students can point to multiple examples of edge case testing that are not included in the user stories | API Design demonstrates the principles of abstraction and encapsulation. Webmock is used to test API.
| **3: Passing** | Students complete all User Stories. No more than 2 Stories fail to correctly implement sad path and edge case functionality. | Students use the principles of MVC to effectively organize code with only 1 - 2 infractions. form_with is used to create forms. Routes and Actions mostly follow RESTful conventions, and routes are created with advanced routing techniques. Partials are used to dry up repeated view logic. | ActiveRecord helpers are utilized whenever possible. ActiveRecord is used in a clear and effective way to read/write data including use of grouping, aggregating, and joining. No Ruby is used to process data. All queries functional and accurately implemented. | 100% coverage for features and models. A gem that enhances testing effectiveness is implemented (orderly, factorybot, faker, etc). Tests are well written and meaningful. Tests utilize within blocks to target specific areas of a page | API consumption stories completed and fully functional |
| **2: Below Expectations** | Students complete all but 5 User Stories |  Students use the principles of MVC to effectively organize code, but may have more than 2 infractions. Some routes and actions are not restful, and student cannot defend those decisions. Project may fail to include one of the following: a partial that is included in at least two different views, form_with, advanced routing techniques | Ruby is used to process data that could use ActiveRecord instead. Some instances where ActiveRecord helpers are not utilized. Some queries not accurately implemented. | Feature test coverage between 90% and 98%, or model test coverage below 100%, or tests are not meaningfully written or have an unclear objective, or tests do not utilize within blocks | 1 or more API stories incomplete
| **1: Failing** | Students fail to complete 10 or more User Stories | Project fails to include two out of the following: a partial that is included in at least two different views, form_with, advanced routing techniques | Ruby is used to process data more often than ActiveRecord. Many cases where ActiveRecord helpers are not utilized. | Below 90% coverage for either features or models. | Project does not demonstrate any API consumption
