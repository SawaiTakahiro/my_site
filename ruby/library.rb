#! ruby -Ku

=begin
 2016/03/31
 よくつかうやつまとめ
=end

#共通の部分
#使うライブラリ
require "fileutils"
require "CSV"
require "json"

##########################################################################################
#CSVファイルを読み込んで、配列で返すやつ
def test()
	puts "test"
end

#配列をCSVで保存する
def save_csv(array, save_path)
	CSV.open(save_path, "w") do |csv|
		array.each{|row| csv << row}
	end
end


#JSONを読んで、ハッシュで返すやつ
def read_json(path)
	data = open(path) do |io|
		JSON.load(io)
	end
	
	return data
end

#ハッシュをJSONで保存するやつ
def save_json(hash, save_path)
	open(save_path, "w") do |io|
		JSON.dump(hash, io)
	end
end
