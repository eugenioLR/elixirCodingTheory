defmodule CodingLib.Utils do
  def avg(l) do
    Enum.sum(l) / length(l)
  end

  def argmax(l) do
    argmax_rec(l |> tl, l |> hd, 1, 0)
  end

  defp argmax_rec(l, prev_elem, curr_idx, best_idx) do
    cond do
      l == [] -> best_idx
      hd(l) > prev_elem -> argmax_rec(l |> tl, l |> hd, curr_idx + 1, curr_idx)
      true -> argmax_rec(l |> tl, l |> hd, curr_idx + 1, best_idx)
    end
  end

  def argmin(l) do
    argmin_rec(l |> tl, l |> hd, 1, 0)
  end

  defp argmin_rec(l, prev_elem, curr_idx, best_idx) do
    cond do
      l == [] -> best_idx
      hd(l) < prev_elem -> argmin_rec(l |> tl, l |> hd, curr_idx + 1, curr_idx)
      true -> argmin_rec(l |> tl, l |> hd, curr_idx + 1, best_idx)
    end
  end

  def argsort(l, sorter \\ :asc) do
    Enum.sort_by(0..(length(l) - 1), &Enum.at(l, &1), sorter)
  end

  def starts_with?(u, v) do
    starts_with_rec(u |> String.graphemes(), v |> String.graphemes())
  end

  defp starts_with_rec([u_head | u_tail], [v_head | v_tail]) do
    cond do
      u_tail == [] -> u_head == v_head
      v_tail == [] -> false
      true -> u_head == v_head and starts_with_rec(u_tail, v_tail)
    end
  end
end
