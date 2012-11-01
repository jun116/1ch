'use strict'

exports.list = (req, res) ->
  thumnails = [
    {
      thumb: "https://twimg0-a.akamaihd.net/profile_images/2528292277/csi06drgzju434soxunw.jpeg"
    }
    {
      thumb: "https://twimg0-a.akamaihd.net/profile_images/2405480503/black_clover_Z.jpg"
    }
    {
      thumb: "https://twimg0-a.akamaihd.net/profile_images/2503741554/image.jpg"
    }
  ]

  list = JSON.stringify thumnails

  res.send list
