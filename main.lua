local love = require"love"
local Game = require"states/Game"

math.randomseed(os.time())



-----------------------------------------------------------------------
function love.load()
    _G.game = Game()
end

function love.keypressed(k)
    if game.state["paused"] == true then
        if k=="space" then
            game:changeGameState("running")
        end
    elseif game.state["running"] == true then
        if k=="space" then
            game:changeGameState("paused")
        end
        if k=="w" then
            game.player.moveU = true
        end
        if k=="s" then
            game.player.moveD = true
        end
    end
end

function love.keyreleased(k)
    if game.state["running"] == true then
        if k=="w" then
            game.player.moveU = false
        end
        if k=="s" then
            game.player.moveD = false
        end
    end
end
-----------------------------------------------------------------------
function love.update(dt)
    if game.state["running"] == true then
        game.points = game.points + dt
        --move the ball
        game.ball.x = game.ball.x + ( dt * game.ball.speed * math.cos(game.ball.angle))
        game.ball.y = game.ball.y + ( dt * game.ball.speed * math.sin(game.ball.angle))
        if game.ball.x < love.graphics.getWidth()/2 then
            game.player.player_L.active = true
            game.player.player_R.active = false
        else
            game.player.player_R.active = true
            game.player.player_L.active = false
        end
        
        if game.player.player_L.active == true then--move left player.
            if game.player.moveU then
                game.player.player_L.y = game.player.player_L.y - (200 * dt)
            end
            if game.player.moveD then
                game.player.player_L.y = game.player.player_L.y + (200 * dt)
            end
        end
        if game.player.player_R.active == true then--move right player.
            if game.player.moveU then
                game.player.player_R.y = game.player.player_R.y - (200 * dt)
            end
            if game.player.moveD then
                game.player.player_R.y = game.player.player_R.y + (200 * dt)
            end
        end
    end
end
-----------------------------------------------------------------------
function love.draw()
    if game.state["paused"] == true then
        love.graphics.setColor(1,1,1,0.4)
        game:draw()
    elseif game.state["running"] == true then
        love.graphics.setColor(1,1,1,1)
        game:draw()
    end
end