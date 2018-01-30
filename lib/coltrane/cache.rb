# frozen_string_literal: true

module Coltrane
  # A simple caching based on serializing objects into files
  # maybe this should changed to save in a single json file
  class Cache
    class << self
      def find_or_record(key, &block)
        if @disabled || !(cached = fetch(key))
          cached = yield block
          record(key, cached)
        end
        cached
      end

      def disable
        @disabled = true
      end

      def enable
        @disabled = false
      end

      private

      def dir
        dir = File.expand_path('../../../', __FILE__) + '/cache/'
        Dir.mkdir(dir) unless Dir.exist?(dir)
        dir
      end

      def fetch(key)
        Marshal.load File.read(dir + key) if File.file?(dir + key)
      end

      def record(key, contents)
        File.open(dir + key, 'w') do |f|
          f.write Marshal.dump(contents)
        end
      end
    end
  end
end
