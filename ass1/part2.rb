#! /usr/bin/env ruby

#require 'debug'

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
