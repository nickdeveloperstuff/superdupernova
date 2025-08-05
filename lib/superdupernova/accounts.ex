defmodule Superdupernova.Accounts do
  use Ash.Domain, otp_app: :superdupernova, extensions: [AshAdmin.Domain]

  admin do
    show? true
  end

  resources do
    resource Superdupernova.Accounts.Token
    resource Superdupernova.Accounts.User
    resource Superdupernova.Accounts.TestUser
    resource Superdupernova.Accounts.Address
  end
end
