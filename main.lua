-- Title: MathQuiz
-- Name: Chelsea NF
-- Course: ICS2O/3C
-- This program is a math quiz that asks the user questions.
-------------------------------------------------------------------------------------------------

-- Hide the status bar
display.setStatusBar(display.HiddenStatusBar)

----------------------------------------------------------------------------------
--LOCAL VARIABLES
----------------------------------------------------------------------------------

-- variable for the timer
local totalSeconds = 10
local secondsLeft = 10
local clockText
local countDownTimer

local lives = 3
local heart1
local heart2
local heart3
local heart4
local gameOver

local questionObject
local correctObject
local numericField 
local randomNumber1
local randomNumber2
local userAnswer
local correctAnswer
local incorrectAnswer
local incorrectObject
local randomOperator

-- Background sound
local bkgMusic = audio.loadSound( "Sounds/bkgMusic.mp3" )
local bkgMusicChanel1

----------------------------------------------------------------------------------
--LOCAL FUNCTIONS
----------------------------------------------------------------------------------
local function AskQuestion()
	-- generate 2 random numbers between a max. and a min. number
	randomNumber1 = math.random(1, 20)
	randomNumber2 = math.random(1, 20) 
	randomOperator = math.random(1, 2)
	if (randomOperator==1) then

		correctAnswer = randomNumber1 + randomNumber2

		-- create question in text object
		questionObject.text = randomNumber1 .. " + " .. randomNumber2 .. " = "
		
	elseif (randomOperator==2) then
		 correctAnswer = randomNumber1 - randomNumber2

		 -- create question in text object
		questionObject.text = randomNumber1 .. " - " .. randomNumber2 .. " = "
		if (correctAnswer < 0) then
			correctAnswer = randomNumber2 - randomNumber1
			questionObject.text = randomNumber2 .. " - " .. randomNumber1 .. " = "
		end
	elseif (randomOperator==3) then

		correctAnswer = randomNumber1 * randomNumber2

		-- create question in text object
		questionObject.text = randomNumber1 .. " * " .. randomNumber2 .. " = "

	elseif (randomOperator==4) then

		correctAnswer = randomNumber1 / randomNumber2

		-- create question in text object
		questionObject.text = randomNumber1 .. " / " .. randomNumber2 .. " = "
	end


	


end

local function HideCorrect()
	correctObject.isVisible = false 
	-- When the text is displayed add sound to the program
bkgMusic = audio.play(bkgMusic)

end


---------------------------------------------------------------------------
 local function NumericFieldListener( event )

 	-- User begins editing "numericField"
 	if ( event.phase == "began" ) then

 		-- clear text field
 		event.target.text = ""

 	elseif event.phase == "submitted" then

 		-- when the answer is submitted (enter key is pressed) set user input to user's answer
 		userAnswer = tonumber (event.target.text)

 		-- if the users answer and the correct answer are the same:
 		if (userAnswer == correctAnswer) then
 			correctObject.isVisible = true
 			timer.performWithDelay(2000, HideCorrect)
 			-- clear text field
 			event.target.text = ""
 			secondsLeft = totalSeconds

 			
 		end
 	end
 end

--------------------------------------------------------------------------------
local function UpdateHearts()
	if (lives == 4 ) then
		heart1.isVisible = true
		heart2.isVisible = true
		heart3.isVisible = true
		heart4.isVisible = true
	elseif (lives == 3 ) then 
		heart1.isVisible = false
		heart2.isVisible = true
		heart3.isVisible = true
		heart4.isVisible = true
	elseif (lives == 2 ) then 
		heart1.isVisible = false
		heart2.isVisible = false
		heart3.isVisible = true
		heart4.isVisible = true
	elseif (lives == 1 ) then 
		heart1.isVisible = false
		heart2.isVisible = false
		heart3.isVisible = false
		heart4.isVisible = true
	elseif (lives == 0 ) then
		heart1.isVisible = false
		heart2.isVisible = false
		heart3.isVisible = false
		heart4.isVisible = false
		gameOver.isVisible = true
		
		numericField.isVisible = false
	end
end


----------------------------------------------------------------------------
local function UpdateTime()

	-- decrement the number of seeconds
	secondsLeft = secondsLeft - 1

	-- display the number of seconds left on the clock object
	clockText.text = secondsLeft .. ""

	if (secondsLeft == 0 ) then
		-- reset the number of seconds left
		secondsLeft = totalSeconds
		lives = lives - 1

		AskQuestion()

		UpdateHearts()
		
	end
end

-- function that calls the timer
local function StarterTimer()
	-- create a countdown timer that loops infinitely
	countDownTimer = timer.performWithDelay( 1000, UpdateTime, 0)
end


--------------------------------------------------------------------------------
--OBJECT CREATION
---------------------------------------------------------------------------------
-- create the lives to display on the screen
heart4 = display.newImageRect("Images/heart.png", 100, 100)
heart4.x = display.contentWidth * 7 / 8
heart4.y = display.contentHeight * 1 / 7

heart3 = display.newImageRect("Images/heart.png", 100, 100)
heart3.x = display.contentWidth * 6 / 8
heart3.y = display.contentHeight * 1 / 7

heart2 = display.newImageRect("Images/heart.png", 100, 100)
heart2.x = display.contentWidth * 5 / 8
heart2.y = display.contentHeight * 1 /7

heart1 = display.newImageRect("Images/heart.png", 100, 100)
heart1.x = display.contentWidth * 4 / 8
heart1.y = display.contentHeight * 1 / 7



---------------------------------------------------------------------------------
-- displays a question and sets the colour
questionObject = display.newText( "", display.contentWidth/3, display.contentHeight/2, nil, 50 )
questionObject:setTextColor(255/255, 255/255, 0/255)

-- create the correct text object and make it invisible
correctObject = display.newText( "Correct!", display.contentWidth/2, display.contentHeight*2/3, nil, 50 )
correctObject:setTextColor(255/255, 250/255, 0/255)
correctObject.isVisible = false

-- create the incorrect text object and make it invisible
incorrectObject = display.newText( "Incorrect!", display.contentWidth/2, display.contentHeight*2/3, nil, 50 )
incorrectObject:setTextColor(155/255, 42/255, 198/255)
incorrectObject.isVisible = false

-- create the clock 
clockText = display.newText( secondsLeft .. "", display.contentWidth/8, display.contentHeight/8, nil, 150 )
correctObject:setTextColor(255/255, 250/255, 0/255)

-- create game over
gameOver = display.newImageRect("Images/gameOver.png", display.contentWidth, display.contentHeight)
gameOver.isVisible = false
gameOver.x = 500
gameOver.y = 400

-- Create numeric field
numericField = native.newTextField( display.contentWidth/2, display.contentHeight/2, 150, 80 )
numericField.inputType =  "number"

-- add the event listener for the numeric field
numericField:addEventListener( "userInput", NumericFieldListener )

-------------------------------------------------------------------
-- FUNCTION CALLS
------------------------------------------------------------------

-- call the funtion to ask the question
AskQuestion()

-- call the function to update hearts
UpdateHearts()

-- call the function to  update the timer
UpdateTime()

-- call the function to call the timer
StarterTimer()

-- call the function to hide the correct answer
HideCorrect()


