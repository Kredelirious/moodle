@mod @mod_lesson @_file_upload
Feature: Teacher can import questions into a lesson activity

  Background:
    Given the following "users" exist:
      | username | firstname | lastname | email                |
      | teacher1 | Teacher   | One      | teacher1@example.com |
    And the following "courses" exist:
      | fullname | shortname |
      | Course 1 | C1        |
    And the following "course enrolments" exist:
      | user     | course | role           |
      | teacher1 | C1     | editingteacher |
    And the following "activities" exist:
      | activity | name          | course |
      | lesson   | Import lesson | C1     |

  @javascript
  Scenario Outline: Import questions into a lesson using different formats
    Given I am on the "Import lesson" "lesson activity" page logged in as "teacher1"
    And I follow "Import questions"
    And I set the field "File format" to "<format>"
    When I upload "mod/lesson/tests/fixtures/<filename>" file to "Upload" filemanager
    And I press "Import"
    Then I should see "Importing"
    And I press "Continue"
    And I should see "Lesson is currently being previewed."
    And I should see "<questiontext>"
    And I press "Edit page contents"
    And I set the field "Page contents" to "Edited page contents"
    And I press "Save page"
    And I should see "Edited page contents"

    Examples:
      | format     | filename                      | questiontext                   |
      | Moodle XML | multichoice.xml               | What language is being spoken? |
      | GIFT       | lesson_import_questions.gift  | What is 2 + 2?                 |
