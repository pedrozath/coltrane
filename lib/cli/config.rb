# frozen_string_literal: true

module Coltrane
  module Cli
    class Config
      DEFAULTS = {
        flavor: :notes,
        sound: false,
        on: :text
      }.freeze

      attr_accessor :flavor, :degrees, :sound
      attr_reader :on

      def initialize(defaults = DEFAULTS)
        defaults.each do |key, val|
          instance_variable_set(:"@#{key}", val)
        end
      end

      def on=(instrument)
        @on = case instrument
              when :ukelele then :ukulele
              when :bass then :bass_guitar
              else instrument
              end
      end
    end

    def self.config
      @config = Config.new if @config.nil?
      block_given? ? yield(@config) : @config
    end

    def self.erase_config
      @config = nil
    end
  end
end
