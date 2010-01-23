Feature: Stories
  In order to choose a story I want to read
  As a visitor
  I want to see a list of all stories

  Scenario: Page Heading
    Given I am a vistor
    When I go to the stories page
    Then I should see "All Stories"
    
