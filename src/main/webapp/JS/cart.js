function changeQuantity(amount) {
    let input = document.getElementById("quantity");
    let value = parseInt(input.value) || 1;
    value += amount;
    if(value<1) value = 1;
    input.value = value;
}