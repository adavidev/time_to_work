require "json"
require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

class Driver
  def initialize(url = nil)
    @driver = Selenium::WebDriver.for :firefox
    @base_url = url || "http://localhost:3000/"
    @driver.manage.timeouts.implicit_wait = 30
    @accept_next_alert = true
    @verification_errors = []
  end

  def after_test
    @driver.quit
    @verification_errors.should == []
  end

  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end

  def alert_present?()
    @driver.switch_to.alert
    true
  rescue Selenium::WebDriver::Error::NoAlertPresentError
    false
  end

  def verify(&blk)
    yield
  rescue ExpectationNotMetError => ex
    @verification_errors << ex
  end

  def close_alert_and_get_its_text(how, what)
    alert = @driver.switch_to().alert()
    alert_text = alert.text
    if (@accept_next_alert) then
      alert.accept()
    else
      alert.dismiss()
    end
    alert_text
  ensure
    @accept_next_alert = true
  end

  def goto_signin_page
    @driver.get(@base_url + "/users/sign_in")
  end

  def try_login(username, password)
    @driver.find_element(:id, "user_email").clear
    @driver.find_element(:id, "user_email").send_keys "#{username}"
    @driver.find_element(:id, "user_password").clear
    @driver.find_element(:id, "user_password").send_keys "#{password}"
    @driver.find_element(:name, "commit").click
  end

  def test_text_element(id, message)
    (@driver.find_element(:id, id).text).should == "#{message}"
  end
end

describe "Login" do

  before(:each) do
    @test_driver = Driver.new
  end
  
  after(:each) do
    @test_driver.after_test
  end
  
  it "test_login" do
    @test_driver.goto_signin_page
    @test_driver.try_login("user@example.com", "badpass")
    @test_driver.test_text_element("flash_alert", "Invalid email or password.")
    @test_driver.try_login("user@example.com", "changeme")
    @test_driver.test_text_element("flash_notice", "Signed in successfully.")
  end

end
