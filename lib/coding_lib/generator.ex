defmodule CodingLib.Generator do
  import CodingLib.Utils

  def huffman_code(prob) do
    prob_sum = Enum.sum(prob)
    prob_fixed = if prob_sum == 1, do: prob, else: Enum.map(prob, &(&1 / prob_sum))
    huffman_code_rec(prob_fixed)
  end

  defp huffman_code_rec(prob) do
    symbols_left =
      prob
      |> Enum.filter(&(&1 != nil))
      |> Enum.count()

    if symbols_left == 1 do
      one_idx = Enum.find_index(prob, &(&1 != nil))

      List.duplicate(nil, length(prob))
      |> List.replace_at(one_idx, "")
    else
      [fst_idx, snd_idx] = argsort(prob, :asc) |> Enum.take(2)

      new_probs =
        prob
        |> List.replace_at(fst_idx, Enum.at(prob, fst_idx) + Enum.at(prob, snd_idx))
        |> List.replace_at(snd_idx, nil)

      next_codes = huffman_code_rec(new_probs)

      next_codes
      |> List.replace_at(fst_idx, Enum.at(next_codes, fst_idx) <> "0")
      |> List.replace_at(snd_idx, Enum.at(next_codes, fst_idx) <> "1")
    end
  end
end
