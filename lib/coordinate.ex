defmodule IslandsEngine.Coordinate do
  defstruct in_island: :none, guessed?: false 

  alias IslandsEngine.Coordinate

  def start_link do
    Agent.start_link(fn -> %Coordinate{} end)
  end

  def guessed?(coord) do
    Agent.get(coord, fn state -> state.guessed? end)
  end

  def guess(coord) do
    Agent.update(coord, fn state -> Map.put(state, :guessed?, true) end)
  end

  def island(coord) do
    Agent.get(coord, fn state -> state.in_island end)
  end

  def in_island?(coord) do
    case island(coord) do
      :none -> false
      _     -> true
    end
  end
  
  def hit?(coord) do
    in_island?(coord) && guessed?(coord)
  end

  def set_in_island(coordinate, value) when is_atom value do
    Agent.update(coordinate, fn state -> Map.put(state, :in_island, value) end)
  end

  def to_string(coord) do
    "(in_island: #{island(coord)}, guessed: #{guessed?(coord)})"
  end

end

