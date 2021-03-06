#!/usr/bin/ruby
require 'fileutils'
require 'optparse'

options = {}


OptionParser.new do |parser|
  parser.banner = "Usage: createplan.rb [options]"
  parser.on("-h", "--help", "Show this help message") do ||
    puts parser
    exit
  end
  parser.on("-n", "--name NAME", "The name of the APT to create a skeleton for.") do |v|
    options[:name] = v
  end
end.parse!

def createmodule(plan)
  pwd = Dir.pwd
  ability = ["credential-access", "discovery", "execution", "persistence", "exfiltration", "reconnaissance", "resource-development", "initial-access", "privilege-escalation", "defense-evasion", "lateral-movement", "collection", "command-and-control", "exfiltration", "impact"]
  for ability in ability
    FileUtils.mkdir_p("#{pwd}/plans/#{plan}/abilities/#{ability}")
    FileUtils.mkdir_p("#{pwd}/plans/#{plan}/adversaries")
    FileUtils.mkdir_p("#{pwd}/plans/#{plan}/payloads")
    FileUtils.mkdir_p("#{pwd}/plans/#{plan}/sources")
    FileUtils.touch("#{pwd}/plans/#{plan}/sources/#{plan}.yml")
    FileUtils.touch("#{pwd}/plans/#{plan}/README.md")

  end
end

def runner(options)
  plan = options[:name]
  puts "Plan Name: '#{plan}', don't forget to update your README file before sharing."
  createmodule(plan)
end

runner(options)
