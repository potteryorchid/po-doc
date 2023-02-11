rs.initiate({
  _id: "rs0",
  members: [
    {
      _id: 0,
      host: "localhost:27027",
      priority: 1
    },
    {
      _id: 1,
      host: "localhost:27028",
      priority: 2
    },
    {
      _id: 2,
      host: "localhost:27029",
      arbiterOnly: true
    }
  ]
})

rs.status()