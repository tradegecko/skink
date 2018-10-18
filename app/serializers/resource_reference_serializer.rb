class ResourceReferenceSerializer < ActiveModel::Serializer
  attribute :tradegecko_id, key: :id
  attribute :resource_type, key: :object_type
  attribute :tradegecko_parent_id, key: :parent_id
  attributes :display_name
end
