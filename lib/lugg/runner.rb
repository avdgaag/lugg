require 'lugg/version'
require 'lugg/filter'
require 'lugg/streamer'
require 'optparse'
require 'optparse/time'

module Lugg
  class Runner
    attr_reader :filter
    private :filter

    def initialize(flags = [], filter = Filter.new)
      @filter = filter
      reset
      options.parse!(flags)
    end

    def run(io)
      filter.call(Streamer.new(io).records).each do |request|
        puts request.source
      end
    end

    private

    def reset
      @combine = false
      @last_block = nil
    end

    def combine_clauses?
      @combine && @last_block
    end

    def add_clause(&block)
      if combine_clauses?
        prev_block = @last_block
        filter.use { |r| prev_block.call(r) && block.call(r) }
        reset
      else
        filter.use(&block)
        @last_block = block
      end
    end

    def options
      @options ||= OptionParser.new do |o|
        o.banner = "Usage: lugg [options] FILE\n\nParses log entries from FILE or STDIN and uses [options] to\ncontrol what is sent STDOUT."
        o.separator ''

        o.on '--and', 'Combine previous and next clause with AND instead of OR' do
          @combine = true
        end

        %w[get post put delete head patch].each do |verb|
          o.on "--#{verb}", "Limit to #{verb.upcase} requests" do
            add_clause { |r| r.method == verb.upcase }
          end
        end

        o.on '-c',
             '--controller CONTROLLER',
             'Limit to requests handled by CONTROLLER' do |controller|
          add_clause { |r| r.controller == controller }
        end

        o.on '-a',
             '--action CONTROLLER_ACTION',
             'Limit to requests handled by CONTROLLER_ACTION' do |ca|
          add_clause { |r| r.action == ca }
        end

        %w[json html xml csv pdf js].each do |format|
          o.on "--#{format}", "Limit to #{format} requests" do
            add_clause { |r| r.format.downcase == format }
          end
        end

        o.on '-f', '--format FORMAT', 'Limit to FORMAT requests' do |format|
          add_clause { |r| r.format.downcase == format.downcase }
        end

        o.on '-s',
             '--status CODE',
             'Limit requests with status code CODE' do |code|
          add_clause { |r| r.code == code }
        end

        o.on '--since TIME',
             Time,
             'Limit to requests made after TIME' do |time|
          add_clause { |r| r.timestamp > time }
        end

        o.on '--until TIME',
             Time,
             'Limit to requests made before TIME' do |time|
          add_clause { |r| r.timestamp < time }
        end

        o.on '-d',
             '--duration N',
             Integer,
             'Limit to requests longer than N ms' do |n|
          add_clause { |r| r.duration > n }
        end

        o.on '-u',
             '--uri URI',
             Regexp,
             'Limit to requests matching URI' do |uri|
          add_clause { |r| r.uri =~ uri }
        end

        o.on '-p',
             '--param KEY=VAL',
             'Limit to requests with param KEY => VAL' do |param|
          key, value = param.split('=', 2)
          add_clause { |r| r.params[key] == value }
        end

        o.separator ''

        o.on_tail '-v', '--version', 'Display version number' do
          puts Lugg::VERSION
          exit
        end

        o.on_tail '-h', '--help', 'Display this message' do
          puts o
          exit
        end
      end
    end
  end
end
