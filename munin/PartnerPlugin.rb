require 'rest-client'
require 'json'

firstArg, *rest = ARGV

if firstArg == "config"
    puts "graph_title Operational status by partner\n";
    puts "graph_args -l 0\n";
    puts "graph_vlabel nb\n";
    puts "graph_scale no\n";
    puts "graph_category edwig\n";
end

server = ENV['EDWIG_SERVER']
referential = ENV['EDWIG_REFERENTIAL']
token = ENV['EDWIG_TOKEN']

unless server
	puts "Missing EDWIG_SERVER environment variable"
	exit 1
end

unless referential
	puts "Missing EDWIG_REFERENTIAL environment variable"
	exit 1
end

unless token
	puts "Missing EDWIG_TOKEN environment variable"
	exit 1
end

partners = RestClient.get("http://#{server}/#{referential}/partners", {content_type: :json, :Authorization => "Token token=#{token}"})
partnersTab = JSON.parse(partners)
counts = Hash.new {|hash, key| hash[key] = 0 }

partnersTab.each do |partner|

	operationalState = "OperationalStatus-#{partner['PartnerStatus']['OperationalStatus']}"
    counts[operationalState] += 1
end


counts.each {|key, value| puts "#{key}.value #{value}"}
