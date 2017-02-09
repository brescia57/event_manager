#look for a solution before building a solution!
require "csv"
require "sunlight/congress"
Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

#give zipcode its own method
def clean_zipcode(zipcode)
	#checking for nil? takes care of the empty space in the data file
	#if zipcode.nil?
		#zipcode = "00000"
	#elsif zipcode.length < 5
		#String#rjust
	#	zipcode = zipcode.rjust 5, "0"
	#elsif zipcode.length > 5
		#String#slice
	#	zipcode = zipcode[0..4]
	#end
	#more sucintly. Combines what we were doing above.
	zipcode.to_s.rjust(5,"0")[0..4]
end

def legislators_by_zipcode(zipcode)
	legislators = Sunlight::Congress::Legislator.by_zipcode(zipcode)

	legislator_names = legislators.collect do |legislator|
		"#{legislator.first_name} #{legislator.last_name}"
		end

	legislator_names.join(",")
end

puts "EventManager Initialized!"
#using Ruby's CSV Library
contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol

template_letter = File.read "form_letter.html"

contents.each do |row|
	name = row[:first_name]
	zipcode = clean_zipcode(row[:zipcode])

		legislators = legislators_by_zipcode(zipcode).join(",")
		#creates a template for each person
		personal_letter = template_letter.gsub('FIRST_NAME', name)
		personal_letter.gsub!('LEGISLATORS', legislators)
		puts personal_letter
	puts "#{name} #{zipcode} #{lesgislators}"



end


#lines = File.readlines "event_attendees.csv"
#lines.each_with_index do |line,index|
#	next if index == 0
#	columns = line.split(",")
	#accessing the first name column.
#	name = clomuns[2]

# %{String Content} is one way of storing strings with multiple lines.
