
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

-- Project Specific Modules
require "data.scripts.die"
require "data.scripts.waterBalloons"

-- Scenes
require "data.scripts.scenes.blank"; require "data.scripts.scenes.game"

scenes = {

blank  = {blank,blankReload,blankDie},

game   = {game,gameReload,gameDie},

}