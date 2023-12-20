# frozen_string_literal: true

# Essential
module Essential; end

Dir.glob("#{__dir__}/essential/*.rb").sort.each { |lib_essential| require(lib_essential) }
