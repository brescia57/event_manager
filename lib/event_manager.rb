#look for a solution before building a solution!
require "csv"
puts "EventManager Initialized!"
#using Ruby's CSV Library
contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol
contents.each do |row|
	name = row[:first_name]
	zipcode = row[:zipcode]
	#checking for nil? takes care of the empty space in the data file
	if zipcode.nil?
		zipcode = "00000"
	elsif zipcode.length < 5
		zipcode = zipcode.rjust 5, "0"
	elsif zipcode.length > 5
		zipcode = zipcode[0..4]
	end
			
	puts "#{name} #{zipcode}"
end


#lines = File.readlines "event_attendees.csv"
#lines.each_with_index do |line,index|
#	next if index == 0
#	columns = line.split(",")
	#accessing the first name column.
#	name = clomuns[2]