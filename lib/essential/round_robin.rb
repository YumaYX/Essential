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

    # Generates combinations of arguments and writes the corresponding contents to files.
    #
    # @param args1 [Array] The first set of arguments.
    # @param args2 [Array] Additional sets of arguments passed as a splat parameter.
    # @yield [combination] Block to be executed for each combination.
    # @yieldparam combination [Array] The current combination of arguments.
    # @yieldreturn [String, nil] The contents to be written to the file, or nil to skip.
    #
    # @return [self] Returns self.
    def generate_combinations(args1, *args2)
      args1.product(*args2).each do |combination|
        file_name = combination.join('_')
        full_path = File.join(@output_directory, file_name)

        contents = yield(combination)
        next if contents.nil?

        File.write(full_path, contents.to_s)
      end
      self
    end
  end
end
