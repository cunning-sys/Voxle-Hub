function import(file)
    return loadstring(game:HttpGet('https://raw.githubusercontent.com/cunning-sys/voxle-hub/main/'..file..'.lua'))()
end

import(game.PlaceId)
