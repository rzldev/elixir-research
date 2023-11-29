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
end
