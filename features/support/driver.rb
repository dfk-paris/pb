system 'npm run build'

Capybara.register_driver :chromium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.register_driver :marionette do |app|
  Selenium::WebDriver.for :firefox, marionette: true
end

Capybara.default_driver = :chromium
Capybara.javascript_driver = :chromium