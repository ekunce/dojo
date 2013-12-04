# This class reads the Life RLE format and outputs an array. For example,
# for Glider RLE: "bo$\n2bo$\n3o!"
# it produces the following array of arrays
#
# [[0,1,0]
# [0,0,1]
# [1,1,1]]
#
#------------------------------------------------------------------------

class Rle
	attr_reader :rows, :cols, :match_pattern, :cell_array, :pattern_name, :pattern_comments

	def initialize(file_name = nil)
		@rows = 0
		@cols = 0
		@match_pattern = /(\d*[bo])/
		@cell_array = []
		@pattern_name = ""
		@pattern_comments = ""

		# if file name was passed, lets decode the file immediatelly
		if file_name
			decode_file(file_name)
		end
	end

	def decode_file(file_name)
		# Read the file content
		file_content = File.read(file_name)
		file_content.gsub!(/\r/, "\n")

		# Split the content into individual lines
		file_lines = file_content.split("\n")

		pattern_start = 0

		file_lines.length.times do |idx|
			
			# match: pattern name
			md = file_lines[idx].match(/(#N)(.*)/)
			if md
				@pattern_name += md[2].strip
			end

			# match: pattern comments
			md = file_lines[idx].match(/(#C)(.*)/)
			if md
				@pattern_comments += md[2].strip
				@pattern_comments += "\n"
			end

			# match: xsize, ysize, rules
			md = file_lines[idx].match(/x = (\d*)/i)
			if md
				# process x size
				@cols = md[0].match(/(\d+)/)[0].to_i

				# process y size
				md = file_lines[idx].match(/y = (\d*)/i)
				if md
					@rows = md[0].match(/(\d+)/)[0].to_i
					
					# ignore rule for now
					pattern_start = idx + 1
					break
				else
					return false
				end
			end
		end

		pattern_string = file_lines.drop(pattern_start).join
		return decode_string(pattern_string, @rows, @cols)

	end

	def decode_string(string, rows, cols)
		@cell_array.clear
		@rows = rows
		@cols = cols

		# make it all one big line
		one_line_string = string.split.join

		# remove ! at the end of line
		one_line_string.gsub!(/!/, "")

		# split by logical lines
		lines_array = one_line_string.split("$")

		lines_array.each do |line|
			decode_single_row(line)
		end

		return true
	end

	private
		def decode_single_row(row_string)
			line_array = []
			line_segments = row_string.scan(match_pattern).flatten!

			line_length = 0
			line_segments.each do |segment|

				# get the pattern repeat count
				repeat_count = segment[0..-2].to_i != 0 ? segment[0..-2].to_i : 1

				# create line_array
				repeat_count.times { line_array << (segment[-1] == 'o' ? 1 : 0) }

				# keep track of used bytes
				line_length += repeat_count
			end

			# add trailing 'b' cells, if needed
			if line_length < @cols
				(@cols - line_length).times { line_array << 0}
			end

			# append the single line array to the object array
			@cell_array << line_array

		end

end
