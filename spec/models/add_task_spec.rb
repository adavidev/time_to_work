require "json"
require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

describe "AddTaskSpec" do
  let(:sel) { SelDriver.new(:firefox, "http://localhost:3000/") }

  subject { sel }

  after(:each) do
    sel.quit
  end

  it "should add a task" do
    subject.get(sel.base_url + "/")
    sel.find_element(:link, "New Task").click
    sel.type(sel.id("task_name"), "Alan")
    sel.type(sel.id("task_context"), "None")
    sel.id("task_done").click
    sel.name("commit").click
    sel.find_element(:link, "Back").click
    sel.verify { (sel.find_element(:xpath, "//td[3]").text).should == "2015-05-21" }
  end
end
