require 'rubygems'
require 'nokogiri'
require 'open-uri'

# Définition d'une méthode scrapper pour pouvoir reutiliser les info facilement dans l'exo.
def scrapper(url, path)
  page = Nokogiri::HTML(open(url))
  page.css(path)
end

# Méthode de récupération d'infos sur les différentes crypto, stockées dans un hash.
def scrap_crypto
  url = $base_url + "all/views/all/"
  detail = Hash.new
  coins = scrapper(url, ".table-responsive table > tbody > tr" )
  coins.each do |coin|
    symb = coin.children[5].text
    detail[symb] = {
      price: coin.children[9].text,
      volume: coin.children[13].text,
      evol_24h: coin.children[17].text,
    }
    puts "#{symb} : PRICE :'#{detail[symb][:price]}' VOL : '#{detail[symb][:volume]}' 24H_EVOL : '#{detail[symb][:evol_24h]}'"
  end
end

#Variable globale, appelée en dehors de la méthode
$base_url = "https://coinmarketcap.com/"

#Appel de la méthode 
scrap_crypto
