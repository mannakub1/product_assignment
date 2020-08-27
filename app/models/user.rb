class User < ApplicationRecord

    validates_uniqueness_of :account_id, scope: [:token_type]
end
