# require libraries/modules here
require 'nokogiri'
require 'pry'
#Nokogiri goes through an html tag and navigates it like a tree.
#It uses CSS collector to interact through it.
#The project at the end uses scraping and is about scraping.
#You get data by parsing html using Nokogiri
#Basically Nokogiri takes the data from a website and makes it easier to use
# a giant getter for websites to ruby
# think container wise about where you want your data from.
#review css and play around with the Nokogiri

 #parse - parser is a program, usually part of a compiler, that receives input in the form of sequential source program instructions, interactive online commands, markup tags, or some other defined interface and breaks them up into parts

  # projects: kickstarter.css("li.project.grid_4")
  # title: project.css("h2.bbcard_name strong a").text
  # image link: project.css("div.project-thumbnail a img").attribute("src").value
  # description: project.css("p.bbcard_blurb").text
  # location: project.css("ul.project-meta span.location-name").text
  # percent_funded: project.css("ul.project-stats li.first.funded strong").text

  #put kickstarter.css("li.project.grid_4").first in pry and tried it.
  #did project = _ to assign project to a variable.

  #The variable_name = _ syntax used in Pry will assign the variable name to the return value of whatever was executed above. For example:

  def create_project_hash

  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  projects = {}

  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    #gets second header
      binding.pry
    projects[title.to_sym] = {
      :image_link => project.css("div.social-icon-container").attribute("src").value,
      #:image_link=> "https://s3.amazonaws.com/ksr/projects/801922/photo-little.jpg?1391909090"
      :description => project.css("p.bbcard_blurb").text,
      # :description=>
      #"\nA beautifully crafted timepiece with a special design helps you to bring Balance back to your modern life. Inspired by r
      :location => project.css("ul.project-meta span.location-name").text,
      #:location=>"New York, NY",
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
      #:percent_funded=>133}
    }

    #whole block needs to be pry for it too work.
  end

  # return the projects hash
  projects
end
