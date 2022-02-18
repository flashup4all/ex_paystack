defmodule PaystackBase do

  use HTTPoison.Base
  import ExPaystack.PaystackResponse, only: [decode_response_body_data: 1]



  @base_url "https://api.paystack.co"
  # @paystack_token "sk_live_6bbd7859c4f2af2fcd05c1d1bd0376be66d8e727"
  @paystack_secret_key System.get_env("PAYSTACK_SECRET_KEY")#"sk_test_fd14a7bf797418b335272c2bd9807d135eefac90"

  @headers ["Accept": "Application/json", "Cache-Control": "no-cache", "Authorization": "Bearer #{@paystack_secret_key}"]
  @options [ssl: [{:versions, [:'tlsv1.2']}]]


  def process_request_url(url, headers \\ []) do
    @base_url <> url
  end



  def api_call(url, method, params \\ :nil) do
    case method do
      :post ->
        url |> process_request_url |> HTTPoison.post(
          Poison.encode!(params),
          @headers,
          @options
        ) |> decode_response_body_data

      :get ->
        url |> process_request_url |> HTTPoison.get(@headers, params: params) |> decode_response_body_data
      _ -> {:error, "invalid HTTP method"}
    end
  end
end
