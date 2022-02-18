defmodule ExPaystack.PaystackResponse do

  def decode_response_body_data({:ok, %{ status_code: status_code, body: body} = response}) do
    body = body |> Poison.decode!
    {:ok, %{response | body: body}}
  end

  def decode_response_body_data({:error, _} = response), do: response

end
