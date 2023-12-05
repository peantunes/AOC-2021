var day7 = require('./2022_day7.js');

fs = require('fs');
fs.readFile('2022-day7.txt', 'utf8', function (err,data) {
  if (err) {
    return console.log(err);
  }
  //console.log(data);
  console.log(day7.part1(data))
  console.log(day7.part2(data))
});