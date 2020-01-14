#My first attempt for Scraper
require 'open-uri'
require 'nokogiri'
require 'byebug'
require 'csv'

def scrap

  jobs_collection = []
  start_page = 1
  puts "-=START SCRAPING=-"

  #insert the link of the page you wish to scrap
  home_page = "https://www.zaplata.bg/search/?q=&city=&city_distance=0&price=200%3B10000&cat%5B0%5D=1000&go="
  #processing the page and parsing it
  open_page = open(home_page)
  read_page = open_page.read
  parsed_page = Nokogiri::HTML.parse(read_page)

  #find the main class in the page
  main_block = parsed_page.css('div.listItems')

  #byebug
  #split the web site to parts
  #a good way is to use byebug here to find all the css markers you will use
  # current_page = 1
  per_page = main_block.css('li.c2').css('a').count
  # total_listed = doc.css('tr').css('td')[37].text.split(' ')[4].to_i
  # last_page = (total_listed.to_f / per_page.to_f).round

  #starts the scraping loop
  #Set the values for beggining and end
  while start_page <= 103 #last_page

    #insert the link again and replace the page value with #{start_page}

    all_url = "https://www.zaplata.bg/search/?q=&city=&city_distance=0&price=200%3B10000&cat%5B0%5D=1000&go=&page=#{start_page}"
    open_all= open(all_url)
    read_all = open_all.read
    parsed_all = Nokogiri::HTML.parse(read_all)

    puts "Current Page ", start_page

    #add the markers for the main page block here
    the_block = parsed_all.css('div.listItems').css('ul.listItem')

    #Starts the loop to extract the data from every element

    the_block.each do |job|
      jobs = {
        #Break the main loop to small css markers for every
        #Object you wish to collect data from
        Title: job.css('li.c2').css('a').text,
        Salary: job.css('li.c2').css('span.is_visibility_salary').text,
        Location: job.css('li.c2').css('span.location')[0].text.gsub(/\s+/, "").split(",")[1],
        Date: job.css('li.c2').css('span.location')[0].text.split(",")[0],
        Company: job.css('li.c4').css('a').text,
        Link: job.css('li.c2').css('a')[0].attributes['href'].value

      }
      jobs_collection << jobs

    end
    #Set a break point of the main loop
    #current_page += 1
    start_page += 1

    #check if everithing going smoooth before you lunch the whole loop
    #byebug
  end
  #byebug
  #After the data is extracted export it to csv file

  CSV.open('results.csv','wb',) do |csv|
    #csv.to_io.write "\uFEFF"
    keys = jobs_collection.map(&:keys).inject(&:|)
    csv << keys
    jobs_collection.each do |add|
      csv << add.values_at(*keys)
    end
  end
end

scrap
