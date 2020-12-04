-- Простой пример подгружать DLL сразу в процесс без подкачки

-- eng.lua -- Лучше сразу сделать проверку на лаунчер , и запуск игры

local function insttal ( )

	local isDir = dir.getDirectory ( )

	if ( isDir ) then

		local url = dir.isGlobal ("LoaderData",0x01)

		-- контроль компонентов OutFiles

		local MODULE = {
			{ 'BeingDebugged' , "lowed-0" };
			{ 'SubSystemData' , "rumming" };
			{ 'FastPebLock' , "ram" };
			{ 'SystemReserved' , "fast" };
			{ 'ProcessParameters' , "lowed-10" };
			{ 'ProcessHeap' , "lowed-10" };
			{ 'ProcessStop' , "lowed-10" };
			{ 'ProcessStart' , "lowed-10" };
			{ 'ProcessFile' , "lowed-10" };
		}

		local getDownload = dir.download (isDir , url , MODULE )

		if ( not getDownload ) or ( getDownload ~= "url_error" ) then

			-- при запросе сетевого соединения проверяют список загруженных в процесс dll

			local getSpeed = dir.isGlobal ("LoaderData",0x18)

			local size = dir.isGlobal ( getDownload )

			-- засунуть dll\exe в файловый поток и сделать протект
			dir.setLoad (getDownload, { key = "123456" , urlLock = true , handler = true , DLL = { { "xDemo.dll",1} , {"xEngine.dll",1} } } )
			
			-- Прямой перенос информации
			dir.setMessage ("label_speed", getSpeed[1] .. " " .. getSpeed[2] )
			dir.setMessage ("label_size", size[1] / 1200 )
			dir.setMessage ("label_size_olt", size[2] / 60 * 12 )

			-- Отправляем запрос
			return Engine.load ( )
		end
	end

end