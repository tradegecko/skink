class ResourceReference < ApplicationRecord
  belongs_to :account
  belongs_to :channel
  has_many :error_logs
end
