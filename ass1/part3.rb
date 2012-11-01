#! /usr/bin/env ruby

#require 'debug'

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
