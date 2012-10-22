'use strict'

exports.list = (req, res) ->
  thumnails = [
    {
      thumb: "https://twimg0-a.akamaihd.net/profile_images/2588527924/lsbr4m4drnpsgp2rwgrb.jpeg"
    }
    {
      thumb: "https://twimg0-a.akamaihd.net/profile_images/2528292277/csi06drgzju434soxunw.jpeg"
    }
    {
      thumb: "https://twimg0-a.akamaihd.net/profile_images/2720669747/47acd03c1c879dcdeac3366befe88258.jpeg"
    }
    {
      thumb: "https://twimg0-a.akamaihd.net/profile_images/2405480503/black_clover_Z.jpg"
    }
    {
      thumb: "https://twimg0-a.akamaihd.net/profile_images/2503741554/image.jpg"
    }
    {
      thumb: "https://twimg0-a.akamaihd.net/profile_images/1257564422/301.jpg"
    }
  ]

  list = JSON.stringify thumnails

  res.send list
