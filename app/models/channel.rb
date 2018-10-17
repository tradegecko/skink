class Channel < ApplicationRecord
  belongs_to :account
  belongs_to :tradegecko_application
  has_many :resource_references
  has_many :error_logs
end
