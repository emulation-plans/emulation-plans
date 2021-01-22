#!/usr/bin/ruby
require 'fileutils'
require 'optparse'



printf "  o___o\n"
printf "  (^o^)\n"
printf " o/( )\\o\n"
printf " O_.^._O\n"
printf "\n"
printf "\n"
printf "\n"

options = {}

OptionParser.new do |parser|
  parser.banner = "Usage: deployer.rb [options]"
  parser.on("-h", "--help", "Show this help message") do ||
    puts parser
  end
  parser.on("-n", "--name NAME", "The name of the APT to install.") do |v|
    options[:name] = v
  end
  parser.on("-p", "--path PATH", "The path to your $CALDERA/data directory.") do |v|
    options[:path] = v
  end
end.parse!


def abilitymover(plan, path)
  pwd = Dir.pwd
  puts pwd
  ability = ["credential-access", "discovery", "execution", "persistence", "exfiltration", "reconnaissance", "resource-development", "initial-access", "privilege-escalation", "defense-evasion", "lateral-movement", "collection", "command-and-control", "exfiltration", "impact"]
  for ability in ability
    puts ability
    Dir.glob("#{pwd}/#{plan}/*/#{ability}/*.yml").each do|f|
      puts f
      FileUtils.mkdir_p("#{path}/plugins/stockpile/data/abilities/#{ability}")
      FileUtils.cp(f, "#{path}/plugins/stockpile/data/abilities/#{ability}/")
    end
  end
end

def adversarymover(plan, path)
  pwd = Dir.pwd
  puts pwd
    Dir.glob("#{pwd}/#{plan}/adversaries/*.yml").each do|f|
    puts f
    FileUtils.mkdir_p("#{path}/plugins/stockpile/data/adversaries/")
    FileUtils.cp(f, "#{path}/plugins/stockpile/data/adversaries/")
  end
end

def payloadmover(plan, path)
  pwd = Dir.pwd
  puts pwd
  Dir.glob("#{pwd}/#{plan}/payloads/*").each do|f|
    puts f
    FileUtils.mkdir_p("#{path}/plugins/stockpile/payloads/")
    FileUtils.cp(f, "#{path}/plugins/stockpile/payloads/")
  end
end

def planner(options)
  plan = options[:name]
  path = options[:path]
  abilitymover(plan, path)
  adversarymover(plan, path)
  payloadmover(plan, path)
end

puts options
planner(options)


