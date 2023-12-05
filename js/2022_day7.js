const fs = require('fs');
const eol = require('os').EOL;
 
const startTime = new Date().getTime();
let part1 = part2 = time = 0;
let input = fs.readFileSync(__dirname + "/2022-day7.txt", 'utf8').split(eol).map(a => a.split(''));
 
part1 += 4 * input.length - 4
for (let x = 1; x < input.length - 1; x++) {
    for (let y = 1; y < input.length - 1; y++) {
        let [up, down, left, right] = [true, true, true, true]
        for (let z = 0; z < x; z++) {
            if (input[z][y] >= input[x][y]) {
                up = false;
                break;
            }
        }
        for (let z = input.length - 1; z > x; z--) {
            if (input[z][y] >= input[x][y]) {
                down = false;
                break;
            }
        }
        for (let z = 0; z < y; z++) {
            if (input[x][z] >= input[x][y]) {
                left = false;
                break;
            }
        }
        for (let z = input.length - 1; z > y; z--) {
            if (input[x][z] >= input[x][y]) {
                right = false;
                break;
            }
        }
 
        if ([up, down, left, right].includes(t  rue)) part1++;
 
        [up, down, left, right] = [0, 0, 0, 0];
        for (let z = x - 1; z >= 0; z--) {
            up++;
            if (input[z][y] >= input[x][y]) {
                break;
            }
        }
        for (let z = x + 1; z < input.length; z++) {
            down++;
            if (input[z][y] >= input[x][y]) {
                break;
            }
        }
        for (let z = y - 1; z >= 0; z--) {
            left++;
            if (input[x][z] >= input[x][y]) {
                break;
            }
        }
        for (let z = y + 1; z < input.length; z++) {
            right++;
            if (input[x][z] >= input[x][y]) {
                break;
            }
        }
        part2 = Math.max(part2, [up, down, left, right].reduce((a, b) => a * b, 1))
    }
}
 
time = new Date().getTime() - startTime
console.log(`Part 1: ${part1}\nPart 2: ${part2}\nTimer: ${time} ms`);
