require "sinatra"
require "sinatra/reloader"
require "httparty"
def view(template); erb template.to_sym; end

get "/" do
  ### Get the weather
  # Evanston, Kellogg Global Hub... replace with a different location if you want
  lat = 42.0574063
  long = -87.6722787

  units = "imperial" # or metric, whatever you like
  weatherkey = "3157872a219ba6bff490ae435df2b966"

  # construct the URL to get the API data (https://openweathermap.org/api/one-call-api)
  weatherurl = "https://api.openweathermap.org/data/2.5/onecall?lat=#{lat}&lon=#{long}&units=#{units}&appid=#{weatherkey}"

  # make the call
  @forecast = HTTParty.get(weatherurl).parsed_response.to_hash

  ### Get the news
  newskey = "01678b3122284c899ae4f78ae9c871af"

  newsurl = "https://newsapi.org/v2/top-headlines?country=us&apiKey=#{newskey}"
  @news = HTTParty.get(newsurl).parsed_response.to_hash

  view 'news'
  
end
