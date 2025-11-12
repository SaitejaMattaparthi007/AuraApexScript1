/*eslint no-irregular-whitespace: "error"*/

// Example 1 – Non-breaking space (\u00A0)
function exampleOne() { // <-- contains NBSP between ")" and "{"
    return 'Invalid whitespace detected';
}

// Example 2 – En space (\u2002)
function exampleTwo() { // <-- contains EN SPACE between ")" and "{"
    console.log('This line has irregular whitespace');
}

// Example 3 – Zero width space (\u200B)
function exampleThree() {​ // <-- Zero width space before comment
    return 'Zero width space issue';
}

// Example 4 – NBSP inside expression
function exampleFour() {
    let x = 10; // <-- multiple NBSP characters between tokens
    return x;
}
