#! /usr/bin/env ruby

#require 'debug'

# Part 1: fun with strings ###################################################
def palindrome?( string )
    word = string.downcase.gsub(/[^a-z]/, '')
    if word == word.reverse
        return true
    else
        return false
    end
end

#p palindrome?( "Madam, I'm Adam" )
#p palindrome?( "Abracadabra" )

def count_words( string )
    h = Hash.new
    arr = string.downcase.gsub(/[^a-z ]/, '').split.each { |word|
        if h.include?( word )
            h[word] = h[word].next
        else
            h[word] = 1
        end
    }
    return h
end

#p count_words("A man, a plan, a canal -- Panama")
#p count_words "Doo bee doo bee doo"

##############################################################################

# Part 2: Rock-Paper-Scissors ################################################
class WrongNumberOfPlayersError < StandardError ; end
class NoSuchStrategyError < StandardError ; end

def rps_game_winner(game)
    raise WrongNumberOfPlayersError unless game.length == 2
    strategy = [ "R", "P", "S" ]
    if not strategy.include? game[0][1].upcase or
       not strategy.include? game[1][1].upcase
        raise NoSuchStrategyError
    end

    if game[0][1].upcase == "R" and game[1][1].upcase == "S"
        return game[0]
    elsif game[0][1].upcase =="S" and game[1][1].upcase == "R"
        return game[1]
    end

    if game[0][1].upcase == "P" and game[1][1].upcase == "R"
        return game[0]
    elsif game[0][1].upcase =="R" and game[1][1].upcase == "P"
        return game[1]
    end

    if game[0][1].upcase == "S" and game[1][1].upcase == "P"
        return game[0]
    elsif game[0][1].upcase =="P" and game[1][1].upcase == "S"
        return game[1]
    end

    if game[0][1].upcase == game[1][1].upcase
        return game[0]
    end

end

#p rps_game_winner( [ [ "Dave", "P" ], [ "Armando", "P" ] ] )

def rps_tournament_winner(tournament)
    if not tournament[0][0].kind_of? Array and 
       not tournament[1][0].kind_of? Array
        return rps_game_winner(tournament)

    elsif not tournament[0][0].kind_of? Array and 
          tournament[1][0].kind_of? Array
        return rps_tournament_winner([tournament[0], 
                rps_tournament_winner( tournament[1] )])

    elsif tournament[0][0].kind_of? Array and 
          not tournament[1][0].kind_of? Array
        return rps_tournament_winner([rps_tournament_winner( tournament[0] ),
                tournament[1]])
    end
    return rps_tournament_winner( [rps_tournament_winner( tournament[0] ),
            rps_tournament_winner( tournament[1] )] )
end

#p rps_tournament_winner( [
#        [
#            [
#                [ ["Armando", "P"], ["Dave", "S"] ],
#                [ ["Richard", "P"], ["Michael", "S"] ]
#            ],
#            [
#                [ ["Andres", "R"], ["Seba", "R"] ],
#                [ ["Tamara", "R"], ["Salome", "R"] ]
#            ]
#        ],
#        [
#            [ ["Allen", "S"], ["Omer", "P"] ],
#            [ ["David E.", "R"], ["Richard X.", "P"] ] 
#        ] 
#        ] )

##############################################################################

# Part 3: anagrams ###########################################################

def combine_anagrams(words)
    anagrams = []
    partial_array = Array.new
    words.each { |word|
        partial_array.push(word)
        i = words.index(word)+1
        loop do
            break if i >= words.length
            if word.upcase.split(//).sort == words[i].upcase.split(//).sort
                partial_array.push(words[i])
                words.delete(words[i])
            end
            i += 1
        end
        anagrams.push(partial_array)
        partial_array = []
    }
    return anagrams
end

#p combine_anagrams(["for", "rof", "apple"])
#p combine_anagrams(['cars', 'for', 'potatoes', 'racs', 'four','scar',
#'creams', 'scream'])

##############################################################################

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

# Part 5: Advanced OOP, metaprogramming, open classes and duck-typing ########

class Class
    def attr_accessor_with_history(attr_name)
        attr_name = attr_name.to_s # make sure it's a string
        attr_reader attr_name # create the attribute's getter
        attr_reader attr_name+"_history" # create bar_history getter

        # Setter method for attr_name defined at runtime.
        # When <class_name>.new is called nil is inserted at the array.
        # Whenever attr_name is set again, the value is pushed into the array.
        class_eval %Q{
            def #{attr_name}=( new_value )
                @#{attr_name}_history ||= [nil]
                @#{attr_name}_history << @#{attr_name} = new_value
            end
        }
    end
end

class Foo
    attr_accessor_with_history :bar
end

#f = Foo.new
#f.bar = 1
#f.bar = 2
#p f.bar_history # => if your code works, should be [nil,1,2]
#f = Foo.new
#p f.bar_history # => nil


# metaprogramming to the rescue!

class Numeric
    @@currencies = {'yen' => 0.013, 'euro' => 1.292, 'rupee' => 0.019, 'dollar' => 1}
    def method_missing(method_id, *args, &block)  # capture all args in case have to call super
        singular_currency = method_id.to_s.gsub( /s$/, '')
        if @@currencies.has_key?(singular_currency)
            self * @@currencies[singular_currency]
        else
            super
        end
    end
    def in(currency)
        singular_currency = currency.to_s.gsub( /s$/, '')
        self / @@currencies[singular_currency]
    end
end

#p 1.rupee
#p 1.euro.in(:rupees)

class String
    def palindrome?
        word = self.downcase.gsub(/[^a-z]/, '')
        if word == word.reverse
            return true
        else ; return false ; end
    end
end

#p "abracadabra".palindrome?
#p "madam i'm adam".palindrome?

module Enumerable
    def palindrome?
        word = self.flat_map { |i| i.to_s.downcase }
        if word == word.reverse
            return true
        else ; return false ; end
    end    
end

##############################################################################

# Part 6: iterators, blocks, yield ###########################################

class CartesianProduct
    include Enumerable

    def initialize(coll_1, coll_2)
        @coll_1, @coll_2 = coll_1, coll_2
    end

    def each
        @coll_1.each do |i|
            @coll_2.each { |j| yield [i,j] }
        end
    end
    # your code here
end

#c = CartesianProduct.new([:a,:b, :c], [4,5])
#c.each { |elt| puts elt.inspect }
# [:a, 4]
# [:a, 5]
# [:b, 4]
# [:b, 5]

#c = CartesianProduct.new([:a,:b], [])
#c.each { |elt| puts elt.inspect }
# (nothing printed since Cartesian product
# of anything with an empty collection is empty)

##############################################################################
