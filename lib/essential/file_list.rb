# frozen_string_literal: true

# Inspired by https://github.com/ruby/rake/blob/master/lib/rake/file_list.rb

# Essential
module Essential
  # Represents a list of files.
  class FileList
    # Initializes a new FileList with the given targets.
    # @param targets [Array] One or more files to be resolved.
    def initialize(*targets)
      @targets  = []
      @filelist = []
      targets.each { |element| add(element) }

      @targets_exclude  = []
      @filelist_exclude = []
    end

    # Add one or more files to the list of common targets.
    # @param target_common [Array] Targets variable (reference).
    # @param glob_path [String/Array] One or more files to be resolved.
    # @return [Essential::FileList] self
    def add_common(target_common, *glob_path)
      glob_path.each do |element|
        if element.respond_to?(:to_ary)
          add_common(target_common, *element.to_ary)
        else
          target_common << element
        end
      end
      self
    end
    private :add_common

    # Add one or more files to the list of targets.
    # @param glob_path [Array] One or more files to be added.
    # @return [Essential::FileList] self
    def add(*glob_path)
      add_common(@targets, glob_path)
    end

    # Resolves glob patterns and updates the filelist.
    # @return [Essential::FileList] self
    def resolve
      @filelist = self.class.resolve_glob(@targets)
      resolve_exclude
      @filelist -= @filelist_exclude
      self
    end
    private :resolve

    # Returns the filelist as an array of files.
    # @return [Array] List of resolved files.
    def to_a
      resolve
      @filelist
    end

    # Add one or more files to the list of excluded targets.
    # @param glob_path [Array] One or more files to be excluded.
    # @return [Essential::FileList] self
    def add_exclude(*glob_path)
      add_common(@targets_exclude, glob_path)
    end

    # Resolves the excluded filelist and updates it.
    # @return [Array] List of resolved files in the exclude filelist.
    # @return [Essential::FileList] self
    def resolve_exclude
      @filelist_exclude = self.class.resolve_glob(@targets_exclude)
      self
    end
    private :resolve_exclude

    # Clears all the exclude filelist.
    # @return [Essential::FileList] self
    def clear_exclude
      @targets_exclude  = []
      @filelist_exclude = []
      self
    end

    class << self
      # Create a new FileList with the given arguments.
      # @param args [Array] Arguments for initializing the FileList.
      # @return [Essential::FileList] New FileList instance.
      def [](*args)
        new(*args)
      end

      # Resolves glob file names for an array of glob paths (strings).
      # @param glob [Array] List of glob path strings.
      # @return [Array] List of resolved file names.
      def resolve_glob(glob)
        concreate = glob.map do |file_dir|
          # skip directory
          Dir.glob(file_dir).reject { |ele| File.directory?(ele) }
        end
        concreate.flatten!
        concreate.uniq!
        concreate.sort!
      end
    end
  end
end
