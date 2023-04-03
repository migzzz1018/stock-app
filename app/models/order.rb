class Order < ApplicationRecord
    belongs_to :user
    belongs_to :stock
    before_create :check_order_validity
    after_create :complete_order_process
    validates :order_type, inclusion: { in: %w(buy sell),
         message: "%{value} is not a valid order" }
  
    def stock
      Stock.find_by(id: stock_id, user_id: user_id)
    end
  
    def trader
      User.find(user_id)
    end
  
    private
  
    def check_order_validity
      buy_total = self.stock.latest_price * quantity
      self.total = buy_total
      if quantity <= 0
        errors.add(:base, "You cannot #{order_type} negative or 0 shares.")
        throw :abort
      end
  
      if order_type == "buy" && trader.balance < buy_total
        errors.add(:base, 'Insufficient balance, please try again.')
        throw :abort
      end
  
      sell_total = self.stock.quantity - self.quantity
  
      if order_type == "sell" && sell_total < 0
        errors.add(:base, 'Insufficient share, please try again.')
        throw :abort
      end
  
    end
  
    def complete_order_process
      order_trader = self.trader
      order_stock = self.stock
      if order_type == "buy"
        order_trader.balance -= total
        order_stock.quantity += quantity
  
        order_trader.save!
        order_stock.save!
      else
        order_trader.balance += total
        order_stock.quantity -= quantity
  
        order_trader.save!
        order_stock.save!
      end
    end
  
  end
  