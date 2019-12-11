class CardController < ApplicationController

  require "payjp"
  before_action :set_card, only: [:delete, :show]
  protect_from_forgery

  def index
    
  end

  def new
    card = Card.where(user_id: current_user.id)
    if card.exists?
      redirect_to action: "show"
    else
      @card
    end
  end 

  def pay #payjpとCardのデータベース作成を実施します。(マイページクレジットカード登録用)
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjp-token'].blank?
      redirect_to new_card_path 
    else
      customer = Payjp::Customer.create(
      description: 'テスト',
      email: current_user.email,
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      ) 
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to action: "show"
      else
        redirect_to new_card_path
      end
    end
  end


  def pay_registration #payjpとCardのデータベース作成を実施します。(usersコントローラー会員登録用)
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjp-token'].blank?
      redirect_to new_card_path 
    else
      customer = Payjp::Customer.create(
      description: 'テスト',
      email: current_user.email,
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      ) 
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to complete_signup_signup_index_path # 会員登録完了ページに移動
      else
        redirect_to new_card_path
      end
    end
  end

  def delete #PayjpとCardデータベースを削除します
    if @card.blank?
      redirect_to action: "index"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      if customer.delete && @card.delete
        redirect_to card_index_path
      else
        redirect_to card_index_path, alert: '削除に失敗しました。'
      end
      
    end
      
  end

  def show #Cardのデータpayjpに送り情報を取り出します
    
    if @card.blank?
      redirect_to action: "index"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end


  def set_card
    @card = Card.find_by(user_id: current_user.id) if Card.find_by(user_id: current_user.id).present?
  end

end