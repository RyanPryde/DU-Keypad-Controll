rx, ry = getResolution()
cx, cy = getCursor()
click = getCursorPressed()
local font = loadFont('Oxanium-Light', 23)
local NColor = {r=1,g=1,b=1}
local numpad = createLayer()
local json = require('json')
-- Cursor boundary check --
function isCursorIn(x1,y1,x2,y2)
    local cx,cy = getCursor()
    if cx >= x1 and cx <= x2 and cy >= y1 and cy <= y2 then
       return true 
    else 
       return false 
    end
end
--
function set_value(value)
         setOutput(json.encode({ 'datavalue', value }))
end
--
Display_Value = Display_Value or '' -- This initializes the top value as a string

function drawnumpad(layer,nx,ny,nl,nw)
setNextFillColor(layer,0,0,0,0)
setNextStrokeWidth(layer,0.1)
setNextStrokeColor(layer,Shape_Box,1,1,1,1)    
addBox(layer,nx,ny,nl,nw)
    function drawbutton(layer,bx,by,bl,bw,btext,static)
        if isCursorIn(bx,    by,    bx+bl,    by+bw) and not static then 
            setNextFillColor(numpad,NColor.r,NColor.g,NColor.b,0.2)
            if  getCursorDown() then
                setNextFillColor(numpad,NColor.r,NColor.g,NColor.b,0.3)
                end
            if getCursorPressed() then
                if 'C' == btext then
                  Display_Value = '' -- Clears value
                elseif 'SET' == btext then
                    set_value(Display_Value)
                  --setOutput(Display_Value) -- Sets output
                  Display_Value = '' -- Clears value  
                else
                  Display_Value = Display_Value .. btext -- This appends the clicked number to your display
                end
            end 
        end
            addBox(numpad,bx,by,bl,bw)
            setDefaultStrokeWidth(numpad,Shape_Line,0.1)
            setDefaultStrokeColor(numpad,Shape_Line,NColor.r,NColor.g,NColor.b,1) 
            addLine(numpad,bx,by+5,bx,by)
            addLine(numpad,bx,by,bx+5,by)
            addLine(numpad,bx+bl,by+bw-5,bx+bl,by+bw)
            addLine(numpad,bx+bl,by+bw,bx+bl-5,by+bw)
            setDefaultFillColor(layer,Shape_Text,NColor.r*2,NColor.g*2,NColor.b*2,1)        
            addText(layer,font,btext,bx+(bl/2),by+(bw/2))
    end
setDefaultTextAlign(numpad, AlignH_Center, AlignV_Middle)
setDefaultFillColor(numpad,Shape_Box,NColor.r,NColor.g,NColor.b,0.1)
-- Draw Buttons
drawbutton(numpad,nx+(nl/40),ny+(nw/50),nl/1.05,nw/6.5,Display_Value,true) 
drawbutton(numpad,nx+(nl/40),ny+(nw/5),nl/3.5,nw/6,"7")
drawbutton(numpad,nx+(nl/40),ny+(nw/2.5),nl/3.5,nw/6,"4")
drawbutton(numpad,nx+(nl/40),ny+(nw/1.67),nl/3.5,nw/6,"1")
drawbutton(numpad,nx+(nl/40),ny+(nw/1.25),nl/3.5,nw/6,"C")
drawbutton(numpad,nx+(nl/2.8),ny+(nw/5),nl/3.5,nw/6,"8")
drawbutton(numpad,nx+(nl/2.8),ny+(nw/2.5),nl/3.5,nw/6,"5")
drawbutton(numpad,nx+(nl/2.8),ny+(nw/1.675),nl/3.5,nw/6,"2")
drawbutton(numpad,nx+(nl/2.8),ny+(nw/1.25),nl/3.5,nw/6,"0") 
drawbutton(numpad,nx+(nl/1.45),ny+(nw/5),nl/3.5,nw/6,"9")
drawbutton(numpad,nx+(nl/1.45),ny+(nw/2.5),nl/3.5,nw/6,"6")
drawbutton(numpad,nx+(nl/1.45),ny+(nw/1.675),nl/3.5,nw/6,"3")
drawbutton(numpad,nx+(nl/1.45),ny+(nw/1.25),nl/3.5,nw/6,"SET")      
end

drawnumpad(numpad,rx/2-150,0,300,500)
requestAnimationFrame(2)
