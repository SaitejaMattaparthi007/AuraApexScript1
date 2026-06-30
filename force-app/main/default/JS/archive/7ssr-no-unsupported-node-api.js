// valid
if (!import.meta.env.SSR) {
    const fs = require('node:fs');
    fs.writeFileSync('file.txt', 'data');
}


// invalid
const fs = require('fs');

// the unsupported Node API call
fs.writeFileSync('file.txt', 'data');