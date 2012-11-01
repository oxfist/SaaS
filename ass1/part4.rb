#! /usr/bin/env ruby

#require 'debug'

# Part 4: Basic OOP ##########################################################

class Dessert
    def initialize( name, calories )
        @name, @calories = name, calories
    end

    def name ; @name ; end

    def calories ; @calories ; end

    def name=( name )
        @name = name
    end

    def calories=( calories )
        @calories = calories
    end

    def healthy?
        if @calories < 200
            return true
        else
            return false
        end
    end

    def delicious? ; return true ; end
end

class JellyBean < Dessert
    def initialize(name, calories, flavor)
        @name, @calories, @flavor = name, calories, flavor
    end
    
    def name ; @name ; end

    def calories ; @calories ; end

    def flavor ; @flavor ; end

    def name=( name )
        @name = name
    end

    def calories=( calories )
        @calories = calories
    end

    def flavor=( flavor )
        @flavor = flavor
    end
     
    def delicious?
        if @flavor == "black licorice"
            return false
        else
            return true
        end
    end

end

##############################################################################
