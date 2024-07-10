defmodule DataConversationTest do
  use ExUnit.Case
  doctest DataConversation

  test "greets the world" do
    assert DataConversation.hello() == :world
  end
end
