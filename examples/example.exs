defmodule Exfacebook.DevTest do
  require Logger

  alias Exfacebook.Api

  def get_connections do
    params = %{fields: "id,name", access_token: System.get_env("FACEBOOK_ACCESS_TOKEN")}

    {:ok, collection} = Api.get_connections(:me, :feed, params)
    Logger.info "[Exfacebook] me feed: #{inspect(collection)}"
  end

  def get_object do
    params = %{fields: "id,name", access_token: System.get_env("FACEBOOK_ACCESS_TOKEN")}

    {:ok, object} = Api.get_object(:me, params)
    Logger.info "[Exfacebook] me object: #{inspect(object)}"
  end

  def list_subscriptions do
    params = %{fields: "id,name"}

    {:ok, collection} = Api.list_subscriptions(params)
    Logger.info "[Exfacebook] subscriptions: #{inspect(collection)}"
  end

  def gen_list_subscriptions do
    {:ok, pid} = Exfacebook.start_link

    params = %{fields: "id,name"}

    {:ok, collection} = Exfacebook.list_subscriptions(pid, params)
    Logger.info "[Exfacebook] subscriptions: #{inspect(collection)}"
  end

  def subscribe do
    {:ok, pid} = Exfacebook.start_link

    response = Exfacebook.subscribe(pid, Exfacebook.Config.id, "friends, feed", "http://www.example.com/facebook/updates", "token-123")
    Logger.info "[Exfacebook] RESPONSE: #{inspect(response)}"
  end
end

if System.get_env("FACEBOOK_ACCESS_TOKEN") == nil do
  raise "FACEBOOK_ACCESS_TOKEN is required as env param"
end

if System.get_env("FACEBOOK_APP_ID") == nil do
  raise "FACEBOOK_APP_ID is required as env param"
end

if System.get_env("FACEBOOK_APP_SECRET") == nil do
  raise "FACEBOOK_APP_SECRET is required as env param"
end

Exfacebook.DevTest.list_subscriptions
Exfacebook.DevTest.gen_list_subscriptions
Exfacebook.DevTest.get_connections
Exfacebook.DevTest.get_object
Exfacebook.DevTest.subscribe
