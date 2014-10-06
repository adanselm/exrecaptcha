defmodule Exrecaptcha do
  require Elixir.EEx

  # Define display function to be read in .eex file
  EEx.function_from_file :defp, :display, "lib/display.eex", [:public_key]

  def display do
    display conf.public_key
  end

  def verify(remote_ip, challenge, response) when is_tuple(remote_ip) do
    verify(:inet_parse.ntoa(remote_ip), challenge, response)
  end
  def verify(remote_ip, challenge, response) do
    query = URI.encode_query(%{"privatekey" => conf.private_key,
                               "remoteip" => to_string(remote_ip),
                               "challenge" => challenge,
                               "response" => response})
    IO.inspect query
    headers = ["Content-type": "application/x-www-form-urlencoded",
               "User-agent": "reCAPTCHA Elixir"]
    %{:body => body} = HTTPotion.post conf.verify_url, query, headers
    check_result String.split(body)
  end

  defp conf do
    Application.get_env(:exrecaptcha, :api_config)
  end

  defp check_result(["true", _reason]) do
    :ok
  end
  defp check_result(["false", reason]) do
    raise RuntimeError, message: reason
  end

end
