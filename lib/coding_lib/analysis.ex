defmodule CodingLib.Analysis do
  import CodingLib.Utils

  def code_efficiency(code, prob) do
    entropy(prob) / expected_length(code, prob)
  end

  def entropy(prob) do
    prob
    |> Enum.map(&(-&1 * Math.log2(&1)))
    |> Enum.sum()
  end

  def expected_length(codes, prob) do
    Enum.zip(codes, prob)
    |> Enum.map(fn {x, y} -> String.length(x) * y end)
    |> Enum.sum()
  end

  def is_instantaneous?(codes) do
    0..(length(codes) - 1)
    |> Enum.map(fn x ->
      {elem, other} = List.pop_at(codes, x)
      Enum.map(other, &starts_with?(elem, &1))
    end)
    |> List.flatten()
    |> Enum.member?(true)
    |> then(&(not &1))
  end

  def is_decodable?(codes) do
    sardinas_patterson(codes)
  end

  def sardinas_patterson(codes) do
    cinf = generate_cinf(codes)
    not Enum.member?(for(i <- codes, do: MapSet.member?(cinf, i)), true)
  end

  def generate_cinf(codes) do
    generate_cinf_rec(codes, MapSet.new(), 1)
  end

  defp generate_cinf_rec(codes, currSet, n) do
    c_n_set = generate_cn(codes, n)

    if currSet == c_n_set do
      currSet
    else
      MapSet.union(currSet, generate_cinf_rec(codes, c_n_set, n + 1))
    end
  end

  def generate_cn(codes, n) do
    if n == 0 do
      MapSet.new(codes)
    else
      codes_prev = generate_cn(codes, n - 1)

      MapSet.new()
      |> MapSet.union(
        MapSet.new(
          Enum.filter(
            List.flatten(
              for u <- codes_prev do
                for v <- codes_prev do
                  if String.length(u) > String.length(v) and starts_with?(u, v) do
                    String.slice(u, String.length(v)..-1)
                  end
                end
              end
            ),
            &(&1 != nil and &1 != "")
          )
        )
      )
    end
  end
end
