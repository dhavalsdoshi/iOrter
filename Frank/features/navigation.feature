Feature: Navigating between screens

Scenario: Moving from the 'Menu' screen to the 'Sections' screen
Given I launch the app
Then I should be on the Menu screen

When I navigate to "View Test IdeaBoard"
Then I should be on the Sections screen
