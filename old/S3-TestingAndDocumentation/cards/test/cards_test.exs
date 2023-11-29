defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "greets the world" do
    assert Cards.hello() == "Hello World!"
  end

  test "create_deck makes 52 cards" do
    assert length(Cards.create_deck) === 56
  end

  test "Shuffling a deck randomizes it" do
    deck = Cards.create_deck
    refute Cards.shuffle(deck) === deck
  end
end
