alias Example.Repo
alias Example.User

#初期データ
users = [
  {"Yamada", "Taro", 20},
  {"Sato", "Hanako", 18},
  {"Suzuki", "Jiro", 23},
  {"Sasaki", "Mami", 22},
  {"Ito", "Aki", 22},
  {"Yamaguti", "Atusi", 19},
  {"Sakamoto", "Hajime", 24},
  {"Akimoto", "Satosi", 17},
  {"Makimoto", "Riyu", nil}
]

Enum.each(users, fn {last_name, first_name, age} ->
  user =
    %User{
      first_name: first_name,
      last_name: last_name,
      age: age,
      email: first_name <> "@example.com"
    }

    Repo.insert!(user)
end)
