class Rule < ApplicationRecord
  require 'capybara'
  require 'selenium/webdriver'
  require 'webdrivers/chromedriver'
  require 'nokogiri'

  RULE_TYPES = ['Vulnerability', 'Code Smell', 'Security Hotspot', 'Bug'].freeze
  SEVERITIES = ['Blocker', 'Critical', 'Major', 'Minor', 'Info'].freeze
  #MAIN_SECTION_CSS_PATH = 'div > div > div > main > div > section'.freeze
  #MAIN_SECTION_CSS_PATH = 'div > div > div > main > div'.freeze
  MAIN_SECTION_CSS_PATH = 'div > div > div > nav > main > div'.freeze
  BODY_CSS_PATH = 'section'.freeze
  TITLE_CSS_PATH = 'section > h1'.freeze
  SEVERITY_AND_TYPE_CSS_PATH = 'div > text()'.freeze
  TAGS_CSS_PATH = 'nav > ul > li > a[href^="/"]'.freeze
  REFERENCE_LINKS_CSS_PATH= 'section > ul > li > a'.freeze

  belongs_to :language

  has_many :rule_tags, dependent: :destroy
  has_many :tags, through: :rule_tags
  #has_many :greps, foreign_key: 'source_rule_id', dependent: :destroy
  has_many :searchterms, dependent: :destroy

  validates :title, uniqueness: {scope: :language_id}

  def self.make_session
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
  end

  def self.get_rules_urls(language_url)
    session = make_session

    # Get all the rule URLs for the language
    session.visit(language_url)
    rules_urls = []
    session.all(:css, 'div > div > div > nav > ol > li > a').each do |u|
      rules_urls << u[:href]
    end
    session.quit
    return rules_urls
  end

  def self.build_rule_object(rule_link)
    session = make_session
    session.visit(rule_link)

    rule_object = {}

    main_content_section = Nokogiri::HTML(session.body).css(MAIN_SECTION_CSS_PATH)
    
    rule_object[:title] = main_content_section.css(TITLE_CSS_PATH).first.text
    rule_object[:body] = main_content_section.css(BODY_CSS_PATH).last.children.to_html

    main_content_section.css(SEVERITY_AND_TYPE_CSS_PATH).each do |info|
      rule_object[:type] = info.text.strip if RULE_TYPES.include? info.text.strip
      rule_object[:severity] = info.text.gsub("\u00A0", " ").strip if SEVERITIES.include? info.text.gsub("\u00A0", " ").strip
    end

    rule_object[:tags] = []
    main_content_section.css(TAGS_CSS_PATH).each do |tag|
      rule_object[:tags] << tag.text
    end

    rule_object[:references] = []
    main_content_section.css(REFERENCE_LINKS_CSS_PATH).each do |ref|
      rule_object[:references] << ref[:href]
    end
    session.quit
    puts "Rule.rb:    Rule to be built: #{rule_object}"
    return rule_object
  end

  def all_tags=(names)
    self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(", ")
  end
end
