'use strict'

###
  Services
###

angular.module('1chServices', []).
  factory 'socket', ($rootScope, $http) ->
    socket = io.connect()

    on: (eventName, callback) ->
      socket.on eventName, ->
        args = arguments
        $rootScope.$apply ->
          callback.apply socket, args

    emit: (eventName, data, callback) ->
      socket.emit eventName, data, ->
        args = arguments
        $rootScope.$apply ->
          if callback
            callback.apply socket, args

    thumb: (callback) ->
      $http({method: 'GET', url: '/api/thumblist'})
        .success (data) ->
          callback data
        .error (data) ->
          throw data
