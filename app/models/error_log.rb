class ErrorLog < ApplicationRecord
  belongs_to :resource_reference
  belongs_to :channel
end
