DECLARE SUB mapLoad ()
DECLARE SUB saveMap (name$)
DECLARE SUB changeTile ()
DECLARE SUB drawMap ()
DECLARE SUB genMap ()
DECLARE SUB drawBox (xa!, ya!, xb!, yb!, c!)
DIM SHARED mapdata(15, 9) AS INTEGER
DIM SHARED x AS INTEGER
DIM SHARED y AS INTEGER
DIM datax AS INTEGER
DIM datay AS INTEGER
DIM SHARED tile AS INTEGER
DIM dank AS INTEGER
DIM move AS STRING

' shit for loading maps
DIM SHARED shita(15), shitb(15), shitc(15), shitd(15), shite(15), shitf(15), shitg(15), shith(15), shiti(15), shitj(15), shit(5) AS INTEGER
COMMON SHARED shita(), shitb(), shitc(), shitd(), shite(), shitf(), shitg(), shith(), shiti(), shitj(), shit() AS INTEGER


tile = 5
x = 0
y = 0
datax = 0
datay = 0
dank = 0
SCREEN 13

IF shit(0) = 1 THEN
mapLoad
GOTO maploaded
END IF

INPUT "would you like to load a map (y/n)", move$
SELECT CASE move$
CASE "y"
INPUT "enter filename:", move$
shit(1) = 1
CHAIN move$
CASE "n"
PRINT "generating blank map, please wait..."
genMap
CASE ELSE
PRINT "Try entering a valid response next time!"
END
END SELECT

maploaded:
WHILE dank = 0
CLS
LOCATE 25, 1
drawMap
drawBox x + 0, y + 0, x + 20, y + 20, tile + 0
INPUT "w, a, s, d, c, p"; move$
SELECT CASE move$
CASE "w"
y = y - 20
datay = datay - 1
CASE "s"
y = y + 20
datay = datay + 1
CASE "a"
x = x - 20
datax = datax - 1
CASE "d"
x = x + 20
datax = datax + 1
CASE "c"
changeTile
CASE "p"
mapdata(datax, datay) = tile
CASE "exit"
END
CASE "save"
INPUT "filename"; move$
saveMap move$
CASE ELSE
PRINT "epic fail!"
END SELECT
WEND


SUB changeTile
dink = 0
DIM what AS STRING

WHILE dink = 0
CLS
LOCATE 25, 1
drawMap
drawBox x + 0, y + 0, x + 20, y + 20, tile + 0
INPUT "a, d, e"; what$
SELECT CASE what$
CASE "a"
tile = tile - 1
CASE "d"
tile = tile + 1
CASE "e"
dink = 1
CASE ELSE
PRINT "epic fail!"
END SELECT
WEND

END SUB

SUB drawBox (xa, ya, xb, yb, c)
LINE (xa, ya)-(xa, yb), c
LINE (xa, ya)-(xb, ya), c
LINE (xb, ya)-(xb, yb), c
LINE (xa, yb)-(xb, yb), c
PAINT (xa + 1, ya + 1), c, c
END SUB

SUB drawMap
addx = 0
addy = 0
FOR i = 0 TO 9
FOR f = 0 TO 15
drawBox 0 + addx, 0 + addy, 20 + addx, 20 + addy, mapdata(f, i) + 0
addx = addx + 20
NEXT f
addx = 0
addy = addy + 20
NEXT i
END SUB

SUB genMap
FOR i = 0 TO 15
FOR f = 0 TO 9
mapdata(i, f) = 7
NEXT f
NEXT i
END SUB

SUB mapLoad
' name table
DIM dank AS INTEGER
dank = 0

WHILE dank < 10
FOR i = 0 TO 15
SELECT CASE dank
CASE 0
mapdata(i, dank) = shita(i)
CASE 1
mapdata(i, dank) = shitb(i)
CASE 2
mapdata(i, dank) = shitc(i)
CASE 3
mapdata(i, dank) = shitd(i)
CASE 4
mapdata(i, dank) = shite(i)
CASE 5
mapdata(i, dank) = shitf(i)
CASE 6
mapdata(i, dank) = shitg(i)
CASE 7
mapdata(i, dank) = shith(i)
CASE 8
mapdata(i, dank) = shiti(i)
CASE 9
mapdata(i, dank) = shitj(i)
CASE ELSE
PRINT "a fatal loading error has occured!"
END
END SELECT
NEXT i
dank = dank + 1
WEND


END SUB

SUB saveMap (name$)
PRINT "Saving map..."
OPEN name$ FOR OUTPUT AS 1
PRINT #1, "'Ezio Map Format for quickbasic programs"
PRINT #1, "'used to create an array full of map tile data"
PRINT #1, "DIM SHARED shita(15), shitb(15), shitc(15), shitd(15), shite(15), shitf(15), shitg(15), shith(15), shiti(15), shitj(15), shit(5) AS INTEGER"
PRINT #1, "COMMON SHARED shita(), shitb(), shitc(), shitd(), shite(), shitf(), shitg(), shith(), shiti(), shitj(), shit() AS INTEGER"

DIM right AS INTEGER
DIM names(9) AS STRING
names(0) = "shita"
names(1) = "shitb"
names(2) = "shitc"
names(3) = "shitd"
names(4) = "shite"
names(5) = "shitf"
names(6) = "shitg"
names(7) = "shith"
names(8) = "shiti"
names(9) = "shitj"



right = 0

WHILE right < 10

FOR i = 0 TO 15
PRINT #1, names(right) + "(" + STR$(i) + ") =" + STR$(mapdata(i, right))
NEXT i

right = right + 1

WEND

' this is required to tell the program the map has finished loading
PRINT #1, "shit(0) = 1"
' fill in these with the spawn point for the player (x, y)
PRINT #1, "shit(2) = 0"
PRINT #1, "shit(3) = 0"

PRINT #1, "IF shit(1) = 1 THEN"
PRINT #1, "CHAIN" + CHR$(34) + "mapedit.bas" + CHR$(34)
PRINT #1, "ELSE"
PRINT #1, "CHAIN" + CHR$(34) + "game.bas" + CHR$(34)
PRINT #1, "END IF"

CLOSE 1
PRINT "Map saved!"
END
END SUB

