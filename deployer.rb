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
    exit
  end
  parser.on("-n", "--name NAME", "The name of the APT to install.") do |v|
    options[:name] = v
  end
  parser.on("-p", "--path PATH", "The path to your $CALDERA/data directory.") do |v|
    options[:path] = v
  end
end.parse!

def plugindeployer(path)
  pwd = Dir.pwd
  FileUtils.mkdir_p("#{path}/plugins/emulation-plans/")
  FileUtils.cp("#{pwd}/emulation-plans/hook.py", "#{path}/plugins/emulation-plans/")
end

def abilitymover(plan, path)
  pwd = Dir.pwd
  puts pwd
  ability = ["credential-access", "discovery", "execution", "persistence", "exfiltration", "reconnaissance", "resource-development", "initial-access", "privilege-escalation", "defense-evasion", "lateral-movement", "collection", "command-and-control", "exfiltration", "impact"]
  for ability in ability
    puts ability
    Dir.glob("#{pwd}/plans/#{plan}/abilities/#{ability}/*.yml").each do|f|
      puts f
      FileUtils.mkdir_p("#{path}/plugins/emulation-plans/data/abilities/#{ability}")
      FileUtils.cp(f, "#{path}/plugins/emulation-plans/data/abilities/#{ability}/")
    end
  end
end

def adversarymover(plan, path)
  pwd = Dir.pwd
  puts pwd
    Dir.glob("#{pwd}/plans/#{plan}/adversaries/*.yml").each do|f|
    puts f
    FileUtils.mkdir_p("#{path}/plugins/emulation-plans/data/adversaries/")
    FileUtils.cp(f, "#{path}/plugins/emulation-plans/data/adversaries/")
  end
end

def payloadmover(plan, path)
  pwd = Dir.pwd
  puts pwd
  Dir.glob("#{pwd}/plans/#{plan}/payloads/*").each do|f|
    puts f
    FileUtils.mkdir_p("#{path}/plugins/emulation-plans/payloads/")
    FileUtils.cp(f, "#{path}/plugins/emulation-plans/payloads/")
  end
end

def sourcesmover(plan, path)
  pwd = Dir.pwd
  puts pwd
  Dir.glob("#{pwd}/plans/#{plan}/sources/*").each do|f|
    puts f
    puts FileUtils.mkdir_p("#{path}/plugins/emulation-plans/data/sources/")
    puts FileUtils.cp(f, "#{path}/plugins/emulation-plans/data/sources/")
  end
end

def planner(options)
  plan = options[:name]
  path = options[:path]
  plugindeployer(path)
  abilitymover(plan, path)
  adversarymover(plan, path)
  payloadmover(plan, path)
  sourcesmover(plan, path)
end

puts options
planner(options)



