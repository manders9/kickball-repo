require 'sinatra'
require 'csv'

lackp_rosters = []


CSV.foreach('lackp_starting_rosters.csv', headers: true) do |row|
		lackp_rosters << row
end

teams = []
positions = []

lackp_rosters.each do |hash|
	teams << hash["team"]
	positions << hash["position"]
end

get '/mainpage' do
	@teams = teams.uniq
	@positions = positions.uniq
	erb :index
end

get '/team/:team_name' do
	@team = params[:team_name]
	@roster = lackp_rosters.select{|player| player['team'] == @team}
	erb :team
end

get '/position/:position' do
	@position = params[:position]
	@players = lackp_rosters.select{|player| player['position'] == @position}
	erb :position
end

set :views, File.dirname(__FILE__) + '/views'
set :public_folder, File.dirname(__FILE__) + '/public'


