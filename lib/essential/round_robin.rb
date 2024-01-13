# frozen_string_literal: true

# Essential module
module Essential
  # RoundRobin class
  class RoundRobin
    # Initializes a new RoundRobin instance.
    #
    # @param output_directory [String] The directory where output files will be saved.
    def initialize(output_directory = 'output')
      @output_directory = output_directory
    end

    # Creates the output directory if it does not exist.
    def make_output_dir
      Dir.mkdir(@output_directory, 0o755) unless File.directory?(@output_directory)
      self
    end

    # Generates combinations from the provided arguments and executes a block for each combination.
    # Each combination result is saved to a file in the specified output directory.
    #
    # @param args1 [Array] The first set of arguments for combination.
    # @param args2 [Array] Additional sets of arguments for combination.
    # @yield [combination] Block to be executed for each combination.
    # @yieldparam combination [Array] The current combination of arguments.
    # @return [Array] The combination of arguments.
    def generate_combinations(args1, *args2)
      make_output_dir
      args1.product(*args2).each do |combination|
        contents = yield(combination)
        file_name = File.join(@output_directory, combination.join('_'))
        File.write(file_name, contents)
      end
    end
  end
end
