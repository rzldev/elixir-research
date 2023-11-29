defmodule Hello do
  def world(name \\ "World") do
    IO.puts("Hello #{name}")
  end
end
