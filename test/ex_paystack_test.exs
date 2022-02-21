defmodule ExPaystackTest do
  use ExUnit.Case
  doctest ExPaystack

  # test "greets the world" do
  #   assert {:ok, response} = ExPaystack.generate_payment_link()
  #   assert response.status_code == 200
  # end
  # doctest ExPaystack.Transaction
  @filter_params %{
    "from" => "2021-01-16T13:52:29.000Z",
    "to" => "2021-01-30T13:52:29.000Z"
  }
  @authorization_params %{
    "email" => "customer@email.com",
    "amount" => "20000",
    "authorization_code" => "AUTH_72btv547",
    "currency" => "NGN"
  }

  describe("Pin setup and verification") do
    test "list of transactions" do
      assert {:ok, response} = ExPaystack.list_transactions()
      assert response.status_code == 200
      [first | _] = response.body["data"]
      assert {:ok, response} = ExPaystack.fetch_transaction(first["id"])
      assert first["id"] == response.body["data"]["id"]
    end

    test "list of transactions with optional params" do
      assert {:ok, response} = ExPaystack.list_transactions(@filter_params)
      assert response.status_code == 200
    end

    test "total of transactions" do
      assert {:ok, response} = ExPaystack.total_transactions()
      assert response.status_code == 200
    end

    test "total of transactions and allow additional filter params" do
      assert {:ok, response} = ExPaystack.total_transactions(@filter_params)
      assert response.status_code == 200
    end

    test "export all transactions in csv format" do
      assert {:ok, response} = ExPaystack.export_transactions()
      assert response.status_code == 200
      assert Map.has_key?(response.body["data"], "path")
      assert Map.has_key?(response.body["data"], "expiresAt")
    end

    test "export all transactions in csv formay and allow additional filter params" do
      assert {:ok, response} = ExPaystack.export_transactions(@filter_params)
      assert response.status_code == 200
      assert Map.has_key?(response.body["data"], "path")
      assert Map.has_key?(response.body["data"], "expiresAt")
    end
  end

  describe("initialise payment link") do
    test "generate payment link" do
      assert {:ok, response} =
               ExPaystack.initialize(%{"email" => "customer@email.com", "amount" => "20000"})

      assert response.status_code == 200
    end

    test "verify payment transaction with wrong reference" do
      assert {:ok, response} = ExPaystack.verify_payment("iuiuii")
      assert response.status_code == 400
      assert response.body == %{"message" => "Transaction reference not found", "status" => false}
    end
  end

  describe("Charge authorizarion") do
    test "returns  error when email does not match Authorization code" do
      assert {:ok, response} = ExPaystack.charge_authorization(@authorization_params)

      assert response.status_code == 400

      assert response.body == %{
               "message" =>
                 "Email does not match Authorization code. Authorization may be inactive or belong to a different email. Please confirm.",
               "status" => false
             }
    end

    test "return error map  if authorization reference do not match is unsuccessful" do
      assert {:ok, response} = ExPaystack.check_authorization(@authorization_params)

      assert response.status_code == 400

      assert response.body == %{
               "message" =>
                 "Email does not match Authorization code. Authorization may be inactive or belong to a different email. Please confirm.",
               "status" => false
             }
    end
  end

  describe("Partial debit") do
    test "returns  error when email does not match Authorization code" do
      assert {:ok, response} = ExPaystack.partial_debit(@authorization_params)

      assert response.status_code == 400
    end
  end
end
