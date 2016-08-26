require 'minitest'

module TestUrls
  def self.target_for(page)
    base = '/#'
    target = case page
      when 'the main page' then ''
      when 'the main entries list' then '/mes'
      else
        raise "unknown page '#{page}"
    end
    "#{base}#{target}"
  end
end

When(/^I (?:am on|go to) "([^"]*)"$/) do |page|
  visit TestUrls.target_for(page)
end

Then(/^I should be on "([^"]*)"$/) do |name|
  comparator = Proc.new do
    cu = URI.parse(current_url)
    fragment = "/##{cu.fragment}"
    "/##{cu.fragment}" == TestUrls.target_for(name)
  end

  start = Time.now
  while (Time.now - start) < Capybara.default_max_wait_time && !comparator.call
    sleep 0.1
  end

  cu = URI.parse(current_url)
  fragment = "/##{cu.fragment}"
  assert_equal fragment, TestUrls.target_for(name)
end

When(/^I follow( and confirm)? "([^"]*)"$/) do |confirm, link|
  if confirm.present?
    accept_confirm do
      click_link(link)
    end
  else
    click_link(link)
  end
end

When(/^I press "([^"]*)"$/) do |button|
  click_button(button)
end

Then(/^I should( not)? see "([^"]*)"$/) do |invert, text|
  if invert.present?
    assert page.has_no_content?(text)
  else
    assert page.has_content?(text)
  end
end

Then(/^I debug$/) do
  byebug
end

When(/^I fill in the following values$/) do |table|
  table.hashes.each do |assignment|
    fill_in assignment['field'], with: assignment['value']
  end
end

Given(/^a record of type "([^"]*)"$/) do |factory|
  x = FactoryGirl.create factory.to_sym
end

When(/^I follow( and confirm)? "([^"]*)" within main entry "([^"]*)"$/) do |confirm, link, scope|
  within page.find('div.main-entry', text: 'Kaiserliche Sitzgruppe') do
    step "I follow#{confirm} \"#{link}\""
  end
end

When(/^I wait for "([^"]*)" seconds$/) do |amount|
  sleep amount.to_f
end