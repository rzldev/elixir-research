defmodule Cards do
  @moduledoc """
  Documentation for `Cards`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Cards.hello()
      :world

  """

  # def hello do
  #   :world
  # end

  def hello do
    "Hello World!"
  end

  def create_deck do
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    values = [
      "Ace",
      "One",
      "Two",
      "Three",
      "Four",
      "Five",
      "Six",
      "Seven",
      "Eight",
      "Nine",
      "Ten",
      "Jack",
      "Queen",
      "King"
    ]

    ## First solution which not wrong but could be better
    # cards for suit <- suits do
    #   for value <- values do
    #     "#{value} of #{suit} "
    #   end
    # end
    # List.flatten(cards)

    ## Better solution
    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That file does not exist."
    end
  end

  def create_hand(hand_size) do
    ## This is not wrong, but doing a pipe operator will be much more easier to read
    # deck = create_deck()
    # deck = shuffle(deck)
    # deal(deck, hand_size)

    ## Pipe operator
    ## Pipe operator is require us to write methods that take consistent first argument
    create_deck() |> shuffle() |> deal(hand_size)
  end
end
