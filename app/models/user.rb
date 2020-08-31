class User < ApplicationRecord

    validates_presence_of :account_id
    validates_presence_of :token_type
    validates_presence_of :token
    validates_uniqueness_of :account_id, scope: [:token_type]
end
