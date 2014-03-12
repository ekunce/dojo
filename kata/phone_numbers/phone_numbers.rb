class PhoneNumbersChecker
	def self.is_file_consistent(file_name)
		map = {}
		File.open(file_name).each_with_index do |line, index|
			next if index == 0

			name,number = line.split(',')
			number.tr!(' -', '')
			number.strip!

			map[name] = number
		end

		sorted_arr = map.sort_by {|k,v| v}

		sorted_arr.each_with_index do |item, index|
			next if index == 0
			
			if item[1].start_with?(sorted_arr[index-1][1])
				return false,[item[0], sorted_arr[index-1][0]]
			end
		end

		return true,[]
	end
end