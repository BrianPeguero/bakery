class Dessert
    def initialize(data)
        @title = data["title"]
        @img = data["image"]
        @ingredients = []
        @instruction = data["instructions"]

        data["extendedIngredients"].each do |ingredient|
            @ingredients.push(ingredient["original"])
        end
    end

    def getTitle()
        return @title
    end

    def getImg()
        return @img
    end

    def getIngredients()
        return @ingredients
    end

    def getInstructions()
        return @instruction
    end

end