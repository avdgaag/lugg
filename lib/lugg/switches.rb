require 'lugg/switch'

# Collection of available command line argument switches and their behaviour.
module Lugg
  Switch.define do
    flags '--and'
    desc 'Combine previous and next clause with AND instead of OR'
    action do
      obj.combine_next
    end
  end

  %w(get post put delete head patch).each do |verb|
    Switch.define do
      flags "--#{verb}"
      desc "Limit to #{verb.upcase} requests"
      action do
        obj.add_clause { |r| r.method == verb.upcase }
      end
    end
  end

  Switch.define do
    flags '-c', '--controller CONTROLLER'
    desc 'Limit to requests handled by CONTROLLER'
    action do |controller|
      obj.add_clause { |r| r.controller == controller }
    end
  end

  Switch.define do
    flags '-a', '--action CONTROLLER_ACTION'
    desc 'Limit to requests handled by CONTROLLER_ACTION'
    action do |ca|
      obj.add_clause { |r| r.action == ca }
    end
  end

  %w(json html xml csv pdf js).each do |format|
    Switch.define do
      flags "--#{format}"
      desc "Limit to #{format} requests"
      action do
        obj.add_clause { |r| r.format.downcase == format }
      end
    end
  end

  Switch.define do
    flags '-f', '--format FORMAT'
    desc 'Limit to FORMAT requests'
    action do |format|
      obj.add_clause { |r| r.format.downcase == format.downcase }
    end
  end

  Switch.define do
    flags '-s', '--status CODE'
    desc 'Limit requests with status code CODE'
    action do |code|
      obj.add_clause { |r| r.code == code }
    end
  end

  Switch.define do
    flags '--since TIME'
    cast Time
    desc 'Limit to requests made after TIME'
    action do |time|
      obj.add_clause { |r| r.timestamp > time }
    end
  end

  Switch.define do
    flags '--until TIME'
    cast Time
    desc 'Limit to requests made before TIME'
    action do |time|
      obj.add_clause { |r| r.timestamp < time }
    end
  end

  Switch.define do
    flags '-d', '--duration N'
    cast Integer
    desc 'Limit to requests longer than N ms'
    action do |n|
      obj.add_clause { |r| r.duration > n }
    end
  end

  Switch.define do
    flags '-u', '--uri URI'
    cast Regexp
    desc 'Limit to requests matching URI'
    action do |uri|
      obj.add_clause { |r| r.uri =~ uri }
    end
  end

  Switch.define do
    flags '-p', '--param PAIR'
    desc 'Limit to requests with param KEY => VAL'
    action do |param|
      key, value = param.split('=', 2)
      obj.add_clause { |r| r.params[key] == value }
    end
  end

  Switch.define :on_tail do
    flags '-v', '--version'
    desc 'Display version number'
    action do
      puts Lugg::VERSION
      exit
    end
  end

  Switch.define :on_tail do
    flags '-h', '--help'
    desc 'Display this message'
    action do
      puts options
      exit
    end
  end
end
