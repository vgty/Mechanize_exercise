
require 'mechanize'
require 'csv'
#Search terms
search_terms = ["Steve jobs ", "Dale Carnegie", "Henry Ford", "Benjamin Franklin", "Thomas Edison"]

#Setup Mechanize
agent = Mechanize.new { |agent|
  agent.user_agent_alias = 'Mac Safari'
}

#Seaching

search_terms.each do |term|
  
  page = agent.get("https://www.wikipedia.org")
  search_form = page.form(:action => '//www.wikipedia.org/search-redirect.php')
  search_form.search = term
  results = agent.submit(search_form, search_form.button('go'))
  html_results = Nokogiri::HTML(results.body)
  name = html_results.at_css("#firstHeading").text
  bday = html_results.at_css(".bday").text
  dday = html_results.at_css(".dday").text
    
  CSV.open('mes_donnees.csv', 'a+') do |csv|
    csv << [name, bday, dday]
  end
  
  puts name + " was born in " + bday + " and died the " + bday
  
  random_request = rand(61)
  sleep(random_request)
end



