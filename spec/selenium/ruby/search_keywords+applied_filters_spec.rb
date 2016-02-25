require './spec_helper'
describe "SearchKeywordsAppliedFilters" do
  it "test_search_keywords_applied_filters" do
    @driver.get(@base_url + "/")
    sleep 2
    @driver.find_element(:id, "search").clear
    @driver.find_element(:id, "search").send_keys "hiv\n"
    @driver.find_element(:xpath, "//div[@id='page-content']/div/div/div[3]/div[2]/ul[2]/li/a/span[2]").click
    @driver.find_element(:xpath, "//*[normalize-space()='Governance arrangements']").click
    @driver.find_element(:xpath, "//*[normalize-space()='Centralization/decentralization of policy authority']").click
    @driver.find_element(:css, "div.layered-navigation-overlay").click
    @driver.find_element(:css, "div.layered-navigation-overlay").click
    sleep 2
    expect(@driver.find_element(:css, "div.result-box-count > span").text).to eq("38")
  end
end
