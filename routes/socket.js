module.exports = function (socket) {
  socket.emit('send:name', {
    tweets: [
              { name: 'fucker',
                icon: 'https://twimg0-a.akamaihd.net/profile_images/2588527924/lsbr4m4drnpsgp2rwgrb.jpeg',
                message: 'ヨドバシ前に200人の行列が！？\nなにこれw',
                time: '2012/09/12 13:33:43.000',
              },
              { name: 'rickie',
                icon: 'https://twimg0-a.akamaihd.net/profile_images/1329742549/raou.jpg',
                message: 'ラーメン、ももか、北斗！',
                time: '2012/09/11 11:47:00.000',
              },
              { name: '名無し',
                icon: 'https://twimg0-a.akamaihd.net/profile_images/2009745702/319837_106416419490365_100003660222269_30449_12187083_n.jpeg',
                message: 'れに、かなこぉー、しおり、あやか、ももか',
                time: '2012/09/10 09:12:12.000',
              },
            ]
  });

};
