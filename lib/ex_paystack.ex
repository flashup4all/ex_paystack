defmodule ExPaystack do
  alias PaystackBase

  @moduledoc """
  Documentation for `ExPaystack`.

  Setup

  mix.exs
  """

  @doc """
  List transactions.

  ## Examples

      iex> ExPaystack.list_transactions()


  """

  def list_transactions(url_params \\ %{}) do
    PaystackBase.api_call("/transaction", :get, url_params)
  end

  def verify_payment(reference) do
    PaystackBase.api_call("/transaction/verify/#{reference}", :get)
  end

  def initialize(params) do
    PaystackBase.api_call("/transaction/initialize", :post, params)
  end

  @spec fetch_transaction(any) ::
          {:error, any}
          | {:ok,
             %{
               :body =>
                 false
                 | nil
                 | true
                 | binary
                 | [false | nil | true | binary | list | number | {any, any, any} | map]
                 | number
                 | %{
                     optional(atom | binary | {any, any, any}) =>
                       false | nil | true | binary | list | number | {any, any, any} | map
                   },
               :status_code => any,
               optional(any) => any
             }}
  def fetch_transaction(id) do
    PaystackBase.api_call("/transaction/#{id}", :get)
  end

  def charge_authorization(params) do
    PaystackBase.api_call("/transaction/charge_authorization", :post, params)
  end

  def check_authorization(params) do
    PaystackBase.api_call("/transaction/charge_authorization", :post, params)
  end

  def check_authorization(params) do
    PaystackBase.api_call("/transaction/charge_authorization", :post, params)
  end

  def total_transactions(params \\ %{}) do
    PaystackBase.api_call("/transaction/totals", :get, params)
  end

  def export_transactions(params \\ %{}) do
    PaystackBase.api_call("/transaction/export", :get, params)
  end

  def partial_debit(params \\ %{}) do
    PaystackBase.api_call("/transaction/partial_debit", :get, params)
  end
end
