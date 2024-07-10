defmodule DataConversation do
  def api_request(end_point_api \\
 "https://api.data.metro.tokyo.lg.jp/v1/PublicFacility" ) do
 end_point_api
 |> HTTPoison.get!()
 |> Map.get(:body)
 |> Jason.decode!()
 |> hd()

 end
 #JSON形式「に」変換
 def json_encode!(list) do
   Jason.encode!(list)
 end

 #マップに変換
 def get_geographic_coordinate(map) do
   %{
    name: map["名称"]["表記"],
    lat: map["地理座標"]["緯度"],
    lon: map["地理座標"]["経度"]
   }
 end

 def get_geographic_coordinate(list) do

 end

  @moduledoc """
  Documentation for `DataConversation`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> DataConversation.hello()
      :world

  """
  def hello do
    :world
  end
end
