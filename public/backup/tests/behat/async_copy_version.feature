@core @core_backup @javascript
Feature: Asynchronous course copying
  In order to duplicate course contents seamlessly
  As an admin
  I need to copy a course without running into backup version errors

  Background:
    Given the following "courses" exist:
      | fullname | shortname |
      | Course 1 | C1        |

  Scenario: Copy a course successfully without workaround
    When I log in as "admin"
    And I am on the "Course 1" "course" page
    And I navigate to "Course reuse" in current page administration
    And I click on "Copy course" "link"
    And I set the following fields to these values:
      | Course full name  | Course 1 Copy |
      | Course short name | C1COPY        |
    And I press "Copy and view"
    And I run all adhoc tasks
    Then I am on the "Course 1 Copy" "course" page
