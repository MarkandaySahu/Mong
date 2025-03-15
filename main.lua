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
        if ((game.ball.y - game.ball.radius) < 0) or ((game.ball.y + game.ball.radius) > love.graphics.getHeight()) then
            game.ball.angle = math.rad(360) - game.ball.angle
        elseif (game.ball.x - game.ball.radius < game.player.player_L.x) or (game.ball.x + game.ball.radius > game.player.player_R.x) then
            if ((game.player.player_L.y < game.ball.y) and (game.ball.y < game.player.player_L.y + 120)) or ((game.player.player_R.y < game.ball.y) and (game.ball.y < game.player.player_R.y + 120)) then
                game.ball.angle = math.rad(540) - game.ball.angle
            else
                game:changeGameState("ended")
            end
        end
        game.ball.x = game.ball.x + ( dt * game.ball.speed * math.cos(game.ball.angle))
        game.ball.y = game.ball.y - ( dt * game.ball.speed * math.sin(game.ball.angle))
        
        if game.ball.x < love.graphics.getWidth()/2 then
            game.player.player_L.active = true
            game.player.player_R.active = false
        else
            game.player.player_R.active = true
            game.player.player_L.active = false
        end
        
        if game.player.player_L.active == true then--move left player.
            if game.player.moveU then
                game.player.player_L.y = game.player.player_L.y - (game.player.speed * dt)
            end
            if game.player.moveD then
                game.player.player_L.y = game.player.player_L.y + (game.player.speed * dt)
            end
        end
        if game.player.player_R.active == true then--move right player.
            if game.player.moveU then
                game.player.player_R.y = game.player.player_R.y - (game.player.speed * dt)
            end
            if game.player.moveD then
                game.player.player_R.y = game.player.player_R.y + (game.player.speed * dt)
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
    elseif game.state["ended"] == true then
        love.graphics.rectangle( "fill", love.graphics.getWidth()/2-120, love.graphics.getHeight()/2-30, 240, 60 )
        love.graphics.setFont(love.graphics.newFont(16))
        love.graphics.printf(
        "SCORE:"..math.floor(game.points),
        0,
        love.graphics.getHeight()/2 - 90,
        love.graphics.getWidth(),
        "center")
        love.graphics.setFont(love.graphics.newFont(56))
        love.graphics.printf(
        "GAME OVER",
        0,
        love.graphics.getHeight()/2 - 150,
        love.graphics.getWidth(),
        "center")
    end
end