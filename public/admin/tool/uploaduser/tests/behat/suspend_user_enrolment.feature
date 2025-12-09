@core @tool_uploaduser @_file_upload
Feature: Admin can suspend user course enrolment via CSV upload
  In order to manage enrolments in bulk
  As an administrator
  I need to be able to enrol and suspend users using CSV upload

  Background:
    Given the following "courses" exist:
      | fullname | shortname | category |
      | Course 1 | C1        | 0 |
      | Course 2 | C2        | 0 |
      | Course 3 | C3        | 0 |

  @javascript
  Scenario Outline: Upload CSVs and verify enrolment statuses
    Given I log in as "admin"

    When I navigate to "Users > Accounts > Upload users" in site administration
    And I upload "admin/tool/uploaduser/tests/fixtures/QA_user_enrol.txt" file to "File" filemanager
    And I press "Upload users"
    And I press "Upload users"
    And I press "Continue"

    And I upload "admin/tool/uploaduser/tests/fixtures/QA_user_suspend.txt" file to "File" filemanager
    And I press "Upload users"
    And I set the field "Upload type" to "Update existing users only"
    And I press "Upload users"
    And I press "Continue"

    And I am on the "Course 1" course page
    And I navigate to course participants
    And I wait "3600" seconds

    #Then the "<user>" row "Status" column should contain "<status>"

    # Examples:
    #   | course   | user      | status     |
    #   | Course 1 | learner1  | Active     |
    #   | Course 1 | learner2  | Active     |
    #   | Course 2 | learner1  | Active     |
    #   | Course 2 | learner2  | Suspended  |
    #   | Course 3 | learner1  | Suspended  |
    #   | Course 3 | learner2  | Active     |
