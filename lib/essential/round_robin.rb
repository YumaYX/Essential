# frozen_string_literal: true

# Essential module
module Essential
  # RoundRobin class
  class RoundRobin
    # Initializes a new RoundRobin instance.
    # @param output_directory [String] The directory where output files will be saved.
    #   Defaults to 'output' if not provided.
    def initialize(output_directory = 'output')
      @output_directory = output_directory
      Dir.mkdir(@output_directory, 0o755) unless File.directory?(@output_directory)
    end

    # Generates combinations from the provided arguments and executes a block for each combination.
    # Each combination result is saved to a file in the specified output directory.
    #
    # @param args1 [Array] The first set of arguments for combination.
    # @param args2 [Array] Additional sets of arguments for combination.
    # @yield [combination] Block to be executed for each combination.
    # @yieldparam combination [Array] The current combination of arguments.
    # @return [Array] The combinations of arguments.
    def generate_combinations(args1, *args2)
      args1.product(*args2).each do |combination|
        file_name = combination.join('_')
        full_path = File.join(@output_directory, file_name)

        contents = yield(combination)

        File.write(full_path, contents)
      end
    end
  end
end
