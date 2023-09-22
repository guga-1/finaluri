
function love.load()
    platform = love.graphics.newImage("assets/platform.png")
    ball = love.graphics.newImage("assets/ball.png")
    catchSound = love.audio.newSource("assets/pickupCoin.wav", "static")

    platformX = love.graphics.getWidth() / 2 - platform:getWidth() / 2
    platformY = love.graphics.getHeight() - platform:getHeight()
    
    balls = {}
    score = 0
end


function love.update(dt)
   
    if love.math.random(100) < 2 then
        local newBall = {
            x = love.math.random(love.graphics.getWidth() - ball:getWidth()),
            y = 0,
            speed = love.math.random(100, 300)
        }
        table.insert(balls, newBall)
    end

    
    for i, ball in ipairs(balls) do
        ball.y = ball.y + ball.speed * dt

        
        if ball.y + ball:getHeight() >= platformY and
           ball.x + ball:getWidth() >= platformX and
           ball.x <= platformX + platform:getWidth() then
            table.remove(balls, i)
            score = score + 1
            love.audio.play(catchSound)
        end

       
        if ball.y > love.graphics.getHeight() then
            table.remove(balls, i)
        end
    end
end


function love.draw()
    love.graphics.draw(platform, platformX, platformY)

    
    for _, ball in ipairs(balls) do
        love.graphics.draw(ball, ball.x, ball.y)
    end

    
    love.graphics.print("Score: " .. score, 10, 10)
end


function love.keypressed(key)
    if key == "left" then
        platformX = platformX - 10
    elseif key == "right" then
        platformX = platformX + 10
    end
end
