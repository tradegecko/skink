class ErrorLogSerializer < ActiveModel::Serializer
  has_one :resource_reference, include: true, key: :object

  attributes :id, :created_at, :message, :verb
end
