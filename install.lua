-- Простой пример подгружать DLL сразу в процесс без подкачки

local function insttal ( )

	local isDir = dir.getDirectory ( )

	if ( isDir ) then

		local url = dir.isGlobal ("LoaderData",0x01)

		-- контроль компонентов OutFiles

		local LDR_MODULE = {
			'BeingDebugged';
			'SubSystemData';
			'FastPebLock';
			'SystemReserved';
			'ProcessParameters';
			'ProcessHeap';
			'ProcessStop';
			'ProcessStart';
			'ProcessFile';
			-- 'BaseAddress';
			-- 'ebx';
			-- 'esi';
		}

		local getDownload = dir.download (isDir , url , LDR_MODULE)

		-- при запросе сетевого соединения проверяют список загруженных в процесс dll

		local getSpeed = dir.isGlobal ("LoaderData",0x18)

		local size = dir.isGlobal ( getDownload )

		-- засунуть dll\exe в файловый поток и сделать протект
		dir.setLoad (getDownload, { key = "123456" , urlLock = true , handler = true , DLL = { { "xDemo.dll",1} , {"xEngine.dll",1} } } )
		
		-- Прямой перенос информации
		dir.setMessage ("label_speed", getSpeed[1] .. " " .. getSpeed[2] )
		dir.setMessage ("label_size", size[1] / 1200 )
		dir.setMessage ("label_size_olt", size[2] / 60 * 12 )

		return Engine.load ( )
	end

end