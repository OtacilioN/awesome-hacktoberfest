<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie-edge">
    <title>Forms</title>
</head>

<body>
    <h2>This is HTML Forms tutorial</h2>
    <form action="backend.php">
        <label for="name">Name</label>
        <div>
            <input type="text" name="myName" id="name">
        </div>
        <br>
        <div>
            Role <input type="text" name="myRole">
        </div>
        <br>
        <div>
            Email: <input type="email" name="myEmail">
        </div>
        <br>
        <br>
        <div>
            <input type="date" name="myDate">
        </div>
        <br>
        <div>
            Bonus: <input type="number" name="myBonus">
        </div>
        <br>
        <div>
            Are you Eligible: <input type="checkbox" name="myEligibility" checked>
        </div>
        <br>
        <div>
            Gender: Male<input type="radio" name="myGender">Female<input type="radio" name="myGender">
            Other <input type="radio" name="myGender">
        </div>
        <br>
        <div>
            Write about yourself <br><textarea name="myText" cols="50" rows="10"></textarea>
        </div>
        <div>
            <label for="car">Car</label>
            <select name="myCar" id="car">
                <option value="ind">Indica</option>
                <option value="swft" selected>Swift</option>
            </select>

        </div>
        <br>

        <div>
            <input type="submit" value="Submit Now">
            <input type="reset" value="Reset Now">
        </div>


    </form>

</body>

</html>
