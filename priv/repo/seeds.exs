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

alias LifeTools.Projects.Project
alias LifeTools.Tasks.Task
alias LifeTools.Tasks.Depend
alias LifeTools.Repo

project =
  %Project{name: "Life Tools", context: "personal"}
  |> Repo.insert!()

%Task{
  description: "TV Shows Module",
  completion_date: ~D[2021-04-21],
  project_id: project.id
}
|> Repo.insert!()

%Task{
  description: "Nutrition Module",
  project_id: project.id
}
|> Repo.insert!()

authent =
  %Task{
    description: "Authentication",
    project_id: project.id
  }
  |> Repo.insert!()

docker =
  %Task{
    description: "Docker Setup",
    project_id: project.id
  }
  |> Repo.insert!()

%Task{
  description: "GTD Module",
  project_id: project.id
}
|> Repo.insert!()

deploy =
  %Task{
    description: "Deploy to AWS",
    project_id: project.id
  }
  |> Repo.insert!()

%Depend{
  task_id: deploy.id,
  depend_id: authent.id
}
|> Repo.insert!()

%Depend{
  task_id: deploy.id,
  depend_id: docker.id
}
|> Repo.insert!()

tv_seed_data = [
  # Sherlock
  19885,
  # The Falcon and the Winter Soldier
  88396,
  # The Flash
  60735,
  # This Is Us
  67136,
  # Van Helsing
  65820,
  # Bob's Burgers
  32726,
  # Clarice
  103_302,
  # Loki
  84958,
  # The Blacklist
  46952,
  # Atlantic Crossing
  96919,
  # The Nevers
  80828,
  # Last Week Tonight
  60694,
  # Shadow and Bone
  85720,
  # What If...?
  91363,
  # Grantchester
  61457,
  # Foundation
  93740,
  # Ms. Marvel
  92782,
  # Hawkeye
  88329,
  # Endeavour
  44264,
  # The Book of Boba Fett
  115_036,
  # Star Trek: Lower Decks
  85948,
  # Lost in Space
  75758,
  # Sex Education
  81356,
  # Insecure
  67883,
  # Call the Midwife
  39793,
  # Dune: The Sisterhood
  90228,
  # Obi-Wan Kenobi
  92830,
  # Space Force
  85922,
  # The Wheel of Time
  71914,
  # See
  80752,
  # The Sandman
  90802,
  # Carnival Row
  90027,
  # Jack Ryan
  73375,
  # The Lord of the Rings
  84773,
  # Star Trek: Picard
  85949,
  # Stranger Things
  66732,
  # Westworld
  63247,
  # Perry Mason
  85853,
  # The Umbrella Academy
  75006,
  # The Witcher
  71912,
  # Ozark
  69740,
  # Avenue 5
  90811,
  # Better Call Saul
  60059,
  # The Last Kingdom
  63333,
  # World on Fire
  83015,
  # Killing Eve
  72750,
  # Van der Valk
  97085,
  # The Boys
  76479,
  # Star Trek: Discovery
  67198,
  # The Expanse
  63639,
  # Kingdom
  70593,
  # All Creatures Great and Small
  108_255,
  # She-Hulk
  92783,
  # His Dark Materials
  68507,
  # House of the Dragon
  94997,
  # Black Mirror
  42009,
  # Raised by Wolves
  85723,
  # The Mandalorian
  82856,
  # The Crown
  65494,
  # Mindhunter
  67744,
  # Cursed
  83125,
  # Trackers
  94923,
  # Lovecraft Country
  82816,
  # Roadkill
  111_573,
  # The Watch
  94235,
  # WandaVision
  85271,
  # American Gods
  46639,
  # The Chronicles of Narnia
  114_377,
  # Moon Knight
  92749,
  # The Handmaid's Tale
  69478
]

# Enum.each(tv_seed_data, fn show_id ->
#   LifeTools.TheMovieDatabase.add_show(show_id)
# end)
