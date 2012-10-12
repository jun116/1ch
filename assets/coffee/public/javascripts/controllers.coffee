"use strict"

###
  Controllers
###

MainCtrl = ($scope, socket) ->

  maps = new Maps $("#map_canvas")[0]
  maps.geolocation()

  socket.emit 'tweet:show', {}

  socket.on 'send:name', (data) ->
    $scope.tweets = data.tweets

MainCtrl.$inject = ['$scope', 'socket']

TweetCtrl = ($scope, socket) ->

  $scope.tweet = ->
    navigator.geolocation.getCurrentPosition (position)=>
      latitude = position.coords.latitude
      longitude = position.coords.longitude
      message = 
                text: @text
                latitude: latitude 
                longitude: longitude
                name: 'warppy_'

      socket.emit 'tweet', message

      console.log message
      if @text
        @text = ''
    ,(err) ->
      console.log "err: " + err
    , {
      maximumAge: '0'
    }

  socket.on 'tweet:end', (data) ->
#    $location.path('/#');
  