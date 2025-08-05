defmodule Superdupernova.Accounts.Address do
  use Ash.Resource,
    domain: Superdupernova.Accounts,
    data_layer: Ash.DataLayer.Ets
  
  attributes do
    uuid_primary_key :id
    attribute :street, :string, allow_nil?: false
    attribute :city, :string, allow_nil?: false
    attribute :state, :string, allow_nil?: false
    attribute :zip, :string, allow_nil?: false
  end
  
  validations do
    validate string_length(:street, min: 5)
    validate string_length(:city, min: 2)
    validate string_length(:state, equals: 2)
    validate match(:zip, ~r/^\d{5}$/)
  end
  
  relationships do
    belongs_to :test_user, Superdupernova.Accounts.TestUser
  end
  
  actions do
    defaults [:create, :read, :update, :destroy]
  end
end