module OS
  class << self
    def windows?
      (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
    end

    def mac?
     (/darwin/ =~ RUBY_PLATFORM) != nil
    end

    def unix?
      !windows?
    end

    def OS.linux?
      unix? && !mac?
    end
  end
end