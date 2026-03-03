     function Print(container,tag, text) {
            document.getElementById(Print.arguments[0]).innerHTML = "<" + tag + ">" + text + "</" + tag + ">"
            //document.write("<" + tag + ">" + text + "</" + tag + ">");
        }


          
        function Factorial(Number)
        {
            if(Number<1)
            return 0;
            if(Number==1)
                return 1;
            else 
                return Number * Factorial(Number-1);
        }


        function GetNumber(input)
        {
            var s  = document.getElementById(input).value;
            return Factorial(s);
        } 

         function ShowResult(result , traget)
         {
              document.getElementById(traget).innerText = result;
         }

         var EmployeeSalary =function(salary ,bouns){
             return salary + bouns;
         }


         function ShowResult2(traget)
         {
            try{
                if(traget =="")throw"Empty parameter";
                 document.getElementById(traget).innerText =  EmployeeSalary(20000,2000);
            }              
            catch (exception) {
              if (exception == "Empty parameter")
             console.log("Can not enter Empty Tag");
            }
         }