'use strict'

exports.list = (req, res) ->
  thumnails = [
    {
      thumb: "https://twimg0-a.akamaihd.net/profile_images/2588527924/lsbr4m4drnpsgp2rwgrb.jpeg"
    }
    {
      thumb: "https://twimg0-a.akamaihd.net/profile_images/2588527924/lsbr4m4drnpsgp2rwgrb.jpeg"
    }
    {
      thumb: "https://twimg0-a.akamaihd.net/profile_images/2588527924/lsbr4m4drnpsgp2rwgrb.jpeg"
    }
    {
      thumb: "https://twimg0-a.akamaihd.net/profile_images/2588527924/lsbr4m4drnpsgp2rwgrb.jpeg"
    }
    {
      thumb: "https://twimg0-a.akamaihd.net/profile_images/2588527924/lsbr4m4drnpsgp2rwgrb.jpeg"
    }
    {
      thumb: "https://twimg0-a.akamaihd.net/profile_images/2588527924/lsbr4m4drnpsgp2rwgrb.jpeg"
    }
  ]

  list = JSON.stringify thumnails

  res.send list
