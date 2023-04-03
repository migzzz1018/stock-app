class Stock < ApplicationRecord
    belongs_to :user
    has_many :orders
  
    def latest_price
        @caller = Iex.client.quote(: symbol)
    end

    def user
        User.find(user_id)
    end
end
