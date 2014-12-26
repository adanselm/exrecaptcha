# Exrecaptcha

Simple [ReCaptcha] display/verify code for Elixir applications.
Using Exrecaptcha with a CMS such as [Phoenix] is easy.

[ReCaptcha]: http://www.google.com/recaptcha
[Phoenix]: https://github.com/phoenixframework/phoenix

## Installation

Set as a dep in your mix.exs and ensure it is running with your app:

```elixir
  def application do
    [
      # ...
      applications: [:phoenix, :cowboy, :logger, :exrecaptcha]
      # ...
    ]
  end

  defp deps do
    [
      {:phoenix, "0.5.0"},
      {:cowboy, "~> 1.0.0"},
      #...
      {:ibrowse, github: "cmullaparthi/ibrowse", tag: "v4.1.0"},
      {:exrecaptcha, "~> 0.0.3"}
    ]
  end
```

And fetch your project's dependencies:

```bash
$ mix deps.get
```

## Config

In your application's config.exs :

```elixir
config :exrecaptcha,
  api_config: %{ verify_url: "http://www.google.com/recaptcha/api/verify",
                 public_key: "YOUR_PUBLIC_KEY",
                 private_key: "YOUR_PRIVATE_KEY" }
```

You can use https instead of http for the `verify_url`.

## Usage

### View

Put this code somewhere in your html template:

```html
<form id="loginForm" name="newuser" method="post" action="/users">
  ...
  <%= safe Exrecaptcha.display %>
  ...
</form>
```

### Controller

Provided you've set the routing properly, you just have to call

```elixir
# your post method should route you here:
def create(conn, params) do
  # do stuff, then check for the validity of the captcha
  :ok = verify_captcha(conn, params)
end

defp verify_captcha(conn, %{"recaptcha_challenge_field" => challenge,
                            "recaptcha_response_field" => response}) do
  remote_ip = conn.remote_ip
  Exrecaptcha.verify(remote_ip, challenge, response)
end
```

##TODO

- No option for recaptcha display can be set yet
- Error handling is quite inexistent (throws RuntimeError)
- No tests

## Changelog

- 0.0.3: Update HTTPotion dependency, avoiding elixir version warnings
- 0.0.2: Use HTTPS by default
- 0.0.1: Initial release

## Licensing
Copyright © 2014 [Adrien Anselme](https://github.com/adanselm) and [contributors](https://github.com/adanselm/exrecaptcha/graphs/contributors)
This work is free. You can redistribute it and/or modify it under the
terms of the Do What The Fuck You Want To Public License, Version 2,
as published by Sam Hocevar. See the COPYING file for more details.
