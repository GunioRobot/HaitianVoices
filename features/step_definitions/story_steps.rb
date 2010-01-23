Given /^I am a vistor$/ do
  # regular web user
  # do nothing, no authentication
end

Given /^There are "([^\"]*)" stories$/ do |num|
  num.to_i.times {Factory(:story)}
end

