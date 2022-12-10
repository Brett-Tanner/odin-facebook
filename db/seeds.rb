User.destroy_all

User.create([
  {
    name: "Aang",
    username: "100yearoldkid",
    gender: "Male",
    birthday: "1922-12-1",
    email: "da_avatar@hawky.com",
    password: "earthwaterfireair"
  }, 
  {
    name: "Katara",
    username: "bloodISwater",
    gender: "Female",
    birthday: "2008-12-1",
    email: "female_master@hawky.com",
    password: "sokkashairsux"
  },
  {
    name: "Sokka",
    username: "boomerangboi",
    gender: "Male",
    birthday: "2005-12-1",
    email: "swordmaster@hawky.com",
    password: "ikissedthemoon"
  },
  {
    name: "Toph",
    username: "blindbandit",
    gender: "Female",
    birthday: "2012-12-1",
    email: "greatest_earthbender_alive@hawky.com",
    password: "rocksrockingrock"
  },
  {
    name: "Zuko",
    username: "hizukohere",
    gender: "Male",
    birthday: "2004-12-1",
    email: "myfamilyis_crazy@hawky.com",
    password: "myhonourrrrrrrr"
  },
  {
    name: "Suki",
    username: "myboyfriendfearsme",
    gender: "Female",
    birthday: "2005-11-30",
    email: "kyoshi_warrior01@hawky.com",
    password: "sokkasbiggestfan"
  },
  {
    name: "Appa",
    username: "MVP",
    gender: "Prefer not to say",
    birthday: "1922-12-1",
    email: "avatar_carrier@hawky.com",
    password: "aaarooooggahhhhhhhh"
  },
  {
    name: "Azula",
    username: "future_fire_lord",
    gender: "Female",
    birthday: "2006-12-1",
    email: "number_one_child_02@fire_navy.com",
    password: "bowbeforemeelectricity"
  }
])

puts 'Sign the gaang up'