# frozen_string_literal: true

# Essential
module Essential; end

Dir.glob("#{__dir__}/*/*.rb").sort.each { |lib| require(lib) }
