#! /usr/bin/env ruby

#require 'debug'

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
