type point : record
    x : int
    y : int
end record

type rectangle : record
    bl : point
    tr : point
    name : string (4)  
end record

var rects : array 1 .. 25 of rectangle

var numRects : int := 0


%Initializing stuff because it makes my life easier%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i : 1 .. 25
    rects (i).bl.x := 1000
    rects (i).bl.y := 1000
    rects (i).tr.x := 1000
    rects (i).tr.y := 1000
    rects (i).name := "0"
end for


%Putting rectangles to the screen%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
proc putRect
    cls
    for i : 1 .. numRects
        put intstr(i) + ")  " + intstr(rects (i).bl.x) + "," + intstr(rects (i).bl.y) + "  " + intstr(rects (i).tr.x) + "," + intstr(rects (i).tr.y) + "  " + rects (i).name
    end for
end putRect



%Generating Rectangles%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
proc rectGen

    %Resetting the array
    for i : 1 .. 25
        rects (i).bl.x := 1000
        rects (i).bl.y := 1000
        rects (i).tr.x := 1000
        rects (i).tr.y := 1000
        rects (i).name := "0"
    end for

    %Getting the desired number of rectangles from the user
    var tempChar : char
    loop
        put "Enter the number of rectangles you'd like to generate: "..
        get numRects
        if numRects < 0 or numRects > 25 then
            put "Invalid number of retangles. "..
        else
            exit
        end if
    end loop
    
    %Generating rectangle coordinates
    if numRects > 0 then
        for i : 1 .. numRects
            loop
                rects (i).bl.x := Rand.Int (0, 800)
                rects (i).bl.y := Rand.Int (0, 600)
                rects (i).tr.x := Rand.Int (0, 800)
                rects (i).tr.y := Rand.Int (0, 600)
                if rects (i).bl.x > rects (i).tr.x or rects (i).bl.y > rects (i).tr.y then
                    rects (i).bl.x := Rand.Int (0, 800)
                    rects (i).bl.y := Rand.Int (0, 600)
                    rects (i).tr.x := Rand.Int (0, 800)
                    rects (i).tr.y := Rand.Int (0, 600)
                else
                    exit
                end if
            end loop
            
            %Generating rectangle names 
            for j : 1 .. 4
                tempChar := chr (Rand.Int(97,122))
                if j = 1 then
                    rects (i).name := tempChar
                else
                    rects (i).name += tempChar
                end if
            end for
        end for
        for i : 1 .. (numRects - 1)
            loop
                if rects (i).name = rects (i+1).name then
                    for j : 1 .. 4
                        tempChar := chr (Rand.Int(97,122))
                        if j = 1 then
                            rects (i).name := tempChar
                        else
                            rects (i).name += tempChar
                        end if
                    end for
                else
                    exit
                end if
            end loop
        end for     
    end if
end rectGen



%Adding a Rectangle%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
proc addRect
    var proofString : string
    var exitvar : array 1 .. 4 of boolean
    
    if numRects < 25 then
    for i : 1 .. 25
        if rects(i).name = "0" then
            numRects += 1
            loop
                put "Enter x vlaue for lower left:"..
                get rects (i).bl.x
                if rects (i).bl.x > 800 then
                    put "Value not valid. "..
                else
                    exit
                end if
            end loop
            loop
                put "Enter y vlaue for lower left:"..
                get rects (i).bl.y
                if rects (i).bl.y > 600 then
                    put "Value not valid. "..
                else
                    exit
                end if
            end loop
            loop
                put "Enter x vlaue for top right:"..
                get rects (i).tr.x
                if rects (i).tr.x > 800 or rects (i).tr.x < rects (i).bl.x then
                    put "Value not valid. "..
                else
                    exit
                end if
            end loop
            loop
                put "Enter y vlaue for top right:"..
                get rects (i).tr.y
                if rects (i).tr.y > 800 or rects (i).tr.y < rects (i).bl.y then
                    put "Value not valid. "..
                else
                    exit
                end if
            end loop
            put "Enter name of new rectangle. If entered string is greater than four characters, the first four characters will be used."
            loop
                get proofString
                for j : 1 .. 4
                    if ord(proofString (j)) > 122 or ord(proofString (j)) < 97 then
                        put "Invalid name; all characters must be lower case letters."
                    else
                        exitvar(j) := true
                    end if
                end for
                exit when exitvar(1) = true and exitvar(2) = true and exitvar(3) = true and exitvar(4) = true
            end loop
            for j : 1 .. 4    
                if j = 1 then
                    rects (i).name := proofString (j)
                else
                    rects (i).name += proofString (j)
                end if
            end for
            exit
        end if
    end for
    else
        put "Maximum number of rectangles already exist."
        delay (3000)
    end if
end addRect



%Rectangle Delete Function%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
proc delRect
    var badRect : string (4)
    var tempRect : rectangle
    var valid : boolean := false
    put "Which rectangle would you like to delete?"
    get badRect
    for i : 1 .. numRects
        if rects(i).name = badRect then
            rects (i).bl.x := 1000
            rects (i).bl.y := 1000
            rects (i).tr.x := 1000
            rects (i).tr.y := 1000
            rects (i).name := "0"
            numRects -= 1
            valid := true
        end if
        if i not= 25 and rects(i+1).name not= "0" and valid then
           tempRect := rects(i+1)
           rects(i+1) := rects(i)
           rects(i) := tempRect
        elsif valid and i = 25 or valid and rects(i+1).name = "0" then 
            exit
        end if
    end for
    if not valid then
        put "Name not valid"
        delay(3000)
    end if
end delRect



%Rectangle Intersection Checker%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
proc rectIn

end rectIn



%Rectangle Unity Creator%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
proc rectUn

end rectUn



%Alphabetical Sorting%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
proc aSort
    var tempRect : rectangle
    for q : 1 .. numRects
    %put "q=" + intstr (q)
        for i : 1 .. (numRects - 1)
        %put "i=" + intstr (i)
            if rects(i).name > rects(i+1).name then
                tempRect := rects(i+1)
                rects(i+1) := rects(i)
                rects(i) := tempRect
            %put rects(i).name + " switched with " + rects(i+1).name
            end if
        end for
    end for
    /*
    loop
    end loop
    */
end aSort



%Point in Rectangle%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
proc PtinRect
    var usedRect : rectangle
    var usedRectName : string
    var usedPoint : point
    put "What rectangle would you like to use? "..
    get usedRectName
    for i : 1 .. numRects
        if usedRectName = rects(i).name then
            usedRect := rects(i)
        end if
    end for
    put "What x coordinate would you like to use? "..
    get usedPoint.x
    put "What y coordinate would you like to use? "..
    get usedPoint.y
    if usedPoint.x < usedRect.bl.x then
        put "Point is not in rectangle."
    elsif usedPoint.y < usedRect.bl.y then
        put "Point is not in rectangle."
    elsif usedPoint.x > usedRect.tr.x then
        put "Point is not in rectangle."
    elsif usedPoint.y > usedRect.tr.y then
        put "Point is not in rectangle."
    else
        put "Point is in rectangle."
    end if
end PtinRect



%The Main Program%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
proc mainProgram
    setscreen ("graphics:6000;6000")
    var userIn : int
    loop
    putRect
        put ""
        put "What would you like to do?"
        put "1) Generate Rectangles"
        put "2) Add New Rectangle"
        put "3) Delete a Rectangle"
        put "4) Find Intersection"
        put "5) Find Union"
        put "6) Sort by Name"
        put "7) Find a Point in a Rectangle"
        put "8) Quit"
        get userIn
        case userIn of
            label 1 : rectGen
            label 2 : addRect
            label 3 : delRect
            label 4 : rectIn
            label 5 : rectUn
            label 6 : aSort
            label 7 : PtinRect
            label 8 : exit
            label : put "Not a valid option. "
        end case
    end loop
end mainProgram

mainProgram
Window.Hide (-1)



