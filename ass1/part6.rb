#! /usr/bin/env ruby

#require 'debug'

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
