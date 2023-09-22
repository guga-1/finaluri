-- Define variables
-- Load assets and initialize variables
function love.load()
    platform = love.graphics.newImage("assets/platform.png")
    ball = love.graphics.newImage("assets/ball.png")
    catchSound = love.audio.newSource("assets/pickupCoin.wav", "static")

    platformX = love.graphics.getWidth() / 2 - platform:getWidth() / 2
    platformY = love.graphics.getHeight() - platform:getHeight()
    
    balls = {}
    score = 0
end

-- Update game logic
function love.update(dt)
    -- Spawn a new ball randomly
    if love.math.random(100) < 2 then
        local newBall = {
            x = love.math.random(love.graphics.getWidth() - ball:getWidth()),
            y = 0,
            speed = love.math.random(100, 300)
        }
        table.insert(balls, newBall)
    end

    -- Move the balls downward
    for i, ball in ipairs(balls) do
        ball.y = ball.y + ball.speed * dt

        -- Check for collision with the platform
        if ball.y + ball:getHeight() >= platformY and
           ball.x + ball:getWidth() >= platformX and
           ball.x <= platformX + platform:getWidth() then
            table.remove(balls, i)
            score = score + 1
            love.audio.play(catchSound)
        end

        -- Remove balls that go off-screen
        if ball.y > love.graphics.getHeight() then
            table.remove(balls, i)
        end
    end
end

-- Draw everything on the screen
function love.draw()
    -- Draw the platform
    love.graphics.draw(platform, platformX, platformY)

    -- Draw the balls
    for _, ball in ipairs(balls) do
        love.graphics.draw(ball, ball.x, ball.y)
    end

    -- Display the score
    love.graphics.print("Score: " .. score, 10, 10)
end

-- Move the platform with arrow keys
function love.keypressed(key)
    if key == "left" then
        platformX = platformX - 10
    elseif key == "right" then
        platformX = platformX + 10
    end
end
