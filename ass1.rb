#! /usr/bin/env ruby

#require 'debug'

# Part 1: fun with strings ###################################################
def palindrome?( string )
    word = string.downcase.gsub(/[^a-z]/, '')
    if word == word.reverse
        return true;
    else
        return false;
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

    def name ;@name ; end

    def calories ;@calories ; end

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
    
    def name ;@name ; end

    def calories ;@calories ; end

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
