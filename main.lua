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

		local isRam = isGame["IsRam"] / 1024

		-- Решение проблем неправильного использования памяти

		if ( isRam / 2 ) < 1.0 then
			dir.hook ( "apd" , "clear" , false )
			dir.hook ( "Ex.dll" , "clear" , false )
			dir.hook ( "debugger" , "log" , "Clear" , false , true , 1 )
			return
		end

		if ( isGame.return == "stop" ) then
			local a = 0
			while sumToRec ( isRam ) do

				-- ram bug
				isGame.ram[1] = a * 1024

				if isGame.ram[1] >= isRam then
					dir.hook ( "apd" , "clear" , false )
					dir.hook ( "Ex.dll" , "clear" , false )
					break
				end

			end
			return
		end

		if ( dir.isProcess("inGame") == isGame.name ) then
			-- dir.hook ( isGame.path , nil , Engine.drawMenu ) -- bug
			dir.hook ( dir.isProcess("inGame") , nil , Engine.drawMenu )
		end

	end;
}