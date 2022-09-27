const maxNum = document.querySelector("#js-range");
const chooseNum = document.getElementById("chooseNumber");
const resultform = document.getElementById("js-guess");
const displayRange = document.querySelector("#js-title");
const displayResult = document.querySelector("#js-result");

const getRand = (max) => {
    const rn = Math.floor((Math.random() * (max - 5 + 1) + 5) / 5) * 5;
    return rn;
}
const getRes = (yc, mc) => {
    if (yc == mc) {
        return "you won!";
    }
    else {
        return "you lost!";
    }
}
const rangeEdit = (e) => {
    //alert('hello2');
    const mn = maxNum.value;
    const displaySpan1 = displayRange.querySelector("span");
    displaySpan1.innerHTML = `
    ${mn}`;
}
const guess = (e) => {
    e.preventDefault();
    const yc = chooseNum.value;
    const mc = getRand(maxNum.value);
    const cmpRes = getRes(yc, mc);
    const displaySpan = displayResult.querySelector("span");
    displaySpan.innerHTML =`
    you choose: ${yc} machine choose: ${mc} <br>${cmpRes}<br>`;
}

resultform.addEventListener("submit", guess);