defmodule TreasureHunt.Util do
  @alphabet "123456789abcdefghjkmnpqrstuvwxyzABCDEFGHJKMNPQRSTUVWXYZ"

  def generate_code(length \\ 6) do
    Nanoid.generate(length, @alphabet)
  end
end
