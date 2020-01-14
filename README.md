Scraper README

A simple web scraper.
To run it you will need to open the file with text editor and
replace couple of parameters inside the code to make it work for the
page you wish to extract the data from.

You also will need to have the following gems installed:
require 'open-uri'
require 'nokogiri'
require 'byebug'
require 'csv'

To start begin with the replacing of the home_page value with the
link of the page you wish to scrap(don't forget to put ""). Then you
will need to find the main css block of the page and replace it
inside the main_block variable.
Use byebug to play around and find all the markers you will need for
every element in the page you wish to obtain data from. Save them as
objects in the_block.each loop. Construct the loop first and then you
can add the page navigators and total_listed objects values.

Follow the examples in the code to create your own template for the
web page.
When you are ready test with byebug after the each loop and once
again after the while loop.

Once you lunch the scrapper it will save all the values extracted in
csv table file "results.csv" then you can process the data with your
favourite table management software (for cyrlic alphabet I use google docs)
