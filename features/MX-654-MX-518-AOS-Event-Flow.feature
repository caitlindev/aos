
###########################################################
##Author  	: Sajesh
##Jira 		: MX-518/MX-654
##Version 	: 2
##Date 	  	: 17th June 2014
##BRDName 	: G4PlusMXBRD_AOSWorkControlApp_v.1.3_05-22-2014
##Description: Feature file for only AOS event Flow with AOS and SOS Event Codes
##########################################################




@todo
Feature:
  User  he/she should be able to add/view/modify/Return/Cancel AOS Event


  Background:	Given I am on the homepage

  Scenario Outline: TC1, As a Admin/user, I should be able to add new AOS Event without ATA Code with event type AOS , event code AOS and status code ADV

    Then I should see "AOS Work Control | G4 Pluse" in the "title" element
    Then I should see "Dashboard" in the "h1" element
    Then I should see "New Event" in the "button" element
    When I press "New Event"
    Then I should see "Add Work Event" in the "h1" element
    Then I should see "Event Type:" in the "label" element
    Then I should see "Time Stamp:" in the "label" element
    Then I should see "Tail Number:" in the "label" element
    Then I should see "Station:" in the "label" element
    Then I should see "Description:" in the "label" element
    Then I should see "UTC Advisory Date:" in the "label" element
    Then I should see "UTC Advisory Time:" in the "label" element
    Then I should see "Event Code:" in the "label" element
    Then I should see "Root Cause:" in the "label" element
    Then I should see "ATA Code:" in the "label" element
    Then I should see "Status Code:" in the "label" element
    Then I should see "Parts" in the "h1" element
    When I click "<Event Type>"
    When I fill in "Tail Number:" with "<tail>"
    When I fill in "Station:" with "<station>"
    When I fill in "UTC Advisory Date:" with "<UTC Advisory Date>"
    When I fill in "UTC Advisory Time:" with "<UTC Advisory Time>"
    When I fill in "Description:" with "<Description>"
    When I click "<Event Code>"
    When I click "<Status Code>"
    When I press "create"
    Then the response should contain "AOS event is added"
  Examples:
    |Event Type  |tail   |station    |UTC Advisory Date  |UTC Advisory Time|Description                  |Event Code |Status Code |
    |Aos Event   |915MV  |  LAS      |   07/01/2014      | 17:30           | Change fuel injector        |AOS        |ADV         |
    |AOS Event   |989NV  | NY        | 08/01/2014        | 19:00           | Change Radar Antenna        |SOS        |ADV         |

  Scenario: TC2, As a Admin/user, I should be able to Edit newly created AOS event

    Given I go to "#/edit/1"
    Then I should see "Event Type:" in the "label" element
    Then I should see "Time Stamp:" in the "label" element
    Then I should see "Tail Number:" in the "label" element
    Then I should see "Station:" in the "label" element
    Then I should see "Description:" in the "label" element
    Then I should see "UTC Advisory Date:" in the "label" element
    Then I should see "UTC Advisory Time:" in the "label" element
    Then I should see "Event Code:" in the "label" element
    Then I should see "Root Cause:" in the "label" element
    Then I should see "ATA Code:" in the "label" element
    Then I should see "Status Code:" in the "label" element
    Then I should see "Parts" in the "h1" element
    Then then "Tail Number:" field should contain "915MV"
    Then then "Station:" field should contain "LAS"
    Then then "UTC Advisory Date:" field should contain "07/01/2014"
    Then then "UTC Advisory Time:" field should contain "17:30"
    Then then "Description:" field should contain "Change fuel injector"
    When I click "ETR"
    When I press "Update"
    Then the response should contain "AOS event is Updated"


  Scenario: TC3, As a Admin/user, I should be able to Return to service for already created AOS event and status should automatically gets changed to RDY

    Given I go to "#/view/1"
    Then I should see "915MV" in the "h1" element
    Then I should see "Location" in the "h1" element
    Then I should see "Return to service" in the "button" element
    When I press "Return to service"
    Then I should see "Submitting this form will close this Event and Return the Tail to Service Be sure to add any closing comments or relevant documentation to the event before submitting" in the "Modal" element
    Then I should see "Which parts were used in the course of resolving this event?" in the "div" element
    Then I should see "Qty" in "label" element
    Then I should see "Part" in "label" element
    When I fill in "qty" with "1"
    Then I press "Submit"
    Then the response should contain "Tail Returned to Service"
    Then I should see text matching "RDY"

  Scenario: TC4, As a Admin/user, I should be able to cancel changes before saving/submitting

    Given I go to "#/edit/2"
    Then I should see "Event Type:" in the "label" element
    Then I should see "Time Stamp:" in the "label" element
    Then I should see "Tail Number:" in the "label" element
    Then I should see "Station:" in the "label" element
    Then I should see "Description:" in the "label" element
    Then I should see "UTC Advisory Date:" in the "label" element
    Then I should see "UTC Advisory Time:" in the "label" element
    Then I should see "Event Code:" in the "label" element
    Then I should see "Root Cause:" in the "label" element
    Then I should see "ATA Code:" in the "label" element
    Then I should see "Status Code:" in the "label" element
    Then I should see "Parts" in the "h1" element
    Then then "Tail Number:" field should contain "989NV"
    Then then "Station:" field should contain "NY"
    Then then "UTC Advisory Date:" field should contain "08/01/2014"
    Then then "UTC Advisory Time:" field should contain "19:00"
    Then then "Description:" field should contain "Change Radar Antenna"
    When I click "ETR"
    When I press "Cancel"
    Then I should see "View Work Event" in the "title" element

  Scenario: TC5, As a Admin/User , I should be able to print AOS Event

    Given I go to "#/view/2"
    Then I should see "989NV" in the "h1" element
    Then I should see "Location" in the "h1" element
    Then I should see "Return to service" in the "button" element
    Then I should see "Print" in the "button" element
    When I press "Print"
    Then I should see "Print" in the "h1" element
    Then I should see "Total:" in the "span" element
    Then I should see "print" in the "button" element
    When I press "Print"
    Then I should see "989NV" in "h1" element
    Then I should see "Location" in the "h1" element
    Then I should see "Return to service" in the "button" element
    Then I should see "Print" in the "button" element





  ######Scenario: TC4, As a Admin/user , I should be able to cancel already created AOS event ####################Pending not yet defined in Wireframe will complete once I receive UI MOck


