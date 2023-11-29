defmodule Identicon do
  @moduledoc """
  Documentation for `Identicon`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Identicon.hello()
      :world

  """
  def hello do
    :world
  end

  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> build_pixel_map
    |> draw_image
    |> save_image(input)
  end

  def hash_input(input) do
    hex =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list()

    %Identicon.Image{hex: hex}
  end

  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
  end

  def build_grid(%Identicon.Image{hex: hex_list} = image) do
    hex =
      hex_list
      |> Enum.chunk(3)
      |> Enum.map(&mirror_row/1)
      |> List.flatten()

    %Identicon.Image{image | grid: hex}
  end

  def mirror_row(row) do
    [first, second | _tail] = row
    row ++ [second, first]
  end

  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    pixel_map =
      Enum.map(Enum.with_index(grid), fn {code, index} ->
        odd? = rem(code, 2) == 0

        if odd? do
          horizontal = rem(index, 5) * 50
          vertical = div(index, 5) * 50

          top_left = {horizontal, vertical}
          bottom_right = {horizontal + 50, vertical + 50}

          {top_left, bottom_right}
        else
          false
        end
      end)
      |> Enum.filter(& &1)

    %Identicon.Image{image | pixel_map: pixel_map}
  end

  def draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)

    Enum.each(pixel_map, fn {start, stop} ->
      :egd.filledRectangle(image, start, stop, fill)
    end)

    :egd.render(image)
  end

  def save_image(image, filename) do
    path = "tmp/#{filename}.png"
    with :ok <- File.mkdir_p(Path.dirname(path)) do
      File.write(path, image)
    end
  end
end
