defmodule MymobTest do
  use ExUnit.Case
  doctest Mymob
  #doctest DocumentTest

  describe "Integer+1 group" do
    test"Integer+1_1" do
      assert Mymob.my_func(100) == 101
    end

    test"Integer+1_2" do
      assert Mymob.my_func(99) == 100
    end

    test"Integer+1_3" do
      assert Mymob.my_func(0) == 1
    end

  end

  describe "String+1 group" do
    test"String+1_1" do
      assert Mymob.my_funcs("100") == 101
    end

    test"String+1_2" do
      assert Mymob.my_funcs("99") == 100
    end

    test"String+1_3" do
      assert Mymob.my_funcs("0") == 1
    end

  end

end
