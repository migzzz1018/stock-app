class Iex < ApplicationRecord
    def self.client
        IEX::Api::Client.new(
        publishable_token: 'pk_ca9550dcc7e04e44a14ab0c5efd90c69',
        secret_token: 'sk_b9a2b2fe76fe47cea5f30cba39a495ac',
        endpoint: 'https://cloud.iexapis.com/v1'
        )
    end
end
