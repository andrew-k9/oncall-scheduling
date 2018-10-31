require_relative "CLI/input.rb"
require_relative "app/schedule.rb"

data = input

schedule data[0], data[1], data[2]
