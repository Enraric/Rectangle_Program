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

var numRects : int


%Initializing stuff because it makes my life easier%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

proc addRect
    for i : 1 .. 25
        if rects(i).name = "0" then
            numRects += 1
            loop
                put "Enter x vlaue for lower left:"..
                get rects (i).bl.x
                if rects (i).bl.x > 800 then
                    put "Value not valid."..
                else
                    exit
                end if
            end loop
            loop
                put "Enter y vlaue for lower left:"..
                get rects (i).bl.y
                if rects (i).bl.y > 600 then
                    put "Value not valid."..
                else
                    exit
                end if
            end loop
            loop
                put "Enter x vlaue for top right:"..
                get rects (i).tr.x
                if rects (i).tr.x > 800 or rects (i).tr.x < rects (i).bl.x then
                    put "Value not valid."..
                else
                    exit
                end if
            end loop
            loop
                put "Enter y vlaue for top right:"..
                get rects (i).tr.y
                if rects (i).tr.y > 800 or rects (i).tr.y < rects (i).bl.y then
                    put "Value not valid."..
                else
                    exit
                end if
            end loop
            exit
        end if
    end for
end addRect

proc delRect

end delRect

proc rectIn

end rectIn

proc rectUn

end rectUn

proc aSort

end aSort

proc PtinRect

end PtinRect

proc mainProgram
    var userIn : int
    rectGen
    loop
    putRect
        put ""
        put "What would you like to do?"
        put "1) Add New Rectangle"
        put "2) Delete a Rectangle"
        put "3) Find Intersection"
        put "4) Find Union"
        put "5) Sort by Name"
        put "6) Find a Point in a Rectangle"
        put "7) Quit"
        get userIn
        case userIn of
            label 1 : addRect
            label 2 : delRect
            label 3 : rectIn
            label 4 : rectUn
            label 5 : aSort
            label 6 : PtinRect
            label 7 : exit
            label : put "Not a valid option"
        end case
    end loop
end mainProgram

mainProgram
Window.Hide (-1)
