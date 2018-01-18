require 'rubygems'
require 'nokogiri'
require 'open-uri'


# Définition d'une méthode scrapper pour pouvoir reutiliser les info facilement dans l'exo.
def scrapper(url, path)
  page = Nokogiri::HTML(open(url))
  page.css(path)
end

# Méthode qui récupère l'adresse mail d'une mairie en fonction de son url.
def get_the_email_of_a_townhal_from_its_webpage(url_2)
  url = $url_1 + url_2
  mails = scrapper(url, "td p font")
  mails.each do |mail|
	   if mail.text.include?('@')
	      puts mail.text
	   end
   end
end

# Méthode qui récupère toutes les url de villes du Val d'Oise
def get_all_the_urls_of_val_doise_townhalls
  url = $url_1 + "val-d-oise.html"
  towns = scrapper(url, "a.lientxt")
  towns.each do |town|
    url_2 = town["href"]
    puts $url_1 + town["href"] + url_2
    get_the_email_of_a_townhal_from_its_webpage(url_2)
  end
end

$url_1 = "http://annuaire-des-mairies.com/"

get_the_email_of_a_townhal_from_its_webpage("95/vaureal.html")
get_all_the_urls_of_val_doise_townhalls
