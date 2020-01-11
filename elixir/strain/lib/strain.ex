defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun) do
    filter(list, fun, [])
  end


  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
    filter(list, &(!fun.(&1)), [])
  end

  defp filter([], _, result) do
    Enum.reverse(result)
  end

  defp filter([head | tail], fun, result) do
    if fun.(head) do
      filter(tail, fun, [head | result])
    else
      filter(tail, fun, result)
    end
  end
end
