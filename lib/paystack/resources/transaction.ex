defmodule ExPaystack.Transaction do
  defstruct [
    :amount,
    :authorization,
    :channel,
    :createdAt,
    :created_at,
    :currency,
    :customer,
    :domain,
    :fees,
    :fees_split,
    :gateway_response,
    :id,
    :ip_address,
    :log,
    :message,
    :metadata,
    :order_id,
    :paidAt,
    :paid_at,
    :plan,
    :pos_transaction_data,
    :reference,
    :requested_amount,
    :source,
    :split,
    :status,
    :subaccount
  ]

  alias PaystackBase

  @type filter_map :: %{
          perPage: integer,
          page: integer,
          customer: integer,
          amount: integer,
          status: String.t(),
          from: String.t(),
          to: String.t()
        }
  @type(
    customer :: %{
      customer_code: String.t(),
      email: String.t(),
      first_name: String.t(),
      id: integer,
      last_name: String.t(),
      metadata: String.t(),
      phone: String.t(),
      risk_action: String.t()
    },
    @type(
      authorization :: %{
        account_name: String.t(),
        authorization_code: String.t(),
        bank: String.t(),
        bin: String.t(),
        brand: String.t(),
        card_type: String.t(),
        channel: String.t(),
        country_code: String.t(),
        exp_month: String.t(),
        exp_year: String.t(),
        last4: String.t(),
        reusable: String.t(),
        signature: String.t()
      }
    )
  )

  # @type transaction :: %{
  #   amount: integer,
  #   authorization: authorization%{},
  #   channel: String.t,
  #   createdAt: String.t,
  #   created_at: String.t,
  #   currency: String.t,
  #   customer: customer,
  #   domain: String.t,
  #   fees: String.t,
  #   fees_split: String.t,
  #   gateway_response: String.t,
  #   id: integer,
  #   ip_address: String.t,
  #   log: String.t,
  #   message: String.t,
  #   metadata: String.t,
  #   order_id: integer,
  #   paidAt: String.t,
  #   paid_at: String.t,
  #   plan: %{},
  #   pos_transaction_data: %{},
  #   reference: String.t,
  #   requested_amount: integer,
  #   source: String.t,
  #   split: %{},
  #   status: String.t,
  #   subaccount: %{}
  # }

  @type transaction_response :: %{
          data: integer,
          page: integer,
          customer: integer,
          amount: integer,
          status: String.t(),
          from: String.t(),
          to: String.t()
        }

  @spec list_transactions(%{
          perPage: integer,
          page: integer,
          customer: integer,
          amount: integer,
          status: String.t(),
          from: String.t(),
          to: String.t()
        }) :: map()
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
