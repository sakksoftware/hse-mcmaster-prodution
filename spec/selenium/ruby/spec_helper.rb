require "dotenv"
require "rspec"
include RSpec::Expectations
require "selenium-webdriver"
require "pry"

# output T/F as Green/Red
ENV['RSPEC_COLOR'] = 'true'

# Input capabilities
caps = Selenium::WebDriver::Remote::Capabilities.new
caps["browserName"] = 'android'
caps["platform"] = 'ANDROID'
caps["device"] = 'Google Nexus 5'
caps["browserstack.debug"] = "true"
caps["name"] = "Testing Selenium 2 with Ruby on BrowserStack"

RSpec.configure do |config|
  config.before(:each) do
    if ENV['REMOTE']
      @driver = Selenium::WebDriver.for(:remote,
        :url => ENV['BROWSER_STACK_LINK'],
        :desired_capabilities => caps)
    else
      @driver = Selenium::WebDriver.for(:chrome)
    end

    @base_url = "https://www.healthsystemsevidence.org"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
  end

  config.after(:each) do
    @driver.quit
  end
end
