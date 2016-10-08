local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {

        {
            -- bonus1
            x=203,
            y=133,
            width=46,
            height=64,

            sourceX = 9,
            sourceY = 0,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- bonus2
            x=191,
            y=859,
            width=54,
            height=64,

            sourceX = 5,
            sourceY = 0,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- bonus3
            x=203,
            y=1,
            width=48,
            height=64,

            sourceX = 8,
            sourceY = 0,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- bonus4
            x=197,
            y=793,
            width=56,
            height=64,

            sourceX = 4,
            sourceY = 0,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- bonus5
            x=133,
            y=648,
            width=32,
            height=64,

            sourceX = 16,
            sourceY = 0,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- bonus6
            x=203,
            y=67,
            width=48,
            height=64,

            sourceX = 8,
            sourceY = 0,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- bonus7
            x=203,
            y=265,
            width=44,
            height=64,

            sourceX = 10,
            sourceY = 0,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- bonus8
            x=203,
            y=397,
            width=36,
            height=64,

            sourceX = 14,
            sourceY = 0,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- bonus9
            x=203,
            y=331,
            width=44,
            height=64,

            sourceX = 10,
            sourceY = 0,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- bonus10
            x=187,
            y=463,
            width=64,
            height=64,

        },
        {
            -- bonus11
            x=1,
            y=846,
            width=58,
            height=64,

            sourceX = 3,
            sourceY = 0,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- bonus12
            x=203,
            y=199,
            width=46,
            height=64,

            sourceX = 9,
            sourceY = 0,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- bonus13
            x=199,
            y=727,
            width=54,
            height=64,

            sourceX = 5,
            sourceY = 0,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- btnClose
            x=187,
            y=529,
            width=64,
            height=64,

        },
        {
            -- btnDown
            x=187,
            y=595,
            width=64,
            height=64,

        },
        {
            -- btnUp
            x=1,
            y=648,
            width=64,
            height=64,

        },
        {
            -- energy
            x=67,
            y=648,
            width=64,
            height=64,

        },
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
        {
            -- lives
            x=167,
            y=661,
            width=64,
            height=64,

        },
        {
            -- obstacle1
            x=67,
            y=844,
            width=64,
            height=58,

            sourceX = 0,
            sourceY = 3,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- obstacle2
            x=67,
            y=780,
            width=64,
            height=62,

            sourceX = 0,
            sourceY = 1,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- obstacle3
            x=1,
            y=714,
            width=64,
            height=64,

        },
        {
            -- question1
            x=67,
            y=714,
            width=64,
            height=64,

        },
        {
            -- question2
            x=133,
            y=859,
            width=56,
            height=64,

            sourceX = 4,
            sourceY = 0,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- question3
            x=61,
            y=904,
            width=64,
            height=50,

            sourceX = 0,
            sourceY = 7,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- question4
            x=133,
            y=793,
            width=62,
            height=64,

            sourceX = 1,
            sourceY = 0,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- question5
            x=133,
            y=727,
            width=64,
            height=64,

        },
        {
            -- score
            x=1,
            y=780,
            width=64,
            height=64,

        },
    },

    sheetContentWidth = 254,
    sheetContentHeight = 955
}

SheetInfo.frameIndex =
{

    ["bonus1"] = 1,
    ["bonus2"] = 2,
    ["bonus3"] = 3,
    ["bonus4"] = 4,
    ["bonus5"] = 5,
    ["bonus6"] = 6,
    ["bonus7"] = 7,
    ["bonus8"] = 8,
    ["bonus9"] = 9,
    ["bonus10"] = 10,
    ["bonus11"] = 11,
    ["bonus12"] = 12,
    ["bonus13"] = 13,

    ["btnClose"] = 14,
    ["btnDown"] = 15,
    ["btnUp"] = 16,

    ["energy"] = 17,

    ["gamer0"] = 18,
    ["gamer1"] = 19,
    ["gamer2"] = 20,

    ["lives"] = 21,

    ["obstacle1"] = 22,
    ["obstacle2"] = 23,
    ["obstacle3"] = 24,

    ["question1"] = 25,
    ["question2"] = 26,
    ["question3"] = 27,
    ["question4"] = 28,
    ["question5"] = 29,

    ["score"] = 30,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

function SheetInfo:getWidth(index)
  return self.sheet.frames[index].width;
end

function SheetInfo:getHeight(index)
  return self.sheet.frames[index].height;
end

return SheetInfo
