export const solve = (input) =>
{
    var strings = input.split("\n");
    var result;
    var string_a;
    var string_b;
    strings.forEach(element => {
        strings.forEach(item => {
            let difference = 0;
            let i = element.length;
            while(i--){
                if(element.charAt(i) !== item.charAt(i)){
                    difference +=1;
                }
            }
            if(difference === 1){
                string_a = item;
                string_b = element;
                return; 
            }
        })
        if(string_a !== undefined)
            return;
    });
    let i = string_a.length;
    while(i--){
        if(string_a.charAt(i) !== string_b.charAt(i)){
            console.log(string_a.charAt(i));
            console.log(string_a);
             result = string_a.slice(0,i) + string_a.slice(i+1);
             break;
        }
    }
    return result;
    
}