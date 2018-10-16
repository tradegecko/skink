class Channel < ApplicationRecord
  belongs_to :account
  belongs_to :tradegecko_application
end
