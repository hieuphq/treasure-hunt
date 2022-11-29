# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TreasureHunt.Repo.insert!(%TreasureHunt.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

loc_hcm =
  TreasureHunt.Repo.insert!(%TreasureHunt.Core.Location{
    address: "200, Ba tháng hai, quận 10, Hồ Chí Minh",
    name: "DF HCM",
    plus_code: "7P28QMGH+45"
  })

loc_dalat =
  TreasureHunt.Repo.insert!(%TreasureHunt.Core.Location{
    address: "2 Đường Khởi Nghĩa Bắc Sơn, Phường 10, Thành phố Đà Lạt",
    name: "DF Đà lạt",
    plus_code: "7P3CWCMX+449"
  })

q1 =
  TreasureHunt.Repo.insert!(%TreasureHunt.Core.Question{
    content: "What Does K8s Mean?",
    answer: "kubernetes"
  })

q2 =
  TreasureHunt.Repo.insert!(%TreasureHunt.Core.Question{
    content: "What Does evm mean?",
    answer: "Ethereum Virtual Machine"
  })

q3 =
  TreasureHunt.Repo.insert!(%TreasureHunt.Core.Question{
    content: "What type for float in typescript?",
    answer: "Number"
  })

q4 =
  TreasureHunt.Repo.insert!(%TreasureHunt.Core.Question{
    content: "What type for integer in typescript?",
    answer: "Number"
  })

t =
  TreasureHunt.Repo.insert!(%TreasureHunt.Core.Team{
    name: "1"
  })

TreasureHunt.Repo.insert!(%TreasureHunt.Core.Clue{
  location_id: loc_hcm.id,
  question_id: q1.id,
  team_id: t.id,
  done_at: nil,
  sort: 1,
  status: "new"
})

TreasureHunt.Repo.insert!(%TreasureHunt.Core.Clue{
  location_id: loc_dalat.id,
  question_id: q2.id,
  team_id: t.id,
  done_at: nil,
  sort: 2,
  status: "new"
})

TreasureHunt.Repo.insert!(%TreasureHunt.Core.Clue{
  location_id: loc_hcm.id,
  question_id: q3.id,
  team_id: t.id,
  done_at: nil,
  sort: 3,
  status: "new"
})

TreasureHunt.Repo.insert!(%TreasureHunt.Core.Clue{
  location_id: loc_dalat.id,
  question_id: q4.id,
  team_id: t.id,
  done_at: nil,
  sort: 4,
  status: "new"
})
