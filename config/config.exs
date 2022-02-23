use Mix.Config

config :ex_paystack,
  secret_key: System.get_env("PAYSTACK_SECRET_KEY")
