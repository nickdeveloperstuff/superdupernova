defmodule Superdupernova.Secrets do
  use AshAuthentication.Secret

  def secret_for(
        [:authentication, :tokens, :signing_secret],
        Superdupernova.Accounts.User,
        _opts,
        _context
      ) do
    Application.fetch_env(:superdupernova, :token_signing_secret)
  end
end
