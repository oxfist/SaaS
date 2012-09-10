#! /usr/bin/env ruby

def palindrome?( string )
    word = string.downcase.gsub(/[^a-z]/, '')
    if word == word.reverse
        return true;
    else
        return false;
    end
end

puts palindrome?( "Madam, I'm Adam" )
puts palindrome?( "Abracadabra" )

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

puts count_words("A man, a plan, a canal -- Panama")
puts count_words "Doo bee doo bee doo"
