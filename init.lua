
-- External Modules
json = require "frameworkScripts.json"

-- Framework Modules
require "frameworkScripts.misc"
require "frameworkScripts.loading"
require "frameworkScripts.shaders"
require "frameworkScripts.mathPlus"
require "frameworkScripts.input"
require "frameworkScripts.sprites"
require "frameworkScripts.particles"
require "frameworkScripts.tiles"
require "frameworkScripts.timer"
require "frameworkScripts.camera"
require "frameworkScripts.audio"
require "frameworkScripts.text"
require "frameworkScripts.buttons"

-- Project Specific Modules
require "data.scripts.shop"

require "data.scripts.die"
require "data.scripts.waterBalloons"
require "data.scripts.nail"
require "data.scripts.radio"

require "data.scripts.fire"
require "data.scripts.lasers"

-- Scenes
require "data.scripts.scenes.blank"; require "data.scripts.scenes.game"; require "data.scripts.scenes.menu"; require "data.scripts.scenes.endScreen"

scenes = {

blank  = {blank,blankReload,blankDie},

game   = {game,gameReload,gameDie},

menu   = {menu,menuReload,menuDie},

endScreen = {endScreen,endScreenReload,endScreenDie}

}