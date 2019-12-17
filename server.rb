require "sinatra"
require "curb"
require "json"

require_relative "models/dessert"

@@BASE_URL = "https://api.spoonacular.com/recipes/"
@@GET_RECIPE_INFO = "https://api.spoonacular.com/recipes/"
@@EXTRACTING_RECIPE_URL = "https://api.spoonacular.com/recipes/extract?url="

get "/" do
    @tab = "Home"

    erb :index
end

get "/contact" do
    @tab = "Contact Us"

    erb :contact
end

get "/about" do
    @tab = "About Us"

    erb :about
end

get "/cakes" do
    @tab = "Cakes"

    begin
        req = Curl::Easy.perform("#{@@BASE_URL}search?query=cake&number=50&apiKey=#{ENV['SPOONACULAR_API_KEY']}")
        res = req.body_str
    rescue
        puts "error"
    end

    @data = JSON.parse(res)
    puts @data

    erb :dessert
end

get "/cupcakes" do
    @tab = "Cupcakes"

    begin
        req = Curl::Easy.perform("#{@@BASE_URL}search?query=cupcake&number=50&apiKey=#{ENV['SPOONACULAR_API_KEY']}")
        res = req.body_str
    rescue
        puts "error"
    end
    
    @data = JSON.parse(res)
    puts @data

    erb :dessert
end

get "/cookies" do
    @tab = "Cookies"

    begin
        req = Curl::Easy.perform("#{@@BASE_URL}search?query=cookie&number=50&apiKey=#{ENV['SPOONACULAR_API_KEY']}")
        res = req.body_str
    rescue
        puts "error"
    end
    
    @data = JSON.parse(res)
    puts @data

    erb :dessert
end

get "/muffins" do
    @tab = "Muffins"

    begin
        req = Curl::Easy.perform("#{@@BASE_URL}search?query=muffin&number=50&apiKey=#{ENV['SPOONACULAR_API_KEY']}")
        res = req.body_str
    rescue
        puts "error"
    end
    
    @data = JSON.parse(res)
    puts @data

    erb :dessert
end

get "/getRecipe" do
    @tab = params["dessert-name"]
    
    begin
        req1 = Curl::Easy.perform("#{@@GET_RECIPE_INFO}#{params["dessert-id"]}/information?includeNutrition=false&apiKey=#{ENV['SPOONACULAR_API_KEY']}")
        res1 = req1.body_str
        data = JSON.parse(res1)
        sourceUrl = data["sourceUrl"]


        req2 = Curl::Easy.perform("#{@@EXTRACTING_RECIPE_URL}#{sourceUrl}&apiKey=#{ENV['SPOONACULAR_API_KEY']}")
        res2 = req2.body_str

    rescue
        puts "error"
    end
    
    data2 = JSON.parse(res2)
    puts data

    @dessert = Dessert.new(data2)

    erb :getRecipe
end