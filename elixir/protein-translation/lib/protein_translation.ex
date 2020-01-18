defmodule ProteinTranslation do
  @decode_protein %{
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UGG" => "Tryptophan",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    case result = translate(rna, []) do
      {:error, _} -> result
      _ -> {:ok, result}
    end
  end

  defp translate(<<>>, proteins), do: Enum.reverse(proteins)
  defp translate(<<codon::binary-3, rest::binary>>, proteins) do
    case of_codon(codon) do
      {:ok, "STOP"} -> Enum.reverse(proteins)
      {:ok, protein} -> translate(rest, [protein | proteins])
      error -> error
    end
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) when byte_size(codon) !== 3 do
    {:error, "invalid codon"}
  end
  def of_codon(codon) do
    case @decode_protein[codon] do
      nil -> {:error, "invalid RNA"}
      protein -> {:ok, protein}
    end
  end

end
