#! ruby -Ku

=begin
 2016/04/08
 trello-rubyを使う部分まとめ
=end

##########################################################################################
#共通の部分

require "fileutils"
require "CSV"
require "json"

require "trello"
require "dotenv"

include Trello
include Trello::Authorization

#APIキーとかを読み込んで設定する
Dotenv.load
Trello.configure do |config|
	config.consumer_key = ENV["TRELLO_CONSUMER_KEY"]
	config.consumer_secret = ENV["TRELLO_CONSUMER_SECRET"]
	config.oauth_token = ENV["TRELLO_OAUTH_TOKEN"]
end

##########################################################################################
#Trelloのオブジェクトを渡されると、IDだけ返す
def get_list_id_object(objects)
	output = Array.new
	
	objects.each do |object|
		output << object.id
	end
	
	return output
end

#渡されたカードIDに含まれる、コメントを抜き出す
def get_comments(id_card)
	my_card = Trello.client.find(:card, id_card)
	my_actions = my_card.actions	#カードからアクションを取得
	
	output = Array.new
	my_actions.map do |action|
		#アクションのアトリビュートを見る
		my_attributes = action.attributes
		
		#アトリビュートの中に、テキスト（コメント）が存在した場合だけ抜き出す
		if my_attributes[:data].key?("text") then
			comment = my_attributes[:data]["text"]
			output << comment
		end
	end
	
	return output
end

##########################################################################################
#以下、あんまりいけてないかもしれない処理
#そのボードに含まれるlistのIDを配列で返す
#ID以外の情報は取ってこないよ
def get_list_id_lists(id_board)
	my_board = Trello.client.find(:board, id_board)
	list_lists = my_board.lists
	
	output = Array.new
	list_lists.each do |list|
		output << list.id
	end
	
	return output
end

#そのボードに含まれるカードのIDを配列で返す
#ID以外の情報は取ってこないよ
def get_list_id_cards(id_board)
	my_board = Trello.client.find(:board, id_board)
	list_cards = my_board.cards
	
	output = Array.new
	list_cards.each do |card|
		output << card.id
	end
	
	return output
end


