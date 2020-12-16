export const solve = (input) => {
    let numbers = input.split(/\n/)
    let results = new Set(); 
    var sum = 0;
    var i = 0
    while(true)
    {
        sum += parseInt(numbers[i]);   
        if(results.has(sum) === true ){
            return sum;
        }
        results.add(sum);
        console.log(sum);
        i++
        if(i === numbers.length)
            i=0;
    }
};

