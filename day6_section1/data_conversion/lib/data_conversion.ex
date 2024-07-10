defmodule DataConversion do
  def api_request(end_point_api \\
"https://api.data.metro.tokyo.lg.jp/v1/PublicFacility") do
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
    #値を取り出す　マップ名["キー名"]を二重にやっている、その上で？？？？
   name: map["名称"]["表記"],
   lat: map["地理座標"]["緯度"],
   lon: map["地理座標"]["経度"]
  }
end

def get_geographic_coordinates(list) do
  #why need & ?
Enum.map(list, & get_geographic_coordinate/1)
end

def create_csv(list, path \\ "new.csv") do
  list
  |> CSV.encode(headers: true)
  |> Enum.to_list()
  |> Enum.join()
  #then???
  |> then(fn csv -> File.write!(path, csv) end)

end

def read_csv(path) do
  path
  |> File.stream!()
  |> CSV.decode!(headers: true)
  |> Enum.to_list()

end

  @moduledoc """
  Documentation for `DataConversion`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> DataConversion.hello()
      :world

  """
  def hello do
    :world
  end
end
