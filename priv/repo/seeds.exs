# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     LifeTools.Repo.insert!(%LifeTools.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

tv_seed_data = [
  19885,
  88396,
  60735,
  67136,
  65820,
  32726,
  84958,     # Loki
  61457,     # Grantchester
  46952,     # The Blacklist
  69478      # The Handmaid's Tale
]

Enum.each(tv_seed_data, fn show_id ->
  TMDB.add_show(show_id)
end)