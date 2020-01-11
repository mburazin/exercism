defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    shift = rem(shift, 26)

    to_charlist(text)
    |> Enum.map(&(rotate_one(&1, shift)))
    |> to_string()
  end

  defguardp is_lowercase(c) when c in ?a..?z
  defguardp is_uppercase(c) when c in ?A..?Z
  defguardp is_letter(c) when is_lowercase(c) or is_uppercase(c)

  defp rotate_one(char, shift) when is_lowercase(char) and (char + shift) > ?z do
    ?a + rem(char + shift, ?z) - 1
  end

  defp rotate_one(char, shift) when is_uppercase(char) and (char + shift) > ?Z do
    ?A + rem(char + shift, ?Z) - 1
  end

  defp rotate_one(char, shift) when is_letter(char) do
    char + shift
  end

  defp rotate_one(char, _) do
    char
  end
end
