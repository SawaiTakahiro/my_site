#! ruby -Ku

=begin
 2016/04/08
 ちょっとずつためしてるやつ
=end

##########################################################################################
#共通の部分
require "./trello_ruby.rb"
require "./library.rb"


##########################################################################################
me = Trello::Member.find("me")

#自分のボードを表示する場合の例
#ボードクラスを取得してくる感じ（Trello::Board）
def test_disp_mybords()
	#自分を定義しておく
	me = Trello::Member.find("me")
	
	test = me.boards
	test.each do |hoge|
		puts hoge
	end
end

#指定したIDのボードを取ってくる場合の例
def test_get_board(id_board)
	return Trello.client.find(:board, id_board)
end

#ボードの情報をjsonで保存してみる
def test_save_board_attributes()
	my_board = Trello.client.find(:board, ENV["my_board"])
	save_json(my_board.attributes.to_json, "./hoge.json")
end

def test_view_attributes()
	#ボードの情報
	attribute = read_json("./hoge.json")

	attribute.each do |key, value|
		print "#{key}	:	#{value}\n"
	end
end

#ボードからカードのリストを取得する
def test_get_list_cardid()
	my_board = Trello.client.find(:board, ENV["my_board"])
	list_cards = my_board.cards
	
	output = Array.new
	list_cards.each do |card|
		output << card.id
	end
	
	puts output
end