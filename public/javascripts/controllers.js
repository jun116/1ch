'use strict';

/* Controllers */

function MainCtrl($scope, socket) {
  socket.on('send:name', function (data) {
    $scope.tweets = data.tweets;
  });

}

MainCtrl.$inject =  ['$scope', 'socket'];
