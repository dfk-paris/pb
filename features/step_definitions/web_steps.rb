require 'minitest'

When(/^I am on "([^"]*)"$/) do |page|
  target = case page
    when 'the main page' then '/'
    else
      raise "unknown page '#{page}"
  end

  visit "https://google.com"
  visit target
end

When(/^I follow "([^"]*)"$/) do |link|
  click_link(link)
end

When(/^I press "([^"]*)"$/) do |button|
  click_button(button)
end

Then(/^I should see "([^"]*)"$/) do |text|
  assert page.has_content?(text)
end

Then(/^I debug$/) do
  byebug
end

When(/^I fill the following values$/) do |table|
  table.hashes.each do |assignment|
    fill_in assignment['field'], with: assignment['value']
  end
end
