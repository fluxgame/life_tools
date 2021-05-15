defmodule LifeTools.Scheduler do
  use Quantum, otp_app: :life_tools

  def daily_tasks do
    LifeTools.TheMovieDatabase.update_shows
    Ecto.Adapters.SQL.query(LifeTools.Repo, "update tasks set today = false;")
    Ecto.Adapters.SQL.query(LifeTools.Repo, "update tasks set today = true where start_date = current_date")
  end
end
