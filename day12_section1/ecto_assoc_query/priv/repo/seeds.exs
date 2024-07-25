alias EctoAssocQuery.{Repo, Artist, MusicList, Music, User, PlayList, PlayListMusic, ActiveUser, DeleteUser}

csv =
  "day12_music.csv"
  |> File.stream!()
  |> CSV.decode!(headers: true)
  |> Enum.to_list()

  #%{
    #"artist_name" => "Marion Clements",
    #"category" => "EP",
    #"music_category" => "classic",
    #"music_list_name" => "Weston Russo",
    #"music_name" => "Weston Russo"
  #}みたいなマップのリストになっている

  #アーティストの登録
  csv
  |> Enum.map(fn %{"artist_name" => artist} -> artist end)
  #["Marion Clements", "Austin Mcneil", "Jorge Mooney", "Major Rich",
 #"Marion Clements", "Jorge Mooney", "Austin Mcneil", "Weston Russo",
 #"Austin Mcneil", "Major Rich", "Austin Mcneil", "Major Rich",
 #"Marion Clements", "Weston Russo", "Marion Clements", "Major Rich",
 #"Major Rich", "Jorge Mooney", "Major Rich", "Jorge Mooney", "Jorge Mooney",
 #"Weston Russo", "Jorge Mooney", "Austin Mcneil", "Major Rich"]
  |> Enum.uniq()
 # ["Marion Clements", "Austin Mcneil", "Jorge Mooney", "Major Rich",
 #"Weston Russo"]
  |> Enum.each(fn artist -> Repo.insert!(%Artist{name: artist}) end)

  #難しい！！！
  #楽曲listの登録
  csv
  #＠＠＠ただ束縛している？
  |> Enum.map(fn data ->
    {#ML構造体のnameキーにはdataというmapの”m_l_n”の値割り当てる（map更新）
      %MusicList{name: data["music_list_name"], category: data["category"], music_category: data["music_category"]}, data["artist_name"]
    }
  end)
  #{%EctoAssocQuery.MusicList{
   # __meta__: #Ecto.Schema.Metadata<:built, "music_lists">,
    #id: nil,
    #name: "Weston Russo",
    #category: "EP",
    #music_category: "classic",
    #artist_id: nil,
    #artist: #Ecto.Association.NotLoaded<association :artist is not loaded>,
    #musics: #Ecto.Association.NotLoaded<association :musics is not loaded>
  #}, "Marion Clements"},のリスト
  #＠＠＠csvを？
  #artistごとにかぶっているmusiclistをひとつにする
  |> Enum.uniq()
  #               ml構造体　　　　文字列
  |> Enum.each(fn {music_list, artist_name} ->
    artist = Repo.get_by(Artist, name: artist_name)
    Repo.insert!(%{music_list | artist_id: artist.id} )
  end)

  #楽曲の登録
  #＠＠＠わからない！！！
  Enum.each(csv, fn data ->
    # ML構造体のnameキーからdata（csv）のmapから["キー名"]で値を取り出し、変数に束縛
    music_list = Repo.get_by(MusicList, name: data["music_list_name"])
    # map更新   構造体　構キー名　map名　キー名
    Repo.insert!(%Music{name: data["music_name"], music_list_id: music_list.id})
  end)

  #ユーザーの登録

  user = Repo.insert!(%User{name: "taro", email: "taro@example.com"})

  Repo.insert!(%ActiveUser{user_id: user.id})

  #ユーザー(taro)のplaylist登録
  Enum.each(1..2, fn index ->
    play_list = Repo.insert!(%PlayList{name: "play list #{index}", user_id: user.id})

  "day12_play_list#{index}.csv"
  |> File.stream!()
  |> CSV.decode!(headers: true)
  |> Enum.each(fn %{"music_name" => music_name} ->
    music = Repo.get_by(Music, name: music_name)
    Repo.insert!(%PlayListMusic{play_list_id: play_list.id, music_id: music.id} )
  end)
  end)

  user = Repo.insert!(%User{name: "hanako", email: "hanako@example.com"})

  Repo.insert!(%DeleteUser{user_id: user.id})
