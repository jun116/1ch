"use strict"

###
  Controllers
###

MainCtrl = ($scope, socket) ->

  maps = new Maps $("#map_canvas")[0]
  maps.geolocation()

  socket.on 'send:name', (data) ->
    $scope.tweets = data.tweets;
    return
  return

MainCtrl.$inject = ['$scope', 'socket']
