DECLARE SUB helpScreen ()
DECLARE FUNCTION debugOptions! ()
DECLARE SUB doTitle ()
DECLARE FUNCTION checkCollision! (direction!)
DECLARE SUB loadMap ()
DECLARE SUB callMapLoad ()
DECLARE SUB drawMap ()
DECLARE FUNCTION Rand! (bottom!, top!)
DECLARE SUB drawBox (xa!, ya!, xb!, yb!, c!)
DIM SHARED dank AS INTEGER
DIM SHARED x AS INTEGER
DIM SHARED y AS INTEGER
DIM move AS STRING
DIM SHARED mapdata(15, 9) AS INTEGER
DIM SHARED datax, datay AS INTEGER
DIM SHARED level AS INTEGER

' shit for loading maps
DIM SHARED shita(15), shitb(15), shitc(15), shitd(15), shite(15), shitf(15), shitg(15), shith(15), shiti(15), shitj(15), shit(5) AS INTEGER
COMMON SHARED shita(), shitb(), shitc(), shitd(), shite(), shitf(), shitg(), shith(), shiti(), shitj(), shit() AS INTEGER

SCREEN 13


level = 1
datax = 0
datay = 0
x = 0
y = 0
dank = 0

' should we run the title screen?
IF shit(4) = 0 THEN
  ' do we have map0 loaded?
  IF shit(0) = 0 THEN
    ' load it (duh)
    level = 0
    callMapLoad
  ELSE
    ' reset shit0
    shit(0) = 0
    ' parse raw map data into usuable data
    loadMap
    ' title screen routine
    doTitle
    ' set title complete flag
    shit(4) = 1
  END IF
END IF




' check if we have map data loaded yet
IF shit(0) = 1 THEN
shit(0) = 0
loadMap
IF shit(1) > 0 THEN
level = shit(1)
END IF
GOTO levelready
ELSE
callMapLoad
END IF


levelready:
WHILE dank = 0
CLS
LOCATE 25, 1
drawMap
drawBox x + 0, y + 0, x + 20, y + 20, 13
INPUT "w, a, s, d, r"; move$
SELECT CASE move$
CASE "s"
  IF checkCollision(2) = 1 THEN
    y = y + 20
    datay = datay + 1
  END IF
CASE "w"
  IF checkCollision(1) = 1 THEN
    y = y - 20
    datay = datay - 1
  END IF
CASE "a"
  IF checkCollision(3) = 1 THEN
    x = x - 20
    datax = datax - 1
  END IF
CASE "d"
  IF checkCollision(4) = 1 THEN
    x = x + 20
    datax = datax + 1
  END IF
CASE "r"
' reset the map
loadMap
CASE "exit"
dank = 2
CASE ELSE
PRINT "epic fail"
END SELECT
WEND

IF dank = 1 THEN
PRINT "level cleared!"
shit(1) = level
callMapLoad
END IF

SUB callMapLoad
' basically just use a switch statement to get what map we need to load
SELECT CASE level
  CASE 0
    CHAIN "map0.bas"
  CASE 1
    CHAIN "map1.bas"
  CASE 2
    CHAIN "map2.bas"
  CASE 3
    CHAIN "map3.bas"
  CASE 4
    CHAIN "map4.bas"
  CASE 5
    CHAIN "map5.bas"
  CASE 6
    CHAIN "map6.bas"
  CASE 7
    CHAIN "map7.bas"
  CASE 8
    CHAIN "map8.bas"
  CASE 9
    CHAIN "map9.bas"
  CASE 10
    CHAIN "map10.bas"
  CASE ELSE
    PRINT "failed at loading unknown map ID"
    END
END SELECT
END SUB

FUNCTION checkCollision (direction)
DIM tempx, tempy AS INTEGER

SELECT CASE direction
  CASE 1
    ' up
    tempy = datay - 1
    tempx = datax
  CASE 2
    ' down
    tempy = datay + 1
    tempx = datax
  CASE 3
    ' left
    tempy = datay
    tempx = datax - 1
  CASE 4
    ' right
    tempy = datay
    tempx = datax + 1
  CASE ELSE
    PRINT "fatal error occured while checking collision!"
    END
END SELECT

' now actually check for shit
DIM curtile AS INTEGER
curtile = mapdata(tempx, tempy)

SELECT CASE curtile
  CASE 6
    ' this is a wall tile
    checkCollision = 0
  CASE 7
    ' blank floor tile
    checkCollision = 1
  CASE 2
    ' stage clear tile
    checkCollision = 1
    level = level + 1
    dank = 1
  CASE 9
    ' water tile
    checkCollision = 0
  CASE 8
    ' movable block
    SELECT CASE direction
      CASE 1
        SELECT CASE mapdata(tempx, tempy - 1)
          CASE 9
            mapdata(tempx, tempy) = 7
            mapdata(tempx, tempy - 1) = 7
            checkCollision = 1
          CASE 8
            ' dont collide with another box
            checkCollision = 0
          CASE 4
            ' become an exit tile
            mapdata(tempx, tempy - 1) = 2
            mapdata(tempx, tempy) = 7
            checkCollision = 1
          CASE ELSE
            mapdata(tempx, tempy) = 7
            mapdata(tempx, tempy - 1) = 8
            checkCollision = 1
        END SELECT
      CASE 2
        SELECT CASE mapdata(tempx, tempy + 1)
          CASE 9
            mapdata(tempx, tempy) = 7
            mapdata(tempx, tempy + 1) = 7
            checkCollision = 1
          CASE 8
            ' dont collide with another box
            checkCollision = 0
          CASE 4
            ' become an exit tile
            mapdata(tempx, tempy + 1) = 2
            mapdata(tempx, tempy) = 7
            checkCollision = 1
          CASE ELSE
            mapdata(tempx, tempy) = 7
            mapdata(tempx, tempy + 1) = 8
            checkCollision = 1
        END SELECT
      CASE 3
        SELECT CASE mapdata(tempx - 1, tempy)
          CASE 9
            mapdata(tempx, tempy) = 7
            mapdata(tempx - 1, tempy) = 7
            checkCollision = 1
          CASE 8
            ' dont collide with another box
            checkCollision = 0
          CASE 4
            ' become an exit tile
            mapdata(tempx - 1, tempy) = 2
            mapdata(tempx, tempy) = 7
            checkCollision = 1
          CASE ELSE
            mapdata(tempx, tempy) = 7
            mapdata(tempx - 1, tempy) = 8
            checkCollision = 1
        END SELECT
      CASE 4
        SELECT CASE mapdata(tempx + 1, tempy)
          CASE 9
            mapdata(tempx, tempy) = 7
            mapdata(tempx + 1, tempy) = 7
            checkCollision = 1
          CASE 8
            ' dont collide with another box
            checkCollision = 0
          CASE 4
            ' become an exit tile
            mapdata(tempx + 1, tempy) = 2
            mapdata(tempx, tempy) = 7
            checkCollision = 1
          CASE ELSE
            mapdata(tempx, tempy) = 7
            mapdata(tempx + 1, tempy) = 8
            checkCollision = 1
        END SELECT
      CASE ELSE
        PRINT "fatal error: block move code has failed!"
        END
      END SELECT
  CASE 4
    ' unactivated exit tile
    checkCollision = 1
  CASE 11
    ' the player has cleared the game
    PRINT "You win!"
    PRINT "thanks for playing my short little game!"
    END
  CASE ELSE
    PRINT "fatal error: unknown tile in map data!"
    END
END SELECT


END FUNCTION

FUNCTION debugOptions
  DIM pass AS STRING
  DIM wat AS INTEGER
  LOCATE 5, 1
  INPUT "Please enter password:", pass$
  IF pass$ = "ryzen" THEN
    INPUT "l, m"; pass$
    SELECT CASE pass$
      CASE "l"
        INPUT "enter level id:", wat
        level = wat
        shit(1) = wat
        debugOptions = 1
      CASE ELSE
        PRINT "epic fail!"
        debugOptions = 0
    END SELECT
  ELSE
    PRINT "password incorrect!"
    PRINT "Press any key to continue..."
    pass$ = ""
    WHILE pass$ = ""
      pass$ = INKEY$
    WEND
    debugOptions = 0
  END IF
END FUNCTION

SUB doTitle
  DIM oof AS INTEGER
  DIM what AS STRING
  oof = 0
  WHILE oof = 0
    CLS
    drawMap
    LOCATE 4, 8
    PRINT "a game by Ezioisntcool56"
    LOCATE 25, 1
    INPUT "s, h, e"; what$
    SELECT CASE what$
      CASE "e"
        END
      CASE "h"
        helpScreen
      CASE "s"
        oof = 1
      CASE "debug"
        IF debugOptions = 1 THEN
          oof = 1
        END IF
      CASE ELSE
        PRINT "that is not a valid option!"
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
' we need to draw the map data from an array of shit
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

SUB helpScreen
  DIM wat AS STRING
  wat = ""
  SCREEN 0
  CLS
  ' create the screen full of help text
  PRINT CHR$(34) + "PUZ" + CHR$(34) + " By Ezioisntcool56"
  PRINT "game instructional screen"
  PRINT ""

  ' first help line
  COLOR 7: PRINT "you play as the ";
  COLOR 13: PRINT "pink ";
  COLOR 7: PRINT "box"

  ' second help line
  PRINT "using the input prompt, you must"

  ' third line
  COLOR 7: PRINT "get to the ";
  COLOR 2: PRINT "green ";
  COLOR 7: PRINT "box to clear the stage"

  ' line 4
  COLOR 6: PRINT "walls ";
  COLOR 7: PRINT "prevent you from going places"

  ' line 5
  COLOR 8: PRINT "boxes ";
  COLOR 7: PRINT "break ";
  COLOR 6: PRINT "walls ";
  COLOR 7: PRINT "when they touch"

  ' line 6
  COLOR 8: PRINT "boxes ";
  COLOR 7: PRINT "sink in ";
  COLOR 9: PRINT "water"

  ' line 7
  COLOR 13: PRINT "you ";
  COLOR 7: PRINT "cant swim in ";
  COLOR 9: PRINT "water"

  ' line 8
  COLOR 4: PRINT "zones ";
  COLOR 7: PRINT "need a ";
  COLOR 8: PRINT "box ";
  COLOR 7: PRINT "to become ";
  COLOR 2: PRINT "exits"


  WHILE wat$ = ""
    wat$ = INKEY$
  WEND
  SCREEN 13
  CLS

END SUB

SUB loadMap

DIM fank AS INTEGER
fank = 0

WHILE fank < 10
FOR i = 0 TO 15
SELECT CASE fank
CASE 0
mapdata(i, fank) = shita(i)
CASE 1
mapdata(i, fank) = shitb(i)
CASE 2
mapdata(i, fank) = shitc(i)
CASE 3
mapdata(i, fank) = shitd(i)
CASE 4
mapdata(i, fank) = shite(i)
CASE 5
mapdata(i, fank) = shitf(i)
CASE 6
mapdata(i, fank) = shitg(i)
CASE 7
mapdata(i, fank) = shith(i)
CASE 8
mapdata(i, fank) = shiti(i)
CASE 9
mapdata(i, fank) = shitj(i)
CASE ELSE
PRINT "a fatal loading error has occured!"
END
END SELECT
NEXT i
fank = fank + 1
WEND

' check if spawn information has been included in the map file
IF shit(2) > 0 THEN
x = shit(2) * 20
y = shit(3) * 20
datax = shit(2)
datay = shit(3)
END IF

END SUB

FUNCTION Rand (bottom, top)
'From StackOverFlow
RANDOMIZE TIMER
RANDOMIZE RND * 10
IF bottom > top THEN 'its fucking backwards you fool
temp = bottom
bottom = top
top = temp
END IF
Rand = INT((top - bottom + 1) * RND + bottom)
END FUNCTION

