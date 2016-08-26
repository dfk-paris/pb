system 'npm run build'

Selenium::WebDriver::Chrome.driver_path = '/opt/chromedriver'
Capybara.register_driver :chromium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end
Capybara.default_driver = :chromium
Capybara.javascript_driver = :chromium