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

#カード足してみるだけ
def test_add_card()
	#参考
	#http://qiita.com/AKB428/items/a4a9ff2893affb20f99c
	Card.create(:name => "ががががが", :list_id => "5698751af2bdefd2e3b89abb")
end

#とりあえず保存的な
def test_20160409_1512
	id_board = ENV["my_board"]
	my_board = Trello.client.find(:board, id_board)
	my_list = my_board.lists

	#puts get_list_id_object(my_board.lists)
	p my_list[0].methods
end

#jsonでカードの情報を取得してみる
def test_get_card_as_json()
	my_card = Trello.client.find(:card, "pI9mUCHo")

	puts my_card.as_json
end

#コメントを取得してみる
#カードの中の、アクションの中の、さらにアトリビュートの中に"あるかもしれない"
#ぜんぶがぜんぶ、コメントのテキストを持っているわけではないので、ちゃんとチェックしないとダメ
def test_get_comments()
	my_card = Trello.client.find(:card, "pI9mUCHo")
	my_actions = my_card.actions	#カードからアクションを取得
	
	#アクションを全部チェックする
	my_actions.each do |action|
		#アクションのアトリビュートを見る
		my_attributes = action.attributes
		
		#アトリビュートの中に、テキスト（コメント）が存在した場合だけ抜き出す
		if my_attributes[:data].key?("text") then
			comment = my_attributes[:data]["text"]
			p comment
		end
	end
end

exit	#終了してみる
