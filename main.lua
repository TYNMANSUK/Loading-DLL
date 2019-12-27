Engine = { 

	getDll = function ( )
		return dir.isGlobal ( "fileLoad" , "xEngine.dll" )
	end;

	drawMenu = function ( )
		-- отрисовка в меню чита игры
		local getTest = createTab ( "Тест" )
		if ( dir.IsElement ( getTest ) ) then

			addText ( getTest , "Testttt" , 1 , nil , nil , nil )
			addButton ( getTest , "Ok" )
			addText ( getTest , "Testttt2" , 1 , nil , nil , nil )
			addButton ( getTest , "lox" )

			local getClick = dir.isButton("down", "root" )

			if ( getClick ) then

				if ( getClick == "0x00011B90" ) then -- button Ok

					print ("hehe")

				end

			end

		end
	end;

	load = function ( )
		-- Заполнение адресов в таблице API
		
		local isGame = Engine.getDll( )

		if ( dir.isProcess("inGame") == isGame.name ) then
			-- dir.hook ( isGame.path , nil , Engine.drawMenu ) -- bug
			dir.hook ( dir.isProcess("inGame") , nil , Engine.drawMenu )
		end

	end;
}