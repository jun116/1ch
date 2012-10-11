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
    navigator.geolocation.watchPosition @watchSuccess, @watchFail
    return

  socket.on 'tweet:end', (data) ->
#    $location.path('/#');
  
  watchSuccess = (position)->
      latitude = position.coords.latitude
      longitude = position.coords.longitude
      message = 
                text: this.text
                latitude: latitude 
                longitude: longitude
                name: 'warppy_'

      socket.emit 'tweet', message

      console.log message
      if this.text
        this.text = ''

  watchFail = (err) ->
    console.log err
