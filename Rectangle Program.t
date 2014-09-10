type point : record
    x : int
    y : int
end record

type rectangle : record
    bl : point type
    tr : point type
    name : string (4)  
end record

var rects : array 1 .. 10 of rectangle

proc rectGen
    var numRects : int
    loop
        put "Enter the number of rectangles you'd like to generate: "..
        get numRects
        if numRects < 0 or numRects > 25 then
            put "Invalid number of retangles. "..
        else
            exit
        end if
    end loop
    if numRects > 0 then
        for i : 1 .. numRects
            rects (i).bl.x := Rand.Int (0, 800)
            rects (i).bl.y := Rand.Int (0, 600)
            
end rectGen

proc addRect

end addRect

proc delRect

end delRect

proc rectIn

end rectIn

proc rectUn

end rectUn

proc aSort

end aSort

proc PtinRet

end PtinRet

proc mainProgram
loop
end loop
end mainProgram

mainProgram
