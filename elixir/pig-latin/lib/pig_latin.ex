defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    do_translate(phrase, "")
  end

  defp do_translate(current = <<first::binary-1, rest::binary>>, consonants) do
    cond do
      starts_with_qu?(current) and consonants === "" ->
        <<qu::binary-2, rest::binary>> = current
        rest <> qu <> "ay"
      starts_with_qu?(current) ->
        <<qu::binary-2, rest::binary>> = current
        rest <> consonants <> qu <> "ay"
      starts_with_vowel?(first) and consonants === "" ->
        current <> "ay"
      starts_with_vowel?(first) ->
        current <> consonants <> "ay"
      true ->
        do_translate(rest, consonants <> first)
    end
  end

  defp starts_with_vowel?(string) do
    vowels = for x <- 'aeiou', do: <<x>>
    String.starts_with?(string, vowels)
  end

  defp starts_with_qu?(<<qu::binary-2, _::binary>>) do
    qu === "qu"
  end
end
