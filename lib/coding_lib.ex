defmodule CodingLib do
  def main() do
    codes = ["00", "001", "0011", "00111", "1111"]

    IO.puts("Code:")
    IO.inspect(codes)

    IO.puts(nil)
    IO.puts("C_inf:")
    IO.inspect(CodingLib.Analysis.generate_cinf(codes))

    IO.puts(nil)
    IO.puts("Is uniquely decodable:")
    IO.inspect(CodingLib.Analysis.sardinas_patterson(codes))

    IO.puts(nil)
    IO.puts("Huffman code:")
    IO.inspect(CodingLib.Generator.huffman_code([1, 1, 1]))

    :ok
  end
end
