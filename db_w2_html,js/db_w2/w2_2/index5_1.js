const allForm = document.querySelector("#enter");
const guessInput = document.querySelector("#guess input");
const youChosen = document.querySelector("#choose span:first-child");
const machineChosen = document.querySelector("#choose span:last-child");
const result = document.querySelector("#result");

function genRandom(min, max) {
	const ranNum = Math.floor(Math.random() * (max - min + 1) + min);
	return ranNum;
}

function buttonClick(event) {
	event.preventDefault();

	let max = document.getElementById("max").value;
	const guessInputNumber = Number(guessInput.value);
	const randomNumber = genRandom(0, max);

	youChosen.innerText = `You chose:${guessInputNumber}`;
	machineChosen.innerText = `, machine chose: ${randomNumber}`;

	if (guessInputNumber === randomNumber) {
		result.innerText = "You won!";
	} else {
		result.innerText = "You lost!";
	}
}

allForm.addEventListener("submit", buttonClick);