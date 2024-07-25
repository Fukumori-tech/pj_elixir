defmodule TodoApp.Tasks do
  alias TodoApp.Repo
  #schema
  alias TodoApp.Tasks.Task

  def list_tasks(), do: Repo.all(Task)

  def get_task!(id), do: Repo.get!(Task, id)

  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end

  def change_task(%Task{} = task, attrs \\ %{}) do

    Task.changeset(task, attrs)

  end


end
