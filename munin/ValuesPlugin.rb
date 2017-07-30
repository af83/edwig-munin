 require 'rest-client'
require 'json'

firstArg, *rest = ARGV

if firstArg == "config"
    puts "graph_title Objects counts\n";
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

#stop_visits.value
stopVisits = RestClient.get("http://#{server}/#{referential}/stop_visits" , {content_type: :json, :Authorization => "Token token=#{token}"})
stopVisitsTab = JSON.parse(stopVisits)
puts "stop_visits.value #{stopVisitsTab.count}"

#vehicle_journeys.value
vehicleJourneys = RestClient.get("http://#{server}/#{referential}/vehicle_journeys" , {content_type: :json, :Authorization => "Token token=#{token}"})
vehicleJourneysTab = JSON.parse(vehicleJourneys)
puts "vehicle_journeys.value #{vehicleJourneysTab.count}"

#stop_areas.value
stopAreas = RestClient.get("http://#{server}/#{referential}/stop_areas" , {content_type: :json, :Authorization => "Token token=#{token}"})
stopAreasTab = JSON.parse(stopAreas)
puts "stop_areas.value #{stopAreasTab.count}"

#lines.value
lines = RestClient.get("http://#{server}/#{referential}/lines" , {content_type: :json, :Authorization => "Token token=#{token}"})
linesTab = JSON.parse(lines)
puts "lines.value #{linesTab.count}"
