local function sumToRec ( n )
	return n == 1024 or sumToRec(n - 1024)
end

Engine = { 

	getDll = function ( )
		return dir.isGlobal ( "fileLoad" , "xEngine.dll" )
	end;

	drawMenu = function ( )
		-- отрисовка меню
		local getTest = createTab ( "Тест", { x = 20 , y = 400})
		if ( dir.IsElement ( getTest ) ) then

			addText ( getTest , "Testttt" , 1 , nil , nil , nil )
			test = addButton ( getTest , "Ok" )
			addText ( getTest , "Testttt2" , 1 , nil , nil , nil )
			test2 = addButton ( getTest , "Close" )

			local getClick = dir.isButton("root" )

			getClick.addEvent("target","click",
				function(button, state)
					debug ( "state" .. state ,1)
					if ( button == test ) then
						debug ("test?" .. button,2)
					elseif ( button == test2 ) then
						debug ("test2?" .. button,3)
					end
				end
			)

			-- test render
			local w,h = dir.screenSize ( )
			getClick.addEvent("onRender",
				function(button)
					rectangle ((w-200)/2,(h-200)/2,200,200,tocolor(0,0,0,100))
					-- тестовая загрузка картинки из интернета ( иногда может быть белый пиксель )
					image ((w-400)/2,(h-800)/2,400,400,"avatars.githubusercontent.com/u/28936977?v=4",tocolor(0,0,0,100))
				end
			)

		end
	end;

	load = function ( )
		-- Заполнение адресов в таблице API
		
		local isGame = Engine.getDll( )
		local isRam = isGame["IsRam"] / 1024

		if isGame == "not" then
			GameQout()
			return
		end

		-- Решение проблем неправильного использования памяти

		if ( isRam / 2 ) < 1.0 then
			dir.hook ( "apd" , "isClearGameLianer" , false )
			dir.hook ( "Ex.dll" , "isClearGameLianer" , false )
			dir.hook ( "debuger" , "log" , "isClearGameLianer" , true , true , nil )
			return
		end

		if ( isGame.String == "Runtime" ) then
			dir.hook( "upd" , "illegalBits" , true, nil ,true, 1024 )
			if ( isGame.String == "PresentationCore" ) then
				if ( isGame.String == "stop" ) then
					local a = 0
					while sumToRec ( isRam ) do
						-- ram bug
						isGame.String["ram"] = a * 1024
						if ( isGame.String["ram"] >= isRam ) then
							dir.hook ( "apd" , "isClearGameLianer" , false )
							dir.hook ( "Ex.dll" , "isClearGameLianer" , false )
							break
						end
					end
				end
				if ( dir.isProcess("inGame") == isGame.String["name"] ) then
					dir.hook ( dir.isProcess("inGame") , nil , Engine.drawMenu(true) )
				end
			end
			return
		end
	end;
}