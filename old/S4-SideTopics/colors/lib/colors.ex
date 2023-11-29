defmodule Colors do
  @moduledoc """
  Documentation for `Colors`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Colors.hello()
      :world

  """
  def hello do
    :world
  end

  def create_colors_map do
    %{primary: "Red", secondary: "Blue"}
  end

  def update_color(colors, key, value) do
    %{colors | "#{key}": value}
  end

  def add_color(colors, key, value) do
    Map.put(colors, key, value)
  end

  def get_value(colors, key) do
    colors[key]
  end
end
