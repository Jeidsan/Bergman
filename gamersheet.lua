local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {

        {
            -- gamer0
            x=1,
            y=1,
            width=200,
            height=221,

        },
        {
            -- gamer1
            x=1,
            y=447,
            width=184,
            height=199,

            sourceX = 8,
            sourceY = 0,
            sourceWidth = 200,
            sourceHeight = 221
        },
        {
            -- gamer2
            x=1,
            y=224,
            width=200,
            height=221,

        },
    },

    sheetContentWidth = 202,
    sheetContentHeight = 647
}

SheetInfo.frameIndex =
{

    ["gamer0"] = 1,
    ["gamer1"] = 2,
    ["gamer2"] = 3,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
