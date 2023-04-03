class TradersController < ApplicationController
    before_action :authenticate_user!


    def index
        @trials = Iex.client.stock_market_list(:mostactive)
    end

    def show
        @trial = Iex.client.company(params[ :company_symbol])
    end

    private
        def set_trial
            @trial = Iex.client.company(params[ :company_symbol])
        end
        def post_params
            params.require(:trial).permit(:company_symbol)
        end
end
