class Language < ApplicationRecord
  require 'capybara'
  require 'selenium/webdriver'
  require 'webdrivers/chromedriver'
  require 'nokogiri'

  RULE_TYPES = ['Vulnerability', 'Code Smell', 'Security Hotspot', 'Bug'].freeze
  SEVERITIES = ['Blocker', 'Critical', 'Major', 'Minor'].freeze
  belongs_to :repository, optional: true

  has_many :rules, dependent: :destroy

  def self.get_all_languages
    Capybara.register_driver :chrome_headless do |app|
      options = ::Selenium::WebDriver::Chrome::Options.new

      options.add_argument('--headless')
      options.add_argument('--no-sandbox')
      options.add_argument('--disable-dev-shm-usage')
      options.add_argument('--window-size=1400,1400')

      Capybara::Selenium::Driver.new(app, browser: :chrome, :driver_path => '/usr/bin/chromedriver', options: options)
    end

    Capybara.javascript_driver = :chrome_headless
    Capybara.default_driver = :chrome_headless

    session = Capybara::Session.new(:chrome_headless)
    session.visit('https://rules.sonarsource.com')

    # Get all available languages
    languages = []
    session.all(:css, 'div > div > nav > ul > li > a').each do |l|
      languages << {:name => l.text, :url => l[:href]}
    end
    session.quit
    return languages
  end

end
