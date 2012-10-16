"use strict"

###
  Controllers
###

MainCtrl = ($scope, socket, $location) ->

  # maps
  maps = new Maps 
  maps.show $("#map_canvas")[0]
  maps.address (address)->
    $scope.$apply ->
      $scope.address = address

  # socketio
  socket.emit 'tweet:show', {}
  socket.on 'send:name', (data) ->
    $scope.tweets = data.tweets

  socket.on 'tweet:end', (data) ->
    $scope.tweets = data.tweets

  socket.on 'tweet:me', (data) ->
    $scope.tweets = data.tweets

  # iScroll
  myScroll = new iScroll 'wrapper'

  $scope.tweet = ->
    navigator.geolocation.getCurrentPosition (position) =>
      $scope.$apply ->
        latitude = position.coords.latitude
        longitude = position.coords.longitude
        message = 
                  text: $scope.text
                  latitude: latitude 
                  longitude: longitude
                  name: 'warppy_'

        socket.emit 'tweet', message
        console.log message

        if $scope.text
          $scope.text = ""



    ,(err) ->
      console.log "err: " + err


MainCtrl.$inject = ['$scope', 'socket']

