defmodule TodoAppWeb.TaskController do
  use TodoAppWeb, :controller

  alias TodoApp.Tasks

  def index(conn, _params) do
    tasks = Tasks.list_tasks()

    render(conn, :index, tasks: tasks)
  end

  def new(conn, _params) do
    cs = Tasks.change_task(%Tasks.Task{})

    render(conn, :new, changeset: cs)
  end

  def create(conn, %{"task" => task_params}) do
    case Tasks.create_task(task_params) do
      {:ok, _task} ->
        conn|> put_flash(:info, "created task.")
        |> redirect(to: ~p"/tasks")

      {:error, cs} ->
        render(conn, :new, changeset: cs)
    end

  end

  def show(conn, %{"id" => id})) do
    task = Tasks.get_task!(id)
 render(conn, :show, task: task)
   # IO.inspect(params)
  end
end