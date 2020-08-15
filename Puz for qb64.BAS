_TITLE "Puz for QB64"

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
COMMON SHARED shita, shitb, shitc, shitd, shite, shitf, shitg, shith, shiti, shitj, shit AS INTEGER



qb64LoadFix:

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
        ' qb46 patch: jump to start
        GOTO qb64LoadFix
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
    ' qb66-exclusive fix: jump to start of program
    GOTO qb64LoadFix
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
    ' QB64-only loading fix
    GOTO qb64LoadFix
END IF


DEFSNG A-Z
SUB callMapLoad
    ' basically just use a switch statement to get what map we need to load
    SELECT CASE level
        CASE 0
            shita(0) = 6
            shita(1) = 6
            shita(2) = 6
            shita(3) = 6
            shita(4) = 6
            shita(5) = 6
            shita(6) = 6
            shita(7) = 6
            shita(8) = 6
            shita(9) = 6
            shita(10) = 6
            shita(11) = 6
            shita(12) = 6
            shita(13) = 6
            shita(14) = 6
            shita(15) = 6
            shitb(0) = 6
            shitb(1) = 7
            shitb(2) = 7
            shitb(3) = 7
            shitb(4) = 7
            shitb(5) = 7
            shitb(6) = 7
            shitb(7) = 7
            shitb(8) = 7
            shitb(9) = 7
            shitb(10) = 7
            shitb(11) = 7
            shitb(12) = 7
            shitb(13) = 7
            shitb(14) = 7
            shitb(15) = 6
            shitc(0) = 6
            shitc(1) = 11
            shitc(2) = 11
            shitc(3) = 7
            shitc(4) = 7
            shitc(5) = 11
            shitc(6) = 7
            shitc(7) = 7
            shitc(8) = 11
            shitc(9) = 7
            shitc(10) = 11
            shitc(11) = 11
            shitc(12) = 11
            shitc(13) = 11
            shitc(14) = 11
            shitc(15) = 6
            shitd(0) = 6
            shitd(1) = 11
            shitd(2) = 7
            shitd(3) = 11
            shitd(4) = 7
            shitd(5) = 11
            shitd(6) = 7
            shitd(7) = 7
            shitd(8) = 11
            shitd(9) = 7
            shitd(10) = 7
            shitd(11) = 7
            shitd(12) = 7
            shitd(13) = 7
            shitd(14) = 11
            shitd(15) = 6
            shite(0) = 6
            shite(1) = 11
            shite(2) = 7
            shite(3) = 11
            shite(4) = 7
            shite(5) = 11
            shite(6) = 7
            shite(7) = 7
            shite(8) = 11
            shite(9) = 7
            shite(10) = 7
            shite(11) = 7
            shite(12) = 7
            shite(13) = 11
            shite(14) = 7
            shite(15) = 6
            shitf(0) = 6
            shitf(1) = 11
            shitf(2) = 11
            shitf(3) = 7
            shitf(4) = 7
            shitf(5) = 11
            shitf(6) = 7
            shitf(7) = 7
            shitf(8) = 11
            shitf(9) = 7
            shitf(10) = 7
            shitf(11) = 7
            shitf(12) = 11
            shitf(13) = 7
            shitf(14) = 7
            shitf(15) = 6
            shitg(0) = 6
            shitg(1) = 11
            shitg(2) = 7
            shitg(3) = 7
            shitg(4) = 7
            shitg(5) = 11
            shitg(6) = 7
            shitg(7) = 7
            shitg(8) = 11
            shitg(9) = 7
            shitg(10) = 7
            shitg(11) = 11
            shitg(12) = 7
            shitg(13) = 7
            shitg(14) = 7
            shitg(15) = 6
            shith(0) = 6
            shith(1) = 11
            shith(2) = 7
            shith(3) = 7
            shith(4) = 7
            shith(5) = 7
            shith(6) = 11
            shith(7) = 11
            shith(8) = 7
            shith(9) = 7
            shith(10) = 11
            shith(11) = 11
            shith(12) = 11
            shith(13) = 11
            shith(14) = 11
            shith(15) = 6
            shiti(0) = 6
            shiti(1) = 7
            shiti(2) = 7
            shiti(3) = 7
            shiti(4) = 7
            shiti(5) = 7
            shiti(6) = 7
            shiti(7) = 7
            shiti(8) = 7
            shiti(9) = 7
            shiti(10) = 7
            shiti(11) = 7
            shiti(12) = 7
            shiti(13) = 7
            shiti(14) = 7
            shiti(15) = 6
            shitj(0) = 6
            shitj(1) = 6
            shitj(2) = 6
            shitj(3) = 6
            shitj(4) = 6
            shitj(5) = 6
            shitj(6) = 6
            shitj(7) = 6
            shitj(8) = 6
            shitj(9) = 6
            shitj(10) = 6
            shitj(11) = 6
            shitj(12) = 6
            shitj(13) = 6
            shitj(14) = 6
            shitj(15) = 6
            shit(0) = 1
            shit(2) = 0
            shit(3) = 0
        CASE 1
            shita(0) = 6
            shita(1) = 6
            shita(2) = 6
            shita(3) = 6
            shita(4) = 6
            shita(5) = 6
            shita(6) = 6
            shita(7) = 6
            shita(8) = 6
            shita(9) = 6
            shita(10) = 6
            shita(11) = 6
            shita(12) = 6
            shita(13) = 6
            shita(14) = 6
            shita(15) = 6
            shitb(0) = 6
            shitb(1) = 7
            shitb(2) = 7
            shitb(3) = 7
            shitb(4) = 7
            shitb(5) = 7
            shitb(6) = 7
            shitb(7) = 7
            shitb(8) = 7
            shitb(9) = 7
            shitb(10) = 7
            shitb(11) = 7
            shitb(12) = 7
            shitb(13) = 7
            shitb(14) = 7
            shitb(15) = 6
            shitc(0) = 6
            shitc(1) = 7
            shitc(2) = 7
            shitc(3) = 7
            shitc(4) = 7
            shitc(5) = 7
            shitc(6) = 7
            shitc(7) = 7
            shitc(8) = 7
            shitc(9) = 7
            shitc(10) = 7
            shitc(11) = 7
            shitc(12) = 7
            shitc(13) = 7
            shitc(14) = 7
            shitc(15) = 6
            shitd(0) = 6
            shitd(1) = 7
            shitd(2) = 7
            shitd(3) = 7
            shitd(4) = 7
            shitd(5) = 7
            shitd(6) = 7
            shitd(7) = 7
            shitd(8) = 7
            shitd(9) = 7
            shitd(10) = 7
            shitd(11) = 7
            shitd(12) = 7
            shitd(13) = 7
            shitd(14) = 7
            shitd(15) = 6
            shite(0) = 6
            shite(1) = 7
            shite(2) = 7
            shite(3) = 7
            shite(4) = 7
            shite(5) = 7
            shite(6) = 7
            shite(7) = 7
            shite(8) = 7
            shite(9) = 7
            shite(10) = 7
            shite(11) = 7
            shite(12) = 7
            shite(13) = 7
            shite(14) = 7
            shite(15) = 6
            shitf(0) = 6
            shitf(1) = 7
            shitf(2) = 7
            shitf(3) = 7
            shitf(4) = 7
            shitf(5) = 7
            shitf(6) = 7
            shitf(7) = 7
            shitf(8) = 8
            shitf(9) = 7
            shitf(10) = 7
            shitf(11) = 7
            shitf(12) = 7
            shitf(13) = 7
            shitf(14) = 7
            shitf(15) = 6
            shitg(0) = 6
            shitg(1) = 7
            shitg(2) = 7
            shitg(3) = 7
            shitg(4) = 7
            shitg(5) = 7
            shitg(6) = 7
            shitg(7) = 7
            shitg(8) = 7
            shitg(9) = 7
            shitg(10) = 7
            shitg(11) = 7
            shitg(12) = 7
            shitg(13) = 7
            shitg(14) = 7
            shitg(15) = 6
            shith(0) = 6
            shith(1) = 7
            shith(2) = 7
            shith(3) = 7
            shith(4) = 7
            shith(5) = 7
            shith(6) = 7
            shith(7) = 7
            shith(8) = 7
            shith(9) = 7
            shith(10) = 7
            shith(11) = 7
            shith(12) = 7
            shith(13) = 7
            shith(14) = 7
            shith(15) = 6
            shiti(0) = 6
            shiti(1) = 7
            shiti(2) = 7
            shiti(3) = 7
            shiti(4) = 7
            shiti(5) = 7
            shiti(6) = 7
            shiti(7) = 7
            shiti(8) = 7
            shiti(9) = 7
            shiti(10) = 7
            shiti(11) = 7
            shiti(12) = 7
            shiti(13) = 7
            shiti(14) = 2
            shiti(15) = 6
            shitj(0) = 6
            shitj(1) = 6
            shitj(2) = 6
            shitj(3) = 6
            shitj(4) = 6
            shitj(5) = 6
            shitj(6) = 6
            shitj(7) = 6
            shitj(8) = 6
            shitj(9) = 6
            shitj(10) = 6
            shitj(11) = 6
            shitj(12) = 6
            shitj(13) = 6
            shitj(14) = 6
            shitj(15) = 6
            shit(0) = 1
            shit(2) = 1
            shit(3) = 1
        CASE 2
            shita(0) = 6
            shita(1) = 6
            shita(2) = 6
            shita(3) = 6
            shita(4) = 6
            shita(5) = 6
            shita(6) = 6
            shita(7) = 6
            shita(8) = 6
            shita(9) = 6
            shita(10) = 6
            shita(11) = 6
            shita(12) = 6
            shita(13) = 6
            shita(14) = 6
            shita(15) = 6
            shitb(0) = 6
            shitb(1) = 7
            shitb(2) = 7
            shitb(3) = 7
            shitb(4) = 7
            shitb(5) = 7
            shitb(6) = 7
            shitb(7) = 7
            shitb(8) = 6
            shitb(9) = 6
            shitb(10) = 6
            shitb(11) = 6
            shitb(12) = 6
            shitb(13) = 6
            shitb(14) = 6
            shitb(15) = 6
            shitc(0) = 6
            shitc(1) = 7
            shitc(2) = 7
            shitc(3) = 7
            shitc(4) = 7
            shitc(5) = 7
            shitc(6) = 7
            shitc(7) = 7
            shitc(8) = 6
            shitc(9) = 6
            shitc(10) = 6
            shitc(11) = 6
            shitc(12) = 6
            shitc(13) = 6
            shitc(14) = 6
            shitc(15) = 6
            shitd(0) = 6
            shitd(1) = 7
            shitd(2) = 7
            shitd(3) = 7
            shitd(4) = 7
            shitd(5) = 8
            shitd(6) = 7
            shitd(7) = 7
            shitd(8) = 6
            shitd(9) = 6
            shitd(10) = 6
            shitd(11) = 6
            shitd(12) = 6
            shitd(13) = 6
            shitd(14) = 6
            shitd(15) = 6
            shite(0) = 6
            shite(1) = 7
            shite(2) = 7
            shite(3) = 7
            shite(4) = 7
            shite(5) = 7
            shite(6) = 7
            shite(7) = 7
            shite(8) = 6
            shite(9) = 6
            shite(10) = 6
            shite(11) = 6
            shite(12) = 6
            shite(13) = 6
            shite(14) = 6
            shite(15) = 6
            shitf(0) = 6
            shitf(1) = 6
            shitf(2) = 6
            shitf(3) = 6
            shitf(4) = 6
            shitf(5) = 6
            shitf(6) = 6
            shitf(7) = 6
            shitf(8) = 6
            shitf(9) = 6
            shitf(10) = 6
            shitf(11) = 6
            shitf(12) = 6
            shitf(13) = 6
            shitf(14) = 6
            shitf(15) = 6
            shitg(0) = 6
            shitg(1) = 7
            shitg(2) = 7
            shitg(3) = 7
            shitg(4) = 7
            shitg(5) = 7
            shitg(6) = 7
            shitg(7) = 7
            shitg(8) = 6
            shitg(9) = 7
            shitg(10) = 7
            shitg(11) = 7
            shitg(12) = 7
            shitg(13) = 7
            shitg(14) = 7
            shitg(15) = 6
            shith(0) = 6
            shith(1) = 7
            shith(2) = 7
            shith(3) = 7
            shith(4) = 7
            shith(5) = 7
            shith(6) = 7
            shith(7) = 7
            shith(8) = 6
            shith(9) = 7
            shith(10) = 7
            shith(11) = 7
            shith(12) = 7
            shith(13) = 7
            shith(14) = 7
            shith(15) = 6
            shiti(0) = 6
            shiti(1) = 7
            shiti(2) = 7
            shiti(3) = 7
            shiti(4) = 7
            shiti(5) = 7
            shiti(6) = 7
            shiti(7) = 7
            shiti(8) = 6
            shiti(9) = 7
            shiti(10) = 7
            shiti(11) = 7
            shiti(12) = 7
            shiti(13) = 7
            shiti(14) = 2
            shiti(15) = 6
            shitj(0) = 6
            shitj(1) = 6
            shitj(2) = 6
            shitj(3) = 6
            shitj(4) = 6
            shitj(5) = 6
            shitj(6) = 6
            shitj(7) = 6
            shitj(8) = 6
            shitj(9) = 6
            shitj(10) = 6
            shitj(11) = 6
            shitj(12) = 6
            shitj(13) = 6
            shitj(14) = 6
            shitj(15) = 6
            shit(0) = 1
            shit(2) = 1
            shit(3) = 1
        CASE 3
            shita(0) = 6
            shita(1) = 6
            shita(2) = 6
            shita(3) = 6
            shita(4) = 6
            shita(5) = 6
            shita(6) = 6
            shita(7) = 6
            shita(8) = 6
            shita(9) = 6
            shita(10) = 6
            shita(11) = 6
            shita(12) = 6
            shita(13) = 6
            shita(14) = 6
            shita(15) = 6
            shitb(0) = 6
            shitb(1) = 7
            shitb(2) = 7
            shitb(3) = 7
            shitb(4) = 6
            shitb(5) = 6
            shitb(6) = 6
            shitb(7) = 6
            shitb(8) = 6
            shitb(9) = 6
            shitb(10) = 6
            shitb(11) = 6
            shitb(12) = 6
            shitb(13) = 6
            shitb(14) = 6
            shitb(15) = 6
            shitc(0) = 6
            shitc(1) = 7
            shitc(2) = 7
            shitc(3) = 7
            shitc(4) = 6
            shitc(5) = 6
            shitc(6) = 6
            shitc(7) = 6
            shitc(8) = 6
            shitc(9) = 6
            shitc(10) = 6
            shitc(11) = 6
            shitc(12) = 6
            shitc(13) = 6
            shitc(14) = 6
            shitc(15) = 6
            shitd(0) = 6
            shitd(1) = 7
            shitd(2) = 7
            shitd(3) = 8
            shitd(4) = 6
            shitd(5) = 6
            shitd(6) = 6
            shitd(7) = 6
            shitd(8) = 6
            shitd(9) = 6
            shitd(10) = 6
            shitd(11) = 6
            shitd(12) = 6
            shitd(13) = 6
            shitd(14) = 6
            shitd(15) = 6
            shite(0) = 6
            shite(1) = 7
            shite(2) = 6
            shite(3) = 7
            shite(4) = 6
            shite(5) = 6
            shite(6) = 6
            shite(7) = 6
            shite(8) = 6
            shite(9) = 6
            shite(10) = 6
            shite(11) = 6
            shite(12) = 6
            shite(13) = 6
            shite(14) = 6
            shite(15) = 6
            shitf(0) = 6
            shitf(1) = 7
            shitf(2) = 6
            shitf(3) = 7
            shitf(4) = 6
            shitf(5) = 6
            shitf(6) = 6
            shitf(7) = 6
            shitf(8) = 6
            shitf(9) = 6
            shitf(10) = 6
            shitf(11) = 6
            shitf(12) = 6
            shitf(13) = 6
            shitf(14) = 6
            shitf(15) = 6
            shitg(0) = 6
            shitg(1) = 7
            shitg(2) = 6
            shitg(3) = 7
            shitg(4) = 6
            shitg(5) = 6
            shitg(6) = 6
            shitg(7) = 6
            shitg(8) = 6
            shitg(9) = 6
            shitg(10) = 6
            shitg(11) = 6
            shitg(12) = 6
            shitg(13) = 6
            shitg(14) = 6
            shitg(15) = 6
            shith(0) = 6
            shith(1) = 7
            shith(2) = 7
            shith(3) = 7
            shith(4) = 7
            shith(5) = 7
            shith(6) = 7
            shith(7) = 7
            shith(8) = 7
            shith(9) = 7
            shith(10) = 7
            shith(11) = 6
            shith(12) = 7
            shith(13) = 7
            shith(14) = 7
            shith(15) = 6
            shiti(0) = 6
            shiti(1) = 6
            shiti(2) = 6
            shiti(3) = 7
            shiti(4) = 6
            shiti(5) = 6
            shiti(6) = 6
            shiti(7) = 6
            shiti(8) = 6
            shiti(9) = 7
            shiti(10) = 7
            shiti(11) = 6
            shiti(12) = 7
            shiti(13) = 7
            shiti(14) = 2
            shiti(15) = 6
            shitj(0) = 6
            shitj(1) = 6
            shitj(2) = 6
            shitj(3) = 6
            shitj(4) = 6
            shitj(5) = 6
            shitj(6) = 6
            shitj(7) = 6
            shitj(8) = 6
            shitj(9) = 6
            shitj(10) = 6
            shitj(11) = 6
            shitj(12) = 6
            shitj(13) = 6
            shitj(14) = 6
            shitj(15) = 6
            shit(0) = 1
            shit(2) = 1
            shit(3) = 1
        CASE 4
            shita(0) = 6
            shita(1) = 6
            shita(2) = 6
            shita(3) = 6
            shita(4) = 6
            shita(5) = 6
            shita(6) = 6
            shita(7) = 6
            shita(8) = 6
            shita(9) = 6
            shita(10) = 6
            shita(11) = 6
            shita(12) = 6
            shita(13) = 6
            shita(14) = 6
            shita(15) = 6
            shitb(0) = 6
            shitb(1) = 7
            shitb(2) = 7
            shitb(3) = 7
            shitb(4) = 9
            shitb(5) = 7
            shitb(6) = 7
            shitb(7) = 7
            shitb(8) = 7
            shitb(9) = 7
            shitb(10) = 9
            shitb(11) = 9
            shitb(12) = 7
            shitb(13) = 7
            shitb(14) = 7
            shitb(15) = 6
            shitc(0) = 6
            shitc(1) = 7
            shitc(2) = 7
            shitc(3) = 7
            shitc(4) = 9
            shitc(5) = 7
            shitc(6) = 7
            shitc(7) = 7
            shitc(8) = 7
            shitc(9) = 7
            shitc(10) = 9
            shitc(11) = 9
            shitc(12) = 7
            shitc(13) = 7
            shitc(14) = 7
            shitc(15) = 6
            shitd(0) = 6
            shitd(1) = 7
            shitd(2) = 8
            shitd(3) = 7
            shitd(4) = 9
            shitd(5) = 7
            shitd(6) = 7
            shitd(7) = 7
            shitd(8) = 7
            shitd(9) = 7
            shitd(10) = 9
            shitd(11) = 9
            shitd(12) = 7
            shitd(13) = 7
            shitd(14) = 7
            shitd(15) = 6
            shite(0) = 6
            shite(1) = 7
            shite(2) = 8
            shite(3) = 7
            shite(4) = 9
            shite(5) = 7
            shite(6) = 7
            shite(7) = 7
            shite(8) = 7
            shite(9) = 7
            shite(10) = 9
            shite(11) = 9
            shite(12) = 7
            shite(13) = 7
            shite(14) = 7
            shite(15) = 6
            shitf(0) = 6
            shitf(1) = 7
            shitf(2) = 7
            shitf(3) = 7
            shitf(4) = 9
            shitf(5) = 7
            shitf(6) = 7
            shitf(7) = 7
            shitf(8) = 8
            shitf(9) = 7
            shitf(10) = 9
            shitf(11) = 9
            shitf(12) = 7
            shitf(13) = 7
            shitf(14) = 7
            shitf(15) = 6
            shitg(0) = 6
            shitg(1) = 7
            shitg(2) = 7
            shitg(3) = 7
            shitg(4) = 9
            shitg(5) = 7
            shitg(6) = 7
            shitg(7) = 7
            shitg(8) = 7
            shitg(9) = 7
            shitg(10) = 9
            shitg(11) = 9
            shitg(12) = 7
            shitg(13) = 7
            shitg(14) = 7
            shitg(15) = 6
            shith(0) = 6
            shith(1) = 7
            shith(2) = 7
            shith(3) = 7
            shith(4) = 9
            shith(5) = 7
            shith(6) = 7
            shith(7) = 7
            shith(8) = 7
            shith(9) = 7
            shith(10) = 9
            shith(11) = 9
            shith(12) = 7
            shith(13) = 7
            shith(14) = 7
            shith(15) = 6
            shiti(0) = 6
            shiti(1) = 7
            shiti(2) = 7
            shiti(3) = 7
            shiti(4) = 9
            shiti(5) = 7
            shiti(6) = 7
            shiti(7) = 7
            shiti(8) = 7
            shiti(9) = 7
            shiti(10) = 9
            shiti(11) = 9
            shiti(12) = 7
            shiti(13) = 7
            shiti(14) = 2
            shiti(15) = 6
            shitj(0) = 6
            shitj(1) = 6
            shitj(2) = 6
            shitj(3) = 6
            shitj(4) = 6
            shitj(5) = 6
            shitj(6) = 6
            shitj(7) = 6
            shitj(8) = 6
            shitj(9) = 6
            shitj(10) = 6
            shitj(11) = 6
            shitj(12) = 6
            shitj(13) = 6
            shitj(14) = 6
            shitj(15) = 6
            shit(0) = 1
            shit(2) = 7
            shit(3) = 1
        CASE 5
            shita(0) = 6
            shita(1) = 6
            shita(2) = 6
            shita(3) = 6
            shita(4) = 6
            shita(5) = 6
            shita(6) = 6
            shita(7) = 6
            shita(8) = 6
            shita(9) = 6
            shita(10) = 6
            shita(11) = 6
            shita(12) = 6
            shita(13) = 6
            shita(14) = 6
            shita(15) = 6
            shitb(0) = 6
            shitb(1) = 7
            shitb(2) = 7
            shitb(3) = 7
            shitb(4) = 7
            shitb(5) = 7
            shitb(6) = 7
            shitb(7) = 7
            shitb(8) = 7
            shitb(9) = 7
            shitb(10) = 7
            shitb(11) = 7
            shitb(12) = 7
            shitb(13) = 7
            shitb(14) = 7
            shitb(15) = 6
            shitc(0) = 6
            shitc(1) = 7
            shitc(2) = 7
            shitc(3) = 7
            shitc(4) = 7
            shitc(5) = 8
            shitc(6) = 7
            shitc(7) = 7
            shitc(8) = 7
            shitc(9) = 7
            shitc(10) = 7
            shitc(11) = 4
            shitc(12) = 7
            shitc(13) = 7
            shitc(14) = 7
            shitc(15) = 6
            shitd(0) = 6
            shitd(1) = 7
            shitd(2) = 7
            shitd(3) = 7
            shitd(4) = 7
            shitd(5) = 7
            shitd(6) = 7
            shitd(7) = 7
            shitd(8) = 7
            shitd(9) = 7
            shitd(10) = 7
            shitd(11) = 7
            shitd(12) = 7
            shitd(13) = 7
            shitd(14) = 7
            shitd(15) = 6
            shite(0) = 6
            shite(1) = 6
            shite(2) = 6
            shite(3) = 6
            shite(4) = 6
            shite(5) = 6
            shite(6) = 6
            shite(7) = 6
            shite(8) = 6
            shite(9) = 6
            shite(10) = 6
            shite(11) = 6
            shite(12) = 6
            shite(13) = 6
            shite(14) = 6
            shite(15) = 6
            shitf(0) = 6
            shitf(1) = 6
            shitf(2) = 6
            shitf(3) = 6
            shitf(4) = 6
            shitf(5) = 6
            shitf(6) = 6
            shitf(7) = 6
            shitf(8) = 6
            shitf(9) = 6
            shitf(10) = 6
            shitf(11) = 6
            shitf(12) = 6
            shitf(13) = 6
            shitf(14) = 6
            shitf(15) = 6
            shitg(0) = 6
            shitg(1) = 6
            shitg(2) = 6
            shitg(3) = 6
            shitg(4) = 6
            shitg(5) = 6
            shitg(6) = 6
            shitg(7) = 6
            shitg(8) = 6
            shitg(9) = 6
            shitg(10) = 6
            shitg(11) = 6
            shitg(12) = 6
            shitg(13) = 6
            shitg(14) = 6
            shitg(15) = 6
            shith(0) = 6
            shith(1) = 6
            shith(2) = 6
            shith(3) = 6
            shith(4) = 6
            shith(5) = 6
            shith(6) = 6
            shith(7) = 6
            shith(8) = 6
            shith(9) = 6
            shith(10) = 6
            shith(11) = 6
            shith(12) = 6
            shith(13) = 6
            shith(14) = 6
            shith(15) = 6
            shiti(0) = 6
            shiti(1) = 6
            shiti(2) = 6
            shiti(3) = 6
            shiti(4) = 6
            shiti(5) = 6
            shiti(6) = 6
            shiti(7) = 6
            shiti(8) = 6
            shiti(9) = 6
            shiti(10) = 6
            shiti(11) = 6
            shiti(12) = 6
            shiti(13) = 6
            shiti(14) = 6
            shiti(15) = 6
            shitj(0) = 6
            shitj(1) = 6
            shitj(2) = 6
            shitj(3) = 6
            shitj(4) = 6
            shitj(5) = 6
            shitj(6) = 6
            shitj(7) = 6
            shitj(8) = 6
            shitj(9) = 6
            shitj(10) = 6
            shitj(11) = 6
            shitj(12) = 6
            shitj(13) = 6
            shitj(14) = 6
            shitj(15) = 6
            shit(0) = 1
            shit(2) = 1
            shit(3) = 1
        CASE 6
            shita(0) = 6
            shita(1) = 6
            shita(2) = 6
            shita(3) = 6
            shita(4) = 6
            shita(5) = 6
            shita(6) = 6
            shita(7) = 6
            shita(8) = 6
            shita(9) = 6
            shita(10) = 6
            shita(11) = 6
            shita(12) = 6
            shita(13) = 6
            shita(14) = 6
            shita(15) = 6
            shitb(0) = 6
            shitb(1) = 7
            shitb(2) = 7
            shitb(3) = 7
            shitb(4) = 7
            shitb(5) = 7
            shitb(6) = 7
            shitb(7) = 7
            shitb(8) = 7
            shitb(9) = 7
            shitb(10) = 7
            shitb(11) = 7
            shitb(12) = 7
            shitb(13) = 7
            shitb(14) = 7
            shitb(15) = 6
            shitc(0) = 6
            shitc(1) = 7
            shitc(2) = 7
            shitc(3) = 7
            shitc(4) = 7
            shitc(5) = 7
            shitc(6) = 7
            shitc(7) = 7
            shitc(8) = 7
            shitc(9) = 7
            shitc(10) = 7
            shitc(11) = 7
            shitc(12) = 7
            shitc(13) = 7
            shitc(14) = 7
            shitc(15) = 6
            shitd(0) = 6
            shitd(1) = 7
            shitd(2) = 7
            shitd(3) = 7
            shitd(4) = 7
            shitd(5) = 9
            shitd(6) = 9
            shitd(7) = 9
            shitd(8) = 9
            shitd(9) = 9
            shitd(10) = 7
            shitd(11) = 7
            shitd(12) = 7
            shitd(13) = 7
            shitd(14) = 7
            shitd(15) = 6
            shite(0) = 6
            shite(1) = 7
            shite(2) = 7
            shite(3) = 7
            shite(4) = 7
            shite(5) = 9
            shite(6) = 6
            shite(7) = 6
            shite(8) = 6
            shite(9) = 9
            shite(10) = 7
            shite(11) = 7
            shite(12) = 7
            shite(13) = 7
            shite(14) = 7
            shite(15) = 6
            shitf(0) = 6
            shitf(1) = 7
            shitf(2) = 7
            shitf(3) = 7
            shitf(4) = 7
            shitf(5) = 9
            shitf(6) = 6
            shitf(7) = 4
            shitf(8) = 6
            shitf(9) = 9
            shitf(10) = 7
            shitf(11) = 6
            shitf(12) = 6
            shitf(13) = 6
            shitf(14) = 6
            shitf(15) = 6
            shitg(0) = 6
            shitg(1) = 7
            shitg(2) = 8
            shitg(3) = 7
            shitg(4) = 7
            shitg(5) = 9
            shitg(6) = 6
            shitg(7) = 6
            shitg(8) = 6
            shitg(9) = 9
            shitg(10) = 7
            shitg(11) = 6
            shitg(12) = 7
            shitg(13) = 7
            shitg(14) = 7
            shitg(15) = 6
            shith(0) = 6
            shith(1) = 7
            shith(2) = 7
            shith(3) = 7
            shith(4) = 7
            shith(5) = 9
            shith(6) = 9
            shith(7) = 9
            shith(8) = 9
            shith(9) = 9
            shith(10) = 7
            shith(11) = 6
            shith(12) = 7
            shith(13) = 8
            shith(14) = 7
            shith(15) = 6
            shiti(0) = 6
            shiti(1) = 7
            shiti(2) = 7
            shiti(3) = 7
            shiti(4) = 7
            shiti(5) = 7
            shiti(6) = 7
            shiti(7) = 7
            shiti(8) = 7
            shiti(9) = 7
            shiti(10) = 7
            shiti(11) = 6
            shiti(12) = 7
            shiti(13) = 7
            shiti(14) = 7
            shiti(15) = 6
            shitj(0) = 6
            shitj(1) = 6
            shitj(2) = 6
            shitj(3) = 6
            shitj(4) = 6
            shitj(5) = 6
            shitj(6) = 6
            shitj(7) = 6
            shitj(8) = 6
            shitj(9) = 6
            shitj(10) = 6
            shitj(11) = 6
            shitj(12) = 6
            shitj(13) = 6
            shitj(14) = 6
            shitj(15) = 6
            shit(0) = 1
            shit(2) = 2
            shit(3) = 2
        CASE 7
            shita(0) = 6
            shita(1) = 6
            shita(2) = 6
            shita(3) = 6
            shita(4) = 6
            shita(5) = 6
            shita(6) = 6
            shita(7) = 6
            shita(8) = 6
            shita(9) = 6
            shita(10) = 6
            shita(11) = 6
            shita(12) = 6
            shita(13) = 6
            shita(14) = 6
            shita(15) = 6
            shitb(0) = 6
            shitb(1) = 9
            shitb(2) = 9
            shitb(3) = 9
            shitb(4) = 9
            shitb(5) = 9
            shitb(6) = 7
            shitb(7) = 4
            shitb(8) = 7
            shitb(9) = 9
            shitb(10) = 9
            shitb(11) = 9
            shitb(12) = 9
            shitb(13) = 9
            shitb(14) = 9
            shitb(15) = 6
            shitc(0) = 6
            shitc(1) = 9
            shitc(2) = 9
            shitc(3) = 9
            shitc(4) = 9
            shitc(5) = 9
            shitc(6) = 7
            shitc(7) = 7
            shitc(8) = 7
            shitc(9) = 9
            shitc(10) = 9
            shitc(11) = 9
            shitc(12) = 9
            shitc(13) = 9
            shitc(14) = 9
            shitc(15) = 6
            shitd(0) = 6
            shitd(1) = 9
            shitd(2) = 9
            shitd(3) = 9
            shitd(4) = 9
            shitd(5) = 9
            shitd(6) = 9
            shitd(7) = 9
            shitd(8) = 9
            shitd(9) = 9
            shitd(10) = 9
            shitd(11) = 9
            shitd(12) = 9
            shitd(13) = 9
            shitd(14) = 9
            shitd(15) = 6
            shite(0) = 6
            shite(1) = 6
            shite(2) = 6
            shite(3) = 6
            shite(4) = 6
            shite(5) = 6
            shite(6) = 6
            shite(7) = 6
            shite(8) = 6
            shite(9) = 6
            shite(10) = 6
            shite(11) = 6
            shite(12) = 6
            shite(13) = 6
            shite(14) = 6
            shite(15) = 6
            shitf(0) = 6
            shitf(1) = 9
            shitf(2) = 9
            shitf(3) = 9
            shitf(4) = 9
            shitf(5) = 9
            shitf(6) = 9
            shitf(7) = 9
            shitf(8) = 9
            shitf(9) = 9
            shitf(10) = 9
            shitf(11) = 9
            shitf(12) = 9
            shitf(13) = 9
            shitf(14) = 9
            shitf(15) = 6
            shitg(0) = 6
            shitg(1) = 7
            shitg(2) = 7
            shitg(3) = 7
            shitg(4) = 7
            shitg(5) = 7
            shitg(6) = 7
            shitg(7) = 7
            shitg(8) = 7
            shitg(9) = 9
            shitg(10) = 7
            shitg(11) = 7
            shitg(12) = 7
            shitg(13) = 7
            shitg(14) = 7
            shitg(15) = 6
            shith(0) = 6
            shith(1) = 7
            shith(2) = 7
            shith(3) = 7
            shith(4) = 7
            shith(5) = 8
            shith(6) = 7
            shith(7) = 7
            shith(8) = 7
            shith(9) = 9
            shith(10) = 7
            shith(11) = 8
            shith(12) = 8
            shith(13) = 8
            shith(14) = 7
            shith(15) = 6
            shiti(0) = 6
            shiti(1) = 7
            shiti(2) = 7
            shiti(3) = 7
            shiti(4) = 7
            shiti(5) = 7
            shiti(6) = 7
            shiti(7) = 7
            shiti(8) = 7
            shiti(9) = 9
            shiti(10) = 7
            shiti(11) = 7
            shiti(12) = 7
            shiti(13) = 7
            shiti(14) = 7
            shiti(15) = 6
            shitj(0) = 6
            shitj(1) = 6
            shitj(2) = 6
            shitj(3) = 6
            shitj(4) = 6
            shitj(5) = 6
            shitj(6) = 6
            shitj(7) = 6
            shitj(8) = 6
            shitj(9) = 6
            shitj(10) = 6
            shitj(11) = 6
            shitj(12) = 6
            shitj(13) = 6
            shitj(14) = 6
            shitj(15) = 6
            shit(0) = 1
            shit(2) = 1
            shit(3) = 7
        CASE 8
            shita(0) = 6
            shita(1) = 6
            shita(2) = 6
            shita(3) = 6
            shita(4) = 6
            shita(5) = 6
            shita(6) = 6
            shita(7) = 6
            shita(8) = 6
            shita(9) = 6
            shita(10) = 6
            shita(11) = 6
            shita(12) = 6
            shita(13) = 6
            shita(14) = 6
            shita(15) = 6
            shitb(0) = 6
            shitb(1) = 6
            shitb(2) = 6
            shitb(3) = 6
            shitb(4) = 7
            shitb(5) = 7
            shitb(6) = 7
            shitb(7) = 6
            shitb(8) = 7
            shitb(9) = 7
            shitb(10) = 7
            shitb(11) = 7
            shitb(12) = 7
            shitb(13) = 7
            shitb(14) = 7
            shitb(15) = 6
            shitc(0) = 6
            shitc(1) = 6
            shitc(2) = 6
            shitc(3) = 6
            shitc(4) = 7
            shitc(5) = 8
            shitc(6) = 7
            shitc(7) = 6
            shitc(8) = 7
            shitc(9) = 7
            shitc(10) = 7
            shitc(11) = 7
            shitc(12) = 7
            shitc(13) = 7
            shitc(14) = 7
            shitc(15) = 6
            shitd(0) = 6
            shitd(1) = 6
            shitd(2) = 6
            shitd(3) = 6
            shitd(4) = 7
            shitd(5) = 7
            shitd(6) = 7
            shitd(7) = 6
            shitd(8) = 7
            shitd(9) = 7
            shitd(10) = 7
            shitd(11) = 7
            shitd(12) = 7
            shitd(13) = 7
            shitd(14) = 7
            shitd(15) = 6
            shite(0) = 6
            shite(1) = 6
            shite(2) = 6
            shite(3) = 6
            shite(4) = 6
            shite(5) = 6
            shite(6) = 6
            shite(7) = 6
            shite(8) = 7
            shite(9) = 7
            shite(10) = 7
            shite(11) = 7
            shite(12) = 7
            shite(13) = 7
            shite(14) = 7
            shite(15) = 6
            shitf(0) = 6
            shitf(1) = 6
            shitf(2) = 6
            shitf(3) = 6
            shitf(4) = 7
            shitf(5) = 7
            shitf(6) = 7
            shitf(7) = 7
            shitf(8) = 8
            shitf(9) = 7
            shitf(10) = 7
            shitf(11) = 9
            shitf(12) = 9
            shitf(13) = 9
            shitf(14) = 9
            shitf(15) = 6
            shitg(0) = 6
            shitg(1) = 6
            shitg(2) = 6
            shitg(3) = 6
            shitg(4) = 7
            shitg(5) = 7
            shitg(6) = 7
            shitg(7) = 7
            shitg(8) = 7
            shitg(9) = 7
            shitg(10) = 7
            shitg(11) = 9
            shitg(12) = 9
            shitg(13) = 9
            shitg(14) = 9
            shitg(15) = 6
            shith(0) = 6
            shith(1) = 6
            shith(2) = 6
            shith(3) = 6
            shith(4) = 7
            shith(5) = 7
            shith(6) = 7
            shith(7) = 7
            shith(8) = 7
            shith(9) = 7
            shith(10) = 7
            shith(11) = 9
            shith(12) = 9
            shith(13) = 9
            shith(14) = 8
            shith(15) = 6
            shiti(0) = 6
            shiti(1) = 6
            shiti(2) = 6
            shiti(3) = 6
            shiti(4) = 7
            shiti(5) = 7
            shiti(6) = 7
            shiti(7) = 7
            shiti(8) = 7
            shiti(9) = 7
            shiti(10) = 7
            shiti(11) = 9
            shiti(12) = 9
            shiti(13) = 8
            shiti(14) = 4
            shiti(15) = 6
            shitj(0) = 6
            shitj(1) = 6
            shitj(2) = 6
            shitj(3) = 6
            shitj(4) = 6
            shitj(5) = 6
            shitj(6) = 6
            shitj(7) = 6
            shitj(8) = 6
            shitj(9) = 6
            shitj(10) = 6
            shitj(11) = 6
            shitj(12) = 6
            shitj(13) = 6
            shitj(14) = 6
            shitj(15) = 6
            shit(0) = 1
            shit(2) = 5
            shit(3) = 7
        CASE 9
            shita(0) = 6
            shita(1) = 6
            shita(2) = 6
            shita(3) = 6
            shita(4) = 6
            shita(5) = 6
            shita(6) = 6
            shita(7) = 6
            shita(8) = 6
            shita(9) = 6
            shita(10) = 6
            shita(11) = 6
            shita(12) = 6
            shita(13) = 6
            shita(14) = 6
            shita(15) = 6
            shitb(0) = 6
            shitb(1) = 7
            shitb(2) = 7
            shitb(3) = 7
            shitb(4) = 6
            shitb(5) = 9
            shitb(6) = 7
            shitb(7) = 7
            shitb(8) = 7
            shitb(9) = 7
            shitb(10) = 7
            shitb(11) = 7
            shitb(12) = 7
            shitb(13) = 7
            shitb(14) = 7
            shitb(15) = 6
            shitc(0) = 6
            shitc(1) = 7
            shitc(2) = 7
            shitc(3) = 7
            shitc(4) = 6
            shitc(5) = 9
            shitc(6) = 7
            shitc(7) = 7
            shitc(8) = 7
            shitc(9) = 7
            shitc(10) = 7
            shitc(11) = 7
            shitc(12) = 7
            shitc(13) = 7
            shitc(14) = 7
            shitc(15) = 6
            shitd(0) = 6
            shitd(1) = 7
            shitd(2) = 7
            shitd(3) = 7
            shitd(4) = 6
            shitd(5) = 9
            shitd(6) = 7
            shitd(7) = 7
            shitd(8) = 7
            shitd(9) = 7
            shitd(10) = 7
            shitd(11) = 7
            shitd(12) = 7
            shitd(13) = 7
            shitd(14) = 7
            shitd(15) = 6
            shite(0) = 6
            shite(1) = 7
            shite(2) = 7
            shite(3) = 7
            shite(4) = 6
            shite(5) = 9
            shite(6) = 7
            shite(7) = 7
            shite(8) = 7
            shite(9) = 7
            shite(10) = 8
            shite(11) = 7
            shite(12) = 7
            shite(13) = 7
            shite(14) = 7
            shite(15) = 6
            shitf(0) = 6
            shitf(1) = 7
            shitf(2) = 8
            shitf(3) = 7
            shitf(4) = 6
            shitf(5) = 9
            shitf(6) = 7
            shitf(7) = 7
            shitf(8) = 7
            shitf(9) = 9
            shitf(10) = 9
            shitf(11) = 9
            shitf(12) = 7
            shitf(13) = 7
            shitf(14) = 7
            shitf(15) = 6
            shitg(0) = 6
            shitg(1) = 7
            shitg(2) = 7
            shitg(3) = 7
            shitg(4) = 6
            shitg(5) = 9
            shitg(6) = 7
            shitg(7) = 7
            shitg(8) = 7
            shitg(9) = 9
            shitg(10) = 8
            shitg(11) = 9
            shitg(12) = 7
            shitg(13) = 7
            shitg(14) = 7
            shitg(15) = 6
            shith(0) = 6
            shith(1) = 6
            shith(2) = 6
            shith(3) = 6
            shith(4) = 6
            shith(5) = 9
            shith(6) = 7
            shith(7) = 7
            shith(8) = 7
            shith(9) = 7
            shith(10) = 7
            shith(11) = 7
            shith(12) = 7
            shith(13) = 7
            shith(14) = 7
            shith(15) = 6
            shiti(0) = 6
            shiti(1) = 6
            shiti(2) = 6
            shiti(3) = 6
            shiti(4) = 6
            shiti(5) = 9
            shiti(6) = 7
            shiti(7) = 7
            shiti(8) = 7
            shiti(9) = 7
            shiti(10) = 7
            shiti(11) = 7
            shiti(12) = 7
            shiti(13) = 7
            shiti(14) = 4
            shiti(15) = 6
            shitj(0) = 6
            shitj(1) = 6
            shitj(2) = 6
            shitj(3) = 6
            shitj(4) = 6
            shitj(5) = 6
            shitj(6) = 6
            shitj(7) = 6
            shitj(8) = 6
            shitj(9) = 6
            shitj(10) = 6
            shitj(11) = 6
            shitj(12) = 6
            shitj(13) = 6
            shitj(14) = 6
            shitj(15) = 6
            shit(0) = 1
            shit(2) = 1
            shit(3) = 1
        CASE 10
            shita(0) = 6
            shita(1) = 6
            shita(2) = 6
            shita(3) = 6
            shita(4) = 6
            shita(5) = 6
            shita(6) = 6
            shita(7) = 6
            shita(8) = 6
            shita(9) = 6
            shita(10) = 6
            shita(11) = 6
            shita(12) = 6
            shita(13) = 6
            shita(14) = 6
            shita(15) = 6
            shitb(0) = 6
            shitb(1) = 7
            shitb(2) = 7
            shitb(3) = 7
            shitb(4) = 7
            shitb(5) = 7
            shitb(6) = 7
            shitb(7) = 7
            shitb(8) = 7
            shitb(9) = 7
            shitb(10) = 7
            shitb(11) = 7
            shitb(12) = 7
            shitb(13) = 7
            shitb(14) = 7
            shitb(15) = 6
            shitc(0) = 6
            shitc(1) = 7
            shitc(2) = 7
            shitc(3) = 7
            shitc(4) = 7
            shitc(5) = 7
            shitc(6) = 7
            shitc(7) = 7
            shitc(8) = 7
            shitc(9) = 7
            shitc(10) = 7
            shitc(11) = 7
            shitc(12) = 7
            shitc(13) = 7
            shitc(14) = 7
            shitc(15) = 6
            shitd(0) = 6
            shitd(1) = 7
            shitd(2) = 7
            shitd(3) = 7
            shitd(4) = 7
            shitd(5) = 7
            shitd(6) = 7
            shitd(7) = 7
            shitd(8) = 7
            shitd(9) = 7
            shitd(10) = 7
            shitd(11) = 7
            shitd(12) = 7
            shitd(13) = 7
            shitd(14) = 7
            shitd(15) = 6
            shite(0) = 6
            shite(1) = 7
            shite(2) = 7
            shite(3) = 7
            shite(4) = 7
            shite(5) = 7
            shite(6) = 7
            shite(7) = 11
            shite(8) = 11
            shite(9) = 7
            shite(10) = 7
            shite(11) = 7
            shite(12) = 7
            shite(13) = 7
            shite(14) = 7
            shite(15) = 6
            shitf(0) = 6
            shitf(1) = 7
            shitf(2) = 7
            shitf(3) = 7
            shitf(4) = 7
            shitf(5) = 7
            shitf(6) = 7
            shitf(7) = 11
            shitf(8) = 11
            shitf(9) = 7
            shitf(10) = 7
            shitf(11) = 7
            shitf(12) = 7
            shitf(13) = 7
            shitf(14) = 7
            shitf(15) = 6
            shitg(0) = 6
            shitg(1) = 7
            shitg(2) = 7
            shitg(3) = 7
            shitg(4) = 7
            shitg(5) = 7
            shitg(6) = 7
            shitg(7) = 7
            shitg(8) = 7
            shitg(9) = 7
            shitg(10) = 7
            shitg(11) = 7
            shitg(12) = 7
            shitg(13) = 7
            shitg(14) = 7
            shitg(15) = 6
            shith(0) = 6
            shith(1) = 7
            shith(2) = 7
            shith(3) = 7
            shith(4) = 7
            shith(5) = 7
            shith(6) = 7
            shith(7) = 7
            shith(8) = 7
            shith(9) = 7
            shith(10) = 7
            shith(11) = 7
            shith(12) = 7
            shith(13) = 7
            shith(14) = 7
            shith(15) = 6
            shiti(0) = 6
            shiti(1) = 7
            shiti(2) = 7
            shiti(3) = 7
            shiti(4) = 7
            shiti(5) = 7
            shiti(6) = 7
            shiti(7) = 7
            shiti(8) = 7
            shiti(9) = 7
            shiti(10) = 7
            shiti(11) = 7
            shiti(12) = 7
            shiti(13) = 7
            shiti(14) = 7
            shiti(15) = 6
            shitj(0) = 6
            shitj(1) = 6
            shitj(2) = 6
            shitj(3) = 6
            shitj(4) = 6
            shitj(5) = 6
            shitj(6) = 6
            shitj(7) = 6
            shitj(8) = 6
            shitj(9) = 6
            shitj(10) = 6
            shitj(11) = 6
            shitj(12) = 6
            shitj(13) = 6
            shitj(14) = 6
            shitj(15) = 6
            shit(0) = 1
            shit(2) = 1
            shit(3) = 1
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
