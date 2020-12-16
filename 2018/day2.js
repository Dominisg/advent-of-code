export const solve = (input) =>
{
    
    var strings = input.split("\n");
    var answer_three = 0;
    var answer_two = 0;
    strings.forEach(element => {
        let dict = {};
        let three = 0;
        let two = 0;
        var i = element.length;
        while (i--) {
            
            if(dict.hasOwnProperty(element.charAt(i))){
                dict[element.charAt(i)] += 1;
            }
            else{
                dict[element.charAt(i)] = 1;
            }
        }
           for(let item in dict)
            {
            console.log(item);
            if(dict[item] === 3 && three === 0)
                three++;
            if(dict[item] === 2 && two === 0)
                two++;
            
            }
            if(three == 1)
                answer_three++;
            if(two == 1)
                answer_two++;

        
    });
    return answer_two*answer_three;
    
}
