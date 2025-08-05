defmodule Superdupernova.Accounts.TestUser do
  use Ash.Resource,
    domain: Superdupernova.Accounts,
    data_layer: Ash.DataLayer.Ets,
    extensions: [AshPhoenix.Form]
  
  attributes do
    uuid_primary_key :id
    attribute :email, :string, allow_nil?: false
    attribute :name, :string, allow_nil?: false
    attribute :age, :integer
    attribute :bio, :string
    attribute :country, :string
    attribute :notifications, :boolean, default: false
    create_timestamp :created_at
    update_timestamp :updated_at
  end
  
  validations do
    validate match(:email, ~r/^[^\s]+@[^\s]+$/), message: "must be a valid email"
    validate string_length(:name, min: 2, max: 100)
    validate numericality(:age, greater_than: 0, less_than_or_equal_to: 150)
    validate string_length(:bio, max: 500)
    validate one_of(:country, ["us", "ca", "uk", "au"])
  end
  
  relationships do
    has_many :addresses, Superdupernova.Accounts.Address
  end
  
  actions do
    defaults [:read]
    
    create :register do
      accept [:email, :name, :age, :bio, :country, :notifications]
      
      argument :addresses, {:array, :map}
      
      change manage_relationship(:addresses, type: :create)
    end
    
    update :update do
      accept [:name, :age, :bio, :country, :notifications]
    end
  end
end