@block @block_glossary_random @mod @mod_glossary
Feature: Verify that entries are displayed in a specific order in the random glossary block
  In order to display glossary entries in a predictable or random manner
  As a teacher
  I need to configure the random glossary block display order

  Background:
    Given the following "users" exist:
      | username | firstname | lastname | email                |
      | teacher1 | Teacher   | 1        | teacher1@example.com |
    And the following "courses" exist:
      | fullname | shortname |
      | Course 1 | C1        |
    And the following "course enrolments" exist:
      | user     | course | role           |
      | teacher1 | C1     | editingteacher |
    And the following "activities" exist:
      | activity | name    | course | idnumber |
      | glossary | animals | C1     | gloss1   |
    And the following "mod_glossary > entries" exist:
      | glossary | concept  | definition   |
      | animals  | zebra    | zebra def    |
      | animals  | aardvark | aardvark def |
      | animals  | kangaroo | kangaroo def |
    And the following "blocks" exist:
      | blockname       | contextlevel | reference | pagetypepattern | defaultregion |
      | glossary_random | Course       | C1        | course-view-*   | side-pre      |

  @javascript
  Scenario Outline: Display glossary entries in various orders
    Given I log in as "teacher1"
    And I am on "Course 1" course homepage with editing mode on
    When I configure the "Random glossary entry" block
    And I set the following fields to these values:
      | Title                           | Glossary Block |
      | Take entries from this glossary | animals        |
      | How a new entry is chosen       | <order>        |
    And I press "Save changes"
    Then I should see "<check1>" in the "Glossary Block" "block"
    And I reload the page
    And I should see "<check2>" in the "Glossary Block" "block"
    And I reload the page
    And I should see "<check3>" in the "Glossary Block" "block"

    Examples:
      | order               | check1   | check2   | check3   |
      | Last modified entry | kangaroo | kangaroo | kangaroo |
      | Next entry          | zebra    | aardvark | kangaroo |
      | Alphabetical order  | aardvark | kangaroo | zebra    |
      | Random entry        | def      | def      | def      |
