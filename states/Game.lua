local love = require"love"

function Game()
    return{
        ball = {
            speed = 400,
            angle = math.rad(math.random(60)),
            radius = 30,
            x = love.graphics.getWidth()/2 ,
            y = love.graphics.getHeight()/2
        },
        player = {
            moveU = false,
            moveD = false,
            speed = 400,
            player_L = {
                active = false,
                x = 60,
                y = 440
            },
            player_R = {
                active = false,
                x = love.graphics.getWidth() - 60,
                y = 440
            }
        },
        points = 0,
        state = {
            paused=false,
            running=true,
            ended=false
        },
        changeGameState = function (self,s)
            self.state["paused"] = (s == "paused")
            self.state["running"] = (s == "running")
            self.state["ended"] = (s == "ended")
        end,
        
        draw = function (self)
            love.graphics.setFont(love.graphics.newFont(24))
            love.graphics.printf(
            "SCORE: "..math.floor(self.points),
            0,
            20,
            love.graphics.getWidth(),
            "center"
            )
            
            love.graphics.rectangle( "fill", (love.graphics.getWidth()/2)-2, 60, 4, love.graphics.getHeight()-60 )
            if self.state["paused"] == true then
                love.graphics.setColor(1,0.5,0.7,0.4)
            else
                love.graphics.setColor(1,0.5,0.7)
            end
            love.graphics.circle("fill",self.ball.x,self.ball.y,self.ball.radius)
            if self.state["paused"] == true then
                love.graphics.setColor(1,1,1,0.4)
            else
                love.graphics.setColor(1,1,1)
            end
            
            love.graphics.rectangle( "fill", self.player.player_L.x, self.player.player_L.y, 20, 120 )--player_L
            love.graphics.rectangle( "fill", self.player.player_R.x, self.player.player_R.y, 20, 120 )--player_R
            if self.state["paused"] == true then
                love.graphics.setFont(love.graphics.newFont(48))
                love.graphics.setColor(1,1,1,1)
                love.graphics.printf(
                "[--PAUSED--]",
                0,
                love.graphics.getHeight()/2,
                love.graphics.getWidth(),
                "center"
                )
            end
        end
    }
end

return Game