module Coltrane
  class Cache
    class << self
      def find_or_record(key, &block)
        if (cached = fetch(key))
          return cached
        else
          cached = yield block
          record(key, cached)
          cached
        end
      end

      private

      def dir
        dir = File.expand_path('../../../', __FILE__) + "/cache/"
        Dir.mkdir(dir) unless Dir.exist?(dir)
        dir
      end

      def fetch(key)
        return unless File.file?(dir+key)
        Marshal.load File.read(dir+key)
      end

      def record(key, contents)
        File.open(dir+key, "w") do |f|
          f.write Marshal.dump(contents)
        end
      end
    end
  end
end