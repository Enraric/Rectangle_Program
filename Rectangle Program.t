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
            %Obtaining and checking point values
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
            
            %Obtaining and checking desired name
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
    if numRects > 0 then
        put "Which rectangle would you like to delete?"
        get badRect
        
        %Resetting rectangle values
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
            
            %Moving deleted rectangle to end of array
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
        
    else
        put "No rectangles stored."
        delay (3000)
    end if
end delRect



%Rectangle Intersection Checker%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
proc rectIn
    var rect1 : rectangle
    var rect2 : rectangle
    var section : rectangle
    var valid : boolean

    if numRects > 0 then
        put "Enter the name of the first rectangle: "..
        get rect1.name
        put "Enter the name of the second rectangle: "..
        get rect2.name
    
        %Obtaining rectangle data from the array
        for i : 1 .. numRects
            if rects(i).name = rect1.name then
                rect1 := rects(i)
            end if
        end for
        for i : 1 .. numRects
            if rects(i).name = rect2.name then
                rect2 := rects(i)
            end if
        end for
    
        %Checking if the intersection exists
        if rect1.bl.x <= rect2.tr.x and rect1.tr.x >= rect2.bl.x and rect1.bl.y <= rect2.tr.y and rect1.tr.y >= rect2.bl.y then
            valid := false
            put "No intersection found."
            delay (5000)
        else
            valid := true
        end if

        if valid then
            if rect1.bl.x > rect2.bl.x then
                section.bl.x := rect1.bl.x
            else
                section.bl.x := rect2.bl.x
            end if

            if rect1.bl.y > rect2.bl.y then
                section.bl.y := rect1.bl.y
            else
                section.bl.y := rect2.bl.y
            end if

            if rect1.tr.x > rect2.tr.x then
                section.tr.x := rect1.tr.x
            else
                section.tr.x := rect2.tr.x
            end if

            if rect1.tr.y > rect2.tr.y then
                section.tr.y := rect1.tr.y
            else
                section.tr.y := rect2.tr.y
            end if
            
            put "The intersection rectangle is defined by bottom left point (" + intstr (section.bl.x) + ", " + intstr (section.bl.y) + ") and the top right point (" + intstr (section.tr.x) + ", " + intstr (section.tr.y) + ")."
                delay (5000)
        end if
        
        else
            put "No rectangles stored."
        delay (3000)
    end if

end rectIn



%Rectangle Unity Creator%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
proc rectUn
    var rect1 : rectangle
    var rect2 : rectangle
    var bigRect : rectangle
    
    if numRects > 0 then
        put "Enter the name of the first rectangle: "..
        get rect1.name
        put "Enter the name of the second rectangle: "..
        get rect2.name
    
        %Obtaining rectangle data from the array
        for i : 1 .. numRects
            if rects(i).name = rect1.name then
                rect1 := rects(i)
            end if
        end for
        for i : 1 .. numRects
            if rects(i).name = rect2.name then
                rect2 := rects(i)
            end if
        end for
    
        %Finding botom left x value of union
        if rect1.bl.x > rect2.bl.x then
            bigRect.bl.x := rect2.bl.x
        else
            bigRect.bl.x := rect1.bl.x
        end if
    
        %Finding botom left y value of union
        if rect1.bl.y > rect2.bl.y then
            bigRect.bl.y := rect2.bl.y
        else
            bigRect.bl.y := rect1.bl.y
        end if
    
        %Finding top right x value of union
        if rect1.tr.x < rect2.tr.x then
            bigRect.tr.x := rect2.tr.x
        else
            bigRect.tr.x := rect1.tr.x
        end if
    
        %Finding top right y value of union
        if rect1.tr.y < rect2.tr.y then
            bigRect.tr.y := rect2.tr.y
        else
            bigRect.tr.y := rect1.tr.y
        end if
    
        put "The union rectangle is defined by points Bottom Left at (" + intstr(bigRect.bl.x) + ", " + intstr(bigRect.bl.y) + ") and Top Right at ("+ intstr(bigRect.tr.x) + ", " + intstr(bigRect.tr.y) + ")."
        delay (5000)
    
    else
        put "No rectangles stored."
        delay (3000)
    end if
    
end rectUn



%Alphabetical Sorting%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
proc aSort
    var tempRect : rectangle
    for q : 1 .. numRects
        for i : 1 .. (numRects - 1)
            if rects(i).name > rects(i+1).name then
                tempRect := rects(i+1)
                rects(i+1) := rects(i)
                rects(i) := tempRect
            end if
        end for
    end for
end aSort



%Point in Rectangle%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
proc PtinRect
    var usedRect : rectangle
    var usedRectName : string
    var usedPoint : point
    if numRects > 0 then
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
            delay (3000)
        elsif usedPoint.y < usedRect.bl.y then
            put "Point is not in rectangle."
            delay (3000)
        elsif usedPoint.x > usedRect.tr.x then
            put "Point is not in rectangle."
            delay (3000)
        elsif usedPoint.y > usedRect.tr.y then
            put "Point is not in rectangle."
            delay (3000)
        else
            put "Point is in rectangle."
            delay (3000)
        end if
    else
        put "No rectangles stored."
        delay (3000)
    end if
end PtinRect



%The Main Program%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
proc mainProgram
    setscreen ("graphics:600;600")
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



%Run%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mainProgram
Window.Hide (-1)



