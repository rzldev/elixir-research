defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards.
  """

  @doc """
    Hello World!

    ## Example

        iex> Cards.hello
        "Hello World!"

  """
  def hello do
    "Hello World!"
  end

  @doc """
    Returns a list of string representing a deck of playing cards.

    ## Example

        iex> Cards.create_deck
        ["Ace of Spades", "One of Spades", "Two of Spades", "Three of Spades",
        "Four of Spades", "Five of Spades", "Six of Spades", "Seven of Spades",
        "Eight of Spades", "Nine of Spades", "Ten of Spades", "Jack of Spades",
        "Queen of Spades", "King of Spades", "Ace of Clubs", "One of Clubs",
        "Two of Clubs", "Three of Clubs", "Four of Clubs", "Five of Clubs",
        "Six of Clubs", "Seven of Clubs", "Eight of Clubs", "Nine of Clubs",
        "Ten of Clubs", "Jack of Clubs", "Queen of Clubs", "King of Clubs",
        "Ace of Hearts", "One of Hearts", "Two of Hearts", "Three of Hearts",
        "Four of Hearts", "Five of Hearts", "Six of Hearts", "Seven of Hearts",
        "Eight of Hearts", "Nine of Hearts", "Ten of Hearts", "Jack of Hearts",
        "Queen of Hearts", "King of Hearts", "Ace of Diamonds", "One of Diamonds",
        "Two of Diamonds", "Three of Diamonds", "Four of Diamonds", "Five of Diamonds",
        "Six of Diamonds", "Seven of Diamonds", "Eight of Diamonds", "Nine of Diamonds",
        "Ten of Diamonds", "Jack of Diamonds", "Queen of Diamonds", "King of Diamonds"]

  """
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

  @doc """
    Randomizes a given `deck` of cards.

    ## Example

        iex>deck = Cards.create_deck
        iex>Cards.shuffle(deck) != deck
        true

  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determines whether a `deck` contains a given `card`.

    ## Example

        iex>deck = Cards.create_deck
        iex>Cards.contains?(deck, "Ace of Hearts")
        true
        iex>Cards.contains?(deck, "Ace")
        false

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Returns a list of cards from `deck` with a given `hand_size`.

    ## Example

        iex>deck = Cards.create_deck
        iex>{cards, rest_of_deck} = Cards.deal(deck, 5)
        iex>length(cards)
        5
        iex>length(rest_of_deck)
        51

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
    Saves a deck of cards into a file.

    ## Example

        iex>deck = Cards.create_deck
        iex>Cards.save(deck, "my_deck")
        :ok

  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
    Saves a deck of cards into a file.

    ## Example

        iex>deck = Cards.create_deck
        iex>Cards.save(deck, "my_deck")
        iex>loaded_deck = Cards.load("my_deck")
        iex>deck === loaded_deck
        true

  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That file does not exist."
    end
  end

  @doc """
    Returns a list of string representing a hand of cards with a given `hand_size`.

    ## Example

        iex>{cards, rest_of_deck} = Cards.create_hand(5)
        iex>length(cards)
        5
        iex>length(rest_of_deck)
        51

  """
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
