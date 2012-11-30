Then /^I should be on the Menu screen$/ do
 check_element_exists "view:'UILabel' marked:'View Test Ideaboard'"
end

When /^I navigate to "(.*?)"$/ do |arg1|
  touch "view:'UILabel' marked:'View Test Ideaboard'"
end


Then /^I should be on the Sections screen$/ do
 sleep(1) 
 check_element_exists "view:'UILabel' marked:'Went Well'"
end
