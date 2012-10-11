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
    socket.emit 'tweet', { test: this.msg }
    if this.msg
      this.msg = ''

  socket.on 'tweet:end', (data) ->
#    $location.path('/#');
