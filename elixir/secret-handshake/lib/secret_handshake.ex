defmodule SecretHandshake do
  use Bitwise, only_operators: true

  @actions %{
    1 => "wink",
    2 => "double blink",
    4 => "close your eyes",
    8 => "jump"
  }

  defguardp is_action_in_code(code, action) when (code &&& action) === action
  defguardp is_reverse(code) when (code &&& 16) === 16

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    action_codes = @actions |> Map.keys() |> Enum.sort()
    do_commands(code, action_codes, [])
  end

  defp do_commands(code, [], commands) when not is_reverse(code), do: Enum.reverse(commands)
  defp do_commands(_code, [], commands), do: commands

  defp do_commands(code, [action | actions], commands) when is_action_in_code(code, action) do
    do_commands(code, actions, [@actions[action] | commands])
  end

  defp do_commands(code, [_action | actions], commands), do: do_commands(code, actions, commands)

end
