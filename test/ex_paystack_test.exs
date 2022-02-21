defmodule ExPaystackTest do
  use ExUnit.Case
  doctest ExPaystack

  test "greets the world" do
    assert {:ok, response} = ExPaystack.generate_payment_link()
    assert response.status_code == 200
  end
end
