'use strict'

exports.list = (req, res) ->
  thumnails = [
    {
      thumb: "https://twimg0-a.akamaihd.net/profile_images/2528292277/csi06drgzju434soxunw.jpeg"
    }
    {
      thumb: "https://si0.twimg.com/profile_images/1646597963/F5901D31-DD70-4278-B065-8033ADF9FFED"
    }
    {
      thumb: "https://twimg0-a.akamaihd.net/profile_images/2503741554/image.jpg"
    }
    {
      thumb: "https://si0.twimg.com/profile_images/2721287444/4a0e6a8de0b9d11ac9403f0ef4a38156.jpeg"
    }
    {
      thumb: "https://si0.twimg.com/profile_images/2673152046/2253407b05a6d972e4daf3c4938d4ceb.jpeg"
    }    
  ]

  list = JSON.stringify thumnails

  res.send list
