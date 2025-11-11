/*eslint no-irregular-whitespace: "error"*/

function thing()&nbsp;/*<NBSP>*/{
    return 'test';
}

function thing(&nbsp;/*<NBSP>*/){
    return 'test';
}

function thing&nbsp;/*<NBSP>*/(){
    return 'test';
}

function thing᠎/*<MVS>*/(){
    return 'test';
}

function thing() {
    return 'test'; /*<ENSP>*/
}

function thing() {
    return 'test';&nbsp;/*<NBSP>*/
}

function thing() {
    // Description&nbsp;<NBSP>: some descriptive text
}

/*
Description&nbsp;<NBSP>: some descriptive text
*/

function thing() {
    return /&nbsp;<NBSP>regexp/;
}

/*eslint-env es6*/
function thing() {
    return `template <NBSP>string`;
}
