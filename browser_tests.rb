require "json"
require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

describe "calcurun" do
  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "file:///#{Dir.pwd}/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end
  
  after(:each) do
    @driver.quit
    @verification_errors.should == []
  end
  
  it "test_mm_value" do
    @driver.get(@base_url + "index.html")
    @driver.find_element(:id, "calc_units_miles").click
    @driver.find_element(:id, "calc_utom_uph").clear
    @driver.find_element(:id, "calc_utom_uph").send_keys("10")
    @driver.find_element(:id, "calc_utom_uph_to_mpm").click
    verify { (@driver.find_element(:id, "calc_utom_mm").attribute("value")).should == "6" }
  end

  it "test_mk_value" do
    @driver.get(@base_url + "index.html")
    @driver.find_element(:id, "calc_units_km").click
    @driver.find_element(:id, "calc_utom_uph").clear
    @driver.find_element(:id, "calc_utom_uph").send_keys("10")
    @driver.find_element(:id, "calc_utom_uph_to_mpm").click
    verify { (@driver.find_element(:id, "calc_utom_mm").attribute("value")).should == "6" }
  end

  it "test_mh_value" do
    @driver.get(@base_url + "index.html")
    @driver.find_element(:id, "calc_units_miles").click
    @driver.find_element(:id, "calc_utom_mm").clear
    @driver.find_element(:id, "calc_utom_mm").send_keys("8")
    @driver.find_element(:id, "calc_utom_ss").clear
    @driver.find_element(:id, "calc_utom_ss").send_keys("00")
    @driver.find_element(:id, "calc_utom_mpm_to_uph").click
    verify { (@driver.find_element(:id, "calc_utom_uph").attribute("value")).should == "7.500" }
  end

  it "test_kh_value" do
    @driver.get(@base_url + "index.html")
    @driver.find_element(:id, "calc_units_km").click
    @driver.find_element(:id, "calc_utom_mm").clear
    @driver.find_element(:id, "calc_utom_mm").send_keys("8")
    @driver.find_element(:id, "calc_utom_ss").clear
    @driver.find_element(:id, "calc_utom_ss").send_keys("00")
    @driver.find_element(:id, "calc_utom_mpm_to_uph").click
    verify { (@driver.find_element(:id, "calc_utom_uph").attribute("value")).should == "7.500" }
  end

  it "test_mpm_distances" do
    @driver.get(@base_url + "index.html")
    @driver.find_element(:id, "calc_units_miles").click    
    @driver.find_element(:id, "calc_dist_mm").clear
    @driver.find_element(:id, "calc_dist_mm").send_keys("6")
    @driver.find_element(:id, "calc_dist_ss").clear
    @driver.find_element(:id, "calc_dist_ss").send_keys("0")
    @driver.find_element(:id, "calc_dist_calc_time").click    
    verify { (@driver.find_element(:id, "calc_dist_results_10_mile").text).should == "1:00:00.00" }        
  end

  it "test_mpk_distances" do
    @driver.get(@base_url + "index.html")
    @driver.find_element(:id, "calc_units_km").click    
    @driver.find_element(:id, "calc_dist_mm").clear
    @driver.find_element(:id, "calc_dist_mm").send_keys("6")
    @driver.find_element(:id, "calc_dist_ss").clear
    @driver.find_element(:id, "calc_dist_ss").send_keys("0")
    @driver.find_element(:id, "calc_dist_calc_time").click    
    verify { (@driver.find_element(:id, "calc_dist_results_5K").text).should == "30:00.00" }        
  end  

  it "test_mph_distances" do
    @driver.get(@base_url + "index.html")
    @driver.find_element(:id, "calc_units_miles").click    
    @driver.find_element(:id, "calc_dist_uph").clear
    @driver.find_element(:id, "calc_dist_uph").send_keys("6")
    @driver.find_element(:id, "calc_dist_calc_uph").click    
    verify { (@driver.find_element(:id, "calc_dist_results_10_mile").text).should == "1:40:00.00" }        
  end

  it "test_kph_distances" do
    @driver.get(@base_url + "index.html")
    @driver.find_element(:id, "calc_units_km").click  
    @driver.find_element(:id, "calc_dist_uph").clear
    @driver.find_element(:id, "calc_dist_uph").send_keys("10")
    @driver.find_element(:id, "calc_dist_calc_uph").click
    verify { (@driver.find_element(:id, "calc_dist_results_5K").text).should == "30:00.00" }        
  end  

  it "test_mpm_distances_w_calc_dist_dist" do
    @driver.get(@base_url + "index.html")
    @driver.find_element(:id, "calc_units_miles").click    
    @driver.find_element(:id, "calc_dist_mm").clear
    @driver.find_element(:id, "calc_dist_mm").send_keys("6")
    @driver.find_element(:id, "calc_dist_ss").clear
    @driver.find_element(:id, "calc_dist_ss").send_keys("0")
    @driver.find_element(:id, "calc_dist_dist").clear
    @driver.find_element(:id, "calc_dist_dist").send_keys("135")    
    @driver.find_element(:id, "calc_dist_calc_time").click    
    verify { (@driver.find_element(:id, "calc_dist_results_10_mile").text).should == "1:00:00.00" }   
    verify { (@driver.find_element(:id, "calc_custom_dist").text).should == "13:30:00.00" }         
  end

  it "test_mpk_distances_w_calc_dist_dist" do
    @driver.get(@base_url + "index.html")
    @driver.find_element(:id, "calc_units_km").click    
    @driver.find_element(:id, "calc_dist_mm").clear
    @driver.find_element(:id, "calc_dist_mm").send_keys("6")
    @driver.find_element(:id, "calc_dist_ss").clear
    @driver.find_element(:id, "calc_dist_ss").send_keys("0")
    @driver.find_element(:id, "calc_dist_dist").clear
    @driver.find_element(:id, "calc_dist_dist").send_keys("6")    
    @driver.find_element(:id, "calc_dist_calc_time").click    
    verify { (@driver.find_element(:id, "calc_dist_results_10K").text).should == "1:00:00.00" }   
    verify { (@driver.find_element(:id, "calc_custom_dist").text).should == "36:00.00" }         
  end  

  it "test_mph_distances_w_calc_dist_dist" do
    @driver.get(@base_url + "index.html")
    @driver.find_element(:id, "calc_units_miles").click    
    @driver.find_element(:id, "calc_dist_uph").clear
    @driver.find_element(:id, "calc_dist_uph").send_keys("6")
    @driver.find_element(:id, "calc_dist_dist").clear
    @driver.find_element(:id, "calc_dist_dist").send_keys("135")
    @driver.find_element(:id, "calc_dist_calc_uph").click
    verify { (@driver.find_element(:id, "calc_dist_results_10_mile").text).should == "1:40:00.00" }
    verify { (@driver.find_element(:id, "calc_custom_dist").text).should == "22:30:00.00" }    
  end

  it "test_mpk_distances_w_calc_dist_dist" do
    @driver.get(@base_url + "index.html")
    @driver.find_element(:id, "calc_units_km").click    
    @driver.find_element(:id, "calc_dist_uph").clear
    @driver.find_element(:id, "calc_dist_uph").send_keys("6")
    @driver.find_element(:id, "calc_dist_dist").clear
    @driver.find_element(:id, "calc_dist_dist").send_keys("200")
    @driver.find_element(:id, "calc_dist_calc_uph").click
    verify { (@driver.find_element(:id, "calc_dist_results_10k").text).should == "1:40:00.00" }
    verify { (@driver.find_element(:id, "calc_custom_dist").text).should == "33:20:00.00" }    
  end

  it "test_d_and_t_to_mpu" do
    @driver.get(@base_url + "index.html")
    @driver.find_element(:id, "calc_units_miles").click
    @driver.find_element(:id, "calc_mpm_dist").clear
    @driver.find_element(:id, "calc_mpm_dist").send_keys("10")
    @driver.find_element(:id, "calc_mpm_hh").clear
    @driver.find_element(:id, "calc_mpm_hh").send_keys("1")
    @driver.find_element(:id, "calc_mpm_mm").clear
    @driver.find_element(:id, "calc_mpm_mm").send_keys("0")
    @driver.find_element(:id, "calc_mpm_ss").clear
    @driver.find_element(:id, "calc_mpm_ss").send_keys("0")
    @driver.find_element(:id, "calc_mpm_calc").click
    verify { (@driver.find_element(:id, "calc_mpm_result").text).should == "06:00.00" }
  end

  it "test_d_and_t_to_mpu" do
    @driver.get(@base_url + "index.html")
    @driver.find_element(:id, "calc_units_miles").click
    @driver.find_element(:id, "calc_mpm_dist").clear
    @driver.find_element(:id, "calc_mpm_dist").send_keys("10")
    @driver.find_element(:id, "calc_mpm_hh").clear
    @driver.find_element(:id, "calc_mpm_hh").send_keys("1")
    @driver.find_element(:id, "calc_mpm_mm").clear
    @driver.find_element(:id, "calc_mpm_mm").send_keys("0")
    @driver.find_element(:id, "calc_mpm_ss").clear
    @driver.find_element(:id, "calc_mpm_ss").send_keys("0")
    @driver.find_element(:id, "calc_mpm_calc").click
    verify { (@driver.find_element(:id, "calc_mpm_result").text).should == "06:00.00" }    
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
end
