defmodule ExPaystack do
  alias PaystackBase
    @moduledoc """
  Documentation for `ExPaystack`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> ExPaystack.hello()
      :world

  """
  def generate_payment_link() do

    PaystackBase.api_call("/transaction", :get, %{ "from" => "2021-01-16T13:52:29.000Z", "to"=> "2021-01-16T13:52:29.000Z" })
  end
end
