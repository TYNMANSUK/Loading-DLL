local function sumToRec ( n )
	return n == 1024 or sumToRec(n - 1024)
end

Engine = { 

	getDll = function ( )
		return dir.isGlobal ( "fileLoad" , "xEngine.dll" )
	end;

	drawMenu = function ( )
		-- отрисовка в меню чита игры
		local getTest = createTab ( "Тест" )
		if ( dir.IsElement ( getTest ) ) then

			addText ( getTest , "Testttt" , 1 , nil , nil , nil )
			test = addButton ( getTest , "Ok" )
			addText ( getTest , "Testttt2" , 1 , nil , nil , nil )
			test2 = addButton ( getTest , "lox" )

			local getClick = dir.isButton("root" )

			getClick.addEvent("target","click",
				function(button)
					if ( button == test ) then
						iprint ("test?" .. button)
					elseif ( button == test2 ) then
						iprint ("test2?" .. button)
					end
				end
			)

			-- test render
			local w,h = dir.screenSize ( )
			getClick.addEvent("target","render",
				function(button)
					rectangle (h-400,w/2-400/2,400,400,1,1,RGB(0,0,0,100))
				end
			)

		end
	end;

	load = function ( )
		-- Заполнение адресов в таблице API
		
		local isGame = Engine.getDll( )
		local isRam = isGame["IsRam"] / 1024

		-- Решение проблем неправильного использования памяти

		if ( isRam / 2 ) < 1.0 then
			dir.hook ( "apd" , "clear" , false )
			dir.hook ( "Ex.dll" , "clear" , false )
			dir.hook ( "debugger" , "log" , "Clear" , false , true , 1024 )
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
							dir.hook ( "apd" , "clear" , false )
							dir.hook ( "Ex.dll" , "clear" , false )
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