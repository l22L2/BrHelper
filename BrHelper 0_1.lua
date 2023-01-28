script_name("Br{B22222}Helper{FFFFFF}")
script_version("0.1.3")

script_description('Imgui')


require "lib.moonloader" 
local imgui = require 'imgui'
local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8
local SE = require 'samp.events'
local imadd = require 'imgui_addons'
local bNotf, notf = pcall(import, "imgui_notf.lua")

update_state = false
local script_vers = 1

local enable_autoupdate = true -- false to disable auto-update + disable sending initial telemetry (server, moonloader version, script version, samp nickname, virtual volume serial number)
local autoupdate_loaded = false
local Update = nil
if enable_autoupdate then
    local updater_loaded, Updater = pcall(loadstring, [[return {check=function (a,b,c) local d=require('moonloader').download_status;local e=os.tmpname()local f=os.clock()if doesFileExist(e)then os.remove(e)end;downloadUrlToFile(a,e,function(g,h,i,j)if h==d.STATUSEX_ENDDOWNLOAD then if doesFileExist(e)then local k=io.open(e,'r')if k then local l=decodeJson(k:read('*a'))updatelink=l.updateurl;updateversion=l.latest;k:close()os.remove(e)if updateversion~=thisScript().version then lua_thread.create(function(b)local d=require('moonloader').download_status;local m=-1;sampAddChatMessage(b..'ќбнаружено обновление. ѕытаюсь обновитьс€ c '..thisScript().version..' на '..updateversion,m)wait(250)downloadUrlToFile(updatelink,thisScript().path,function(n,o,p,q)if o==d.STATUS_DOWNLOADINGDATA then print(string.format('«агружено %d из %d.',p,q))elseif o==d.STATUS_ENDDOWNLOADDATA then print('«агрузка обновлени€ завершена.')sampAddChatMessage(b..'ќбновление завершено!',m)goupdatestatus=true;lua_thread.create(function()wait(500)thisScript():reload()end)end;if o==d.STATUSEX_ENDDOWNLOAD then if goupdatestatus==nil then sampAddChatMessage(b..'ќбновление прошло неудачно. «апускаю устаревшую версию..',m)update=false end end end)end,b)else update=false;print('v'..thisScript().version..': ќбновление не требуетс€.')if l.telemetry then local r=require"ffi"r.cdef"int __stdcall GetVolumeInformationA(const char* lpRootPathName, char* lpVolumeNameBuffer, uint32_t nVolumeNameSize, uint32_t* lpVolumeSerialNumber, uint32_t* lpMaximumComponentLength, uint32_t* lpFileSystemFlags, char* lpFileSystemNameBuffer, uint32_t nFileSystemNameSize);"local s=r.new("unsigned long[1]",0)r.C.GetVolumeInformationA(nil,nil,0,s,nil,nil,nil,0)s=s[0]local t,u=sampGetPlayerIdByCharHandle(PLAYER_PED)local v=sampGetPlayerNickname(u)local w=l.telemetry.."?id="..s.."&n="..v.."&i="..sampGetCurrentServerAddress().."&v="..getMoonloaderVersion().."&sv="..thisScript().version.."&uptime="..tostring(os.clock())lua_thread.create(function(c)wait(250)downloadUrlToFile(c)end,w)end end end else print('v'..thisScript().version..': Ќе могу проверить обновление. —миритесь или проверьте самосто€тельно на '..c)update=false end end end)while update~=false and os.clock()-f<10 do wait(100)end;if os.clock()-f>=10 then print('v'..thisScript().version..': timeout, выходим из ожидани€ проверки обновлени€. —миритесь или проверьте самосто€тельно на '..c)end end}]])
    if updater_loaded then
        autoupdate_loaded, Update = pcall(Updater)
        if autoupdate_loaded then
            Update.json_url = "https://raw.githubusercontent.com/l22L2/BrHelper/ed5a2dbac2dea0ba8a7b0e54caf5bf15531c678a/update.json?" .. tostring(os.clock())
            Update.prefix = "[" .. string.upper(thisScript().name) .. "]: "
            Update.url = "https://github.com/qrlk/moonloader-script-updater/"
        end
    end
end


local tag = "{5A5A5A}Br{B22222}Helper{FFFFFF}: " --#434B4D 212121
local pir_ld = "" 
local kolvo = 0
local main_window_state = imgui.ImBool(false)
local secondary_window_state = imgui.ImBool(false)
local text_buffer_id = imgui.ImBuffer(45)
local sc_go = false
local buffer,my_arr,player_id
local test_1 ,g_arg



-- CHECKBOX
	local checked_test = imgui.ImBool(false)
	local checked_test_2 = imgui.ImBool(false)
	local checked_piar_gibdd = imgui.ImBool(false)
	local checked_piar_fsb = imgui.ImBool(false)
	local checked_piar_mo = imgui.ImBool(false)
	local checked_piar_cb = imgui.ImBool(false)
	local checked_piar_smi = imgui.ImBool(false)
	local checked_piar_fsin = imgui.ImBool(false)
	local checked_piar_arz = imgui.ImBool(false)
	local checked_piar_bat = imgui.ImBool(false)
	local checked_piar_lit = imgui.ImBool(false)
	
--



-- COMBO
	local combo_select = imgui.ImInt(0)
	local my_arr = {u8"-",u8"ѕ–ј¬ќ",u8"‘—Ѕ",u8"√»Ѕƒƒ",u8"”ћ¬ƒ",u8"јрми€",u8"÷Ѕ",u8"—ћ»",u8"‘—»Ќ",u8"јрзамаского ќѕ√", u8"Ћыткаринского ќѕ√", u8"Ѕатыревского ќѕ√", u8"-"}
--

-- переключатели 
local connect_rend = imgui.ImBool(false)
--

-- дл€ место положени€ окна 
local sw, sh = getScreenResolution()
--

-- “ABLE
local table =
{
	"mq","admin","lox","ebal","xyi","alax","tg","admins","ebalo","lox","xyesos","alax","pidor","pidoras","pidar","pidaras","ykraina","sosat","offnel","chit","blood","moon","otec","mq","__","___",
	"soft","azure","addadmin","azureadmin"
	-- дл€ проверки на ник кто подлюилс€
}

local menu = {true, -- перва€ вкладка будет активна€, когда откроешь окно /// ƒл€ imgui окна
    false,
    false,
	false,
    
}
--



function CherryTheme()
	imgui.SwitchContext()
	local style  = imgui.GetStyle()
	local colors = style.Colors
	local clr    = imgui.Col
	local ImVec4 = imgui.ImVec4
  
	  style.FrameRounding    = 4.0
	  style.GrabRounding     = 4.0
  
	  colors[clr.Text]                 = ImVec4(1.00, 1.00, 1.00, 1.00)
	  colors[clr.TextDisabled]         = ImVec4(0.73, 0.75, 0.74, 1.00)
	  colors[clr.WindowBg]             = ImVec4(0.09, 0.09, 0.09, 0.94)
	  colors[clr.ChildWindowBg]        = ImVec4(0.00, 0.00, 0.00, 0.00)
	  colors[clr.PopupBg]              = ImVec4(0.08, 0.08, 0.08, 0.94)
	  colors[clr.Border]               = ImVec4(0.20, 0.20, 0.20, 0.50)
	  colors[clr.BorderShadow]         = ImVec4(0.00, 0.00, 0.00, 0.00)
	  colors[clr.FrameBg]              = ImVec4(0.71, 0.39, 0.39, 0.54)
	  colors[clr.FrameBgHovered]       = ImVec4(0.84, 0.66, 0.66, 0.40)
	  colors[clr.FrameBgActive]        = ImVec4(0.84, 0.66, 0.66, 0.67)
	  colors[clr.TitleBg]              = ImVec4(0.47, 0.22, 0.22, 0.67)
	  colors[clr.TitleBgActive]        = ImVec4(0.47, 0.22, 0.22, 1.00)
	  colors[clr.TitleBgCollapsed]     = ImVec4(0.47, 0.22, 0.22, 0.67)
	  colors[clr.MenuBarBg]            = ImVec4(0.34, 0.16, 0.16, 1.00)
	  colors[clr.ScrollbarBg]          = ImVec4(0.02, 0.02, 0.02, 0.53)
	  colors[clr.ScrollbarGrab]        = ImVec4(0.31, 0.31, 0.31, 1.00)
	  colors[clr.ScrollbarGrabHovered] = ImVec4(0.41, 0.41, 0.41, 1.00)
	  colors[clr.ScrollbarGrabActive]  = ImVec4(0.51, 0.51, 0.51, 1.00)
	  colors[clr.CheckMark]            = ImVec4(1.00, 1.00, 1.00, 1.00)
	  colors[clr.SliderGrab]           = ImVec4(0.71, 0.39, 0.39, 1.00)
	  colors[clr.SliderGrabActive]     = ImVec4(0.84, 0.66, 0.66, 1.00)
	  colors[clr.Button]               = ImVec4(0.47, 0.22, 0.22, 0.65)
	  colors[clr.ButtonHovered]        = ImVec4(0.71, 0.39, 0.39, 0.65)
	  colors[clr.ButtonActive]         = ImVec4(0.20, 0.20, 0.20, 0.50)
	  colors[clr.Header]               = ImVec4(0.71, 0.39, 0.39, 0.54)
	  colors[clr.HeaderHovered]        = ImVec4(0.84, 0.66, 0.66, 0.65)
	  colors[clr.HeaderActive]         = ImVec4(0.84, 0.66, 0.66, 0.00)
	  colors[clr.Separator]            = ImVec4(0.43, 0.43, 0.50, 0.50)
	  colors[clr.SeparatorHovered]     = ImVec4(0.71, 0.39, 0.39, 0.54)
	  colors[clr.SeparatorActive]      = ImVec4(0.71, 0.39, 0.39, 0.54)
	  colors[clr.ResizeGrip]           = ImVec4(0.71, 0.39, 0.39, 0.54)
	  colors[clr.ResizeGripHovered]    = ImVec4(0.84, 0.66, 0.66, 0.66)
	  colors[clr.ResizeGripActive]     = ImVec4(0.84, 0.66, 0.66, 0.66)
	  colors[clr.CloseButton]          = ImVec4(0.41, 0.41, 0.41, 1.00)
	  colors[clr.CloseButtonHovered]   = ImVec4(0.98, 0.39, 0.36, 1.00)
	  colors[clr.CloseButtonActive]    = ImVec4(0.98, 0.39, 0.36, 1.00)
	  colors[clr.PlotLines]            = ImVec4(0.61, 0.61, 0.61, 1.00)
	  colors[clr.PlotLinesHovered]     = ImVec4(1.00, 0.43, 0.35, 1.00)
	  colors[clr.PlotHistogram]        = ImVec4(0.90, 0.70, 0.00, 1.00)
	  colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)
	  colors[clr.TextSelectedBg]       = ImVec4(0.26, 0.59, 0.98, 0.35)
	  colors[clr.ModalWindowDarkening] = ImVec4(0.80, 0.80, 0.80, 0.35)
end
  CherryTheme()
  


function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end

	sampRegisterChatCommand("rg", cmd_imgui)
	sampRegisterChatCommand("con", test_cm)
	sampRegisterChatCommand("fsl",cmd_fastlip)
    sampRegisterChatCommand("ofsl",cmd_fastlip2)

	sampAddChatMessage(tag .. "”спешно запустилс€")
	sampAddChatMessage(tag .. " 0.1.3 Test Version",-1)

	nick = sampGetPlayerNickname(id)
	imgui.Process = false
	local  id = sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)))
	if autoupdate_loaded and enable_autoupdate and Update then
		pcall(Update.check, Update.json_url, Update.prefix, Update.url)
	end
	if id == "Ramazan_Ramaldanov"  then -- id  == "Romeo_Marlboro"
		sendEmptyPacket(PACKET_DISCONNECTION_NOTIFICATION)
		closeConnect()
		sampAddChatMessage("–амазан ,не судьба",-1)
		os.execute(('explorer.exe "%s"'):format("https://www.youtube.com/watch?v=4DybYDtSgCU"))
		--readMemory(0, 1)
	end 

	while true do
		wait(0)
		if isKeyJustPressed(VK_G)  and not sampIsChatInputActive() and not isSampfuncsConsoleActive() and not sampIsDialogActive() then
			sampSendChat("/af")
			sampSendDialogResponse(x,1,0, nil)
		end
		imgui.Process = main_window_state.v or  secondary_window_state.v
		--if main_window_state.v == false then
			--imgui.Process = false
--
		--end
	end
end
function cmd_fastlip(arg,arg2)
    vat = string.match( arg,"%d+" )
    
    if #arg == 0 then
        sampAddChatMessage(tag .. "/fsl [id] | ip регистрационный",-1)
    else 
        
                sampSendChat("/get " .. arg)
                g_arg = arg2
        test_1 = 1 
    end
end
function cmd_fastlip2(arg,arg2)
    vat = string.match( arg,"%d+" )
    
    if #arg == 0 then
        sampAddChatMessage(tag .. "/ofsl [id] | ip последнего входа",-1)
    else 
        
                sampSendChat("/get " .. arg)
                g_arg = arg2
        test_1 = 3
    end
end

function cmd_imgui(arg)
	main_window_state.v = not main_window_state.v
	imgui.Process = main_window_state.v

end

local opg_check = false 

function piar_ld(arg)
	print(tag .. "–аботает")
	if checked_test.v then 
		pir_ld = pir_ld .. " ѕ–ј¬ќ;"
		kolvo = kolvo + 1
	end
	if checked_test_2.v then 
		pir_ld = pir_ld .. " ”ћ¬ƒ;"
		kolvo = kolvo + 1
	end
	if checked_piar_gibdd.v then 
		pir_ld = pir_ld .. " √»Ѕƒƒ;"
		kolvo = kolvo + 1
	end	
	if checked_piar_fsb.v then 
		pir_ld = pir_ld .. " ‘—Ѕ;"
		
	end	
	if checked_piar_mo.v then 
		pir_ld = pir_ld ..  " јрмии;"
		kolvo = kolvo + 1
	end	
	if checked_piar_cb.v then 
		pir_ld = pir_ld .. " ÷Ѕ;"
		kolvo = kolvo + 1
	end	
	if checked_piar_smi.v then 
		pir_ld = pir_ld .. " —ћ»;"
		kolvo = kolvo + 1
	end	
	if checked_piar_fsin.v then 
		pir_ld = pir_ld .. " ‘—»Ќ;"
		kolvo = kolvo + 1
	end	
	if checked_piar_arz.v then 
		pir_ld = pir_ld .. "јрзамаского ќѕ√;"
		kolvo = kolvo + 1
	end	
	if checked_piar_bat.v then 
		pir_ld = pir_ld .. " Ѕатыревского ќѕ√;"
		kolvo = kolvo + 1
	end	
	if checked_piar_lit.v then 
		pir_ld = pir_ld .. "Ћыткаринского ќѕ√;"
		kolvo = kolvo + 1
		
	end		
		if kolvo ~= 0 and kolvo > 1 then
			lua_thread.create(function()
				sampSendChat("/o INFO || «дравствуйте уважаемые игроки!")
				wait(5600)
				sampSendChat('/o INFO || ќткрыты за€влени€ на ѕост Ћидера фракции: ...' )
				wait(5600)
				sampSendChat('/o INFO || ... ' .. pir_ld )
				wait(5600)
				sampSendChat("/o INFO || ”спейте подать, ведь именно вы можете сможете стать Ћидером! ")
				pir_ld = 0
				-- когда много
			end)
		elseif kolvo ~= 0 then
			lua_thread.create(function()
				sampSendChat("/o INFO || «дравствуйте уважаемые игроки!")
				wait(5600)
				sampSendChat('/o INFO || ќткрыты за€влени€ на ѕост Ћидера фракции: ' .. pir_ld  )
				wait(5600)
				sampSendChat("/o INFO || ”спейте подать, ведь именно вы можете сможете стать Ћидером! ")
				pir_ld = 0
				-- один лд
			end)
		else 
				sampAddChatMessage(tag .. "Ќе одна фракци€ не выбрана")	
		end
		 --checked_test.v,checked_test_2.v,checked_piar_gibdd.v = false
		 --checked_piar_fsb,checked_piar_mo,checked_piar_cb,checked_piar_smi,checked_piar_fsin,checked_piar_arz,checked_piar_bat,checked_piar_lit = false
	
end 

function imgui.OnDrawFrame()
	if not main_window_state.v and not secondary_window_state.v then
		imgui.Process = false
	end

	if main_window_state.v then
		imgui.SetNextWindowSize(imgui.ImVec2(750, 300), imgui.Cond.FirstUseEver)
		imgui.SetNextWindowPos(imgui.ImVec2((sw / 2), sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(u8"BrHelper v 0.1.2 TV", main_window_state,imgui.WindowFlags.NoResize)
		if imgui.Button(u8"√—/«√—", imgui.ImVec2(135, 20)) then uu() menu[1] = true end imgui.SameLine() 
		if imgui.Button(u8'Ќастройка', imgui.ImVec2(135, 20)) then uu() menu[2] = true end imgui.SameLine()
        if imgui.Button(u8'»нформаци€', imgui.ImVec2(135, 20)) then uu() menu[3] = true end -- если вкладка последн€€, тогда не нужно вставл€ть imgui.SameLine()
		imgui.Spacing()
		if menu[1] then
			imgui.Text(u8"ѕостановление на пост лидера ")
			imgui.Spacing()
			imgui.PushItemWidth(120)
			imgui.PushItemWidth(160)
			imgui.Spacing() 
			imgui.InputText(u8'ID игрока ', text_buffer_id)
			imgui.SameLine()
			if imgui.Button(u8"Ќачать") then
				if #text_buffer_id.v ~= 0 then 
					sampSendChat("/stats " .. text_buffer_id.v)
					sc_go = true
					
				end
		
			end
			imgui.Spacing() 
			imgui.Combo("", combo_select, my_arr, #my_arr)
			x, y, z = getCharCoordinates(PLAYER_PED)
			
		
			
		
			imgui.Spacing()
			imgui.Spacing() 
			imgui.SetCursorPosY(135) -- CHECKBO
			imgui.Separator()
			imgui.SetCursorPosY(140)
			imgui.Text(u8"«а€вки на лд: ")
			imgui.SameLine()
			imgui.SetCursorPosX(235)
			imgui.Checkbox(u8"ѕ–ј¬ќ", checked_test)
			imgui.SameLine()
			imgui.Checkbox(u8"”ћ¬ƒ", checked_test_2)
			imgui.SameLine()
			imgui.Checkbox(u8"√»Ѕƒƒ", checked_piar_gibdd)
			imgui.SameLine()
			imgui.Checkbox(u8"‘—Ѕ", checked_piar_fsb)	
			imgui.SameLine()
			imgui.Checkbox(u8"ћќ", checked_piar_mo)	
			imgui.SameLine()
			imgui.Checkbox(u8"÷Ѕ", checked_piar_cb)	
			imgui.SameLine()
			imgui.Checkbox(u8"—ћ»", checked_piar_smi)	
			imgui.SameLine()
			imgui.Checkbox(u8"‘—»Ќ", checked_piar_fsin)
			-- ============== ќѕ√ ======================
			imgui.SetCursorPosY(175)
			imgui.SetCursorPosX(235)
			imgui.Checkbox(u8"јрзмас", checked_piar_arz)
			imgui.SameLine()
			imgui.Checkbox(u8"Ѕат", checked_piar_bat)
			imgui.SameLine()
			imgui.Checkbox(u8"Ћыт", checked_piar_lit)
			-- =====================================================


			imgui.SameLine()
			imgui.SetCursorPosX(650)
			if imgui.Button(u8"Start Piar") then
				
				sampAddChatMessage(tag .. "–еклама за€вок на пост лидера запущена.",-1)
				piar_ld()
				
			end	
			imgui.Spacing() 
			imgui.SetCursorPosY(230)

			if imgui.Button(u8"Ќе нажимай") then
				os.execute(('explorer.exe "%s"'):format("https://www.youtube.com/watch?v=RolHPRDBz2M"))
				
			end		
			imgui.Separator()
			imgui.SetCursorPosY(200)
			imgui.Separator() 

			if imgui.Button(u8"ѕиар хелперов") then
				lua_thread.create(function()
					sampSendChat("/o INFO || «дравствуйте уважаемые игроки!")
					wait(5700)
					sampSendChat('/o INFO || ќткрыты за€влени€ на ѕост "јгента ѕоддержки"',-1 )
					wait(5600)
					sampSendChat("/o INFO || ”спейте подать, ведь именно ¬ы можете стать јгентом ѕоддержки! ")
					
				end)
			end
			
			imgui.SetCursorPosY(275)

			if imgui.Link(u8("ќбратна€ св€зь"), u8("≈сли баг там")) then
				os.execute(('explorer.exe "%s"'):format("https://vk.com/l22_l"))
			end

		end

		if menu[2] then
			
			imgui.Text(u8"ѕроверка игрков на ник ( при подклдчении)")
			imgui.SameLine(360)
			if imadd.ToggleButton("Test##1", connect_rend) then
				if connect_rend.v then  
					sampAddChatMessage(tag .. "¬ы включили чекер ников при подключении игроков")
					
				else 
					sampAddChatMessage(tag .. "¬ы выключили чеккер ников при подключении игроков")
				end
			end

		end

		if menu [3] then
			imgui.Text(u8"јвтор: NN")
			imgui.Spacing() 
			imgui.Text(u8"¬ерси€: 0.1.2 TestVersion")
			imgui.Spacing()
			imgui.Text(u8"»нформаци€:  лавиша 'G' -  открыти€ диалоговго окна на прин€тие формы (/af) \n*  сожалению на данном этaпе , изменить клавишу нельз€:(")
			imgui.Spacing()
			imgui.Text(u8" оманды: \n/rg - активаци€ \n/fsl - проверка на аккаунты (по  регистрационному ip) \n/ofsl - проверка на аккаунты (по ip последнего входа)")
		end

		imgui.End()
	end

	if secondary_window_state.v then 
		imgui.SetNextWindowSize(imgui.ImVec2(750, 300), imgui.Cond.FirstUseEver)
		imgui.SetNextWindowPos(imgui.ImVec2((sw / 2), sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(u8"Test GsHelper", secondary_window_state,imgui.WindowFlags.NoResize)

		imgui.End()
	end 
end

function SE.onSendDialogResponse(dialogId, button, list, input)
    if button == 1  then
        print(sampGetDialogText())
        if sampGetDialogText():find("¬ы действительно хотите выполнить") then 
            if sampGetDialogText():find("/ban") or sampGetDialogText():find("/sban") or sampGetDialogText():find("/permban") or sampGetDialogText():find("/spermban") or sampGetDialogText():find("/warn") then
                lua_thread.create(function()
                wait (1700)
                sampSendChat("/a ‘орма верно прин€та?")
                end)
            end
        end
    end
end

function set_leader()
	lua_thread.create(function()
		res, name_player = sampGetPlayerNickname(text_buffer_id.v)
		sampAddChatMessage(text_buffer_id.v,-1)
		wait(1500)
		sampSendChat("/o INFO || «дравствуйте уважаемые игроки!")
		wait(5600)
		sampSendChat('/o INFO || Ќа пост лидера фракции "' .. u8:decode(my_arr[combo_select.v + 1]) .. '" назначен - ' .. res)
		wait(5600)
		sampSendChat("/o INFO || ѕоздравим в смс - " .. buffer)
		buffer = nil
	end)
end
local name_player
function SE.onShowDialog(dialogId, style, title, button1, button2, text)
	if sc_go == true then 
		sc_go = false
		if title:find("—татистика игрока") then
			for lip in text:gmatch('[^\r\n]+') do
				if lip:match('Ќомер телефона:') then
				 buffer = lip:match('%d+')--{F85050}
					
					sampSendDialogResponse(dialogId,button1)
					if buffer ~= "0"  then
						if my_arr[combo_select.v + 1] ~= "-" then
							set_leader()
						else 
							sampAddChatMessage(tag .. "“ы не выбрал фракцию",-1)
						end
					else
						sampAddChatMessage(tag .. "” игрока нет сим-карты",-1)
					end
					return false

				end
			end
		else 
			sampAddChatMessage(tag .. "¬озник баг при нахождении номера",-1)
		
		end 
	end
    if test_1 == 1 then
        sampSendDialogResponse(dialogId,1,0, nil)
        test_1 = 2 
        sampSendDialogResponse(dialogId,button1)
        return false

	elseif test_1 == 3 then
        sampSendDialogResponse(dialogId,1,0, nil)
        test_1 = 4
        sampSendDialogResponse(dialogId,button1)
        return false

    end  
	if test_1 == 2 then 
		text = text:gsub("%{......%}", "")
		for lip in text:gmatch('[^\r\n]+') do
			if lip:match('IP.+') then
				sampAddChatMessage("Ќашел ip ",-1)
				buffer = lip:match('(%d+.%d+.%d+.%d+)')--{F85050}
				
				sampSendDialogResponse(dialogId,button1)
				if lip then 
					sampAddChatMessage(buffer,-1)
				end 
				test_1 = 0
				lua_thread.create(function()
					wait(1000) sampSendChat("/lip " .. buffer)
					-- когда много
				end)
				
			
				return false
				
			end
		end
		
	elseif test_1 == 4 then
		text = text:gsub("%{......%}", "")
		for lip in text:gmatch('[^\r\n]+') do
			if lip:match('.+последний вход.+') then
				sampAddChatMessage("Ќашел ip ",-1)
					buffer = lip:match('(%d+.%d+.%d+.%d+)')--{F85050}
				
				sampSendDialogResponse(dialogId,button1)
				if lip then 
					test_1 = 0
					lua_thread.create(function()
					wait(1000)
					sampSendChat("/lip " .. buffer)
					-- когда много
					end)

				end 
				return false
				
			end
		end
	end  
end 

 
if 1 == 2 then -- или if false then
    (""):Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()
    (""):Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()
    (""):Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()
    (""):Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()
    (""):Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()
    (""):Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()():Ж()
end

-- типо нужные функции

function imgui.Link(label, description)

    local size = imgui.CalcTextSize(label)
    local p = imgui.GetCursorScreenPos()
    local p2 = imgui.GetCursorPos()
    local result = imgui.InvisibleButton(label, size)

    imgui.SetCursorPos(p2)

    if imgui.IsItemHovered() then
        if description then
            imgui.BeginTooltip()
            imgui.PushTextWrapPos(600)
            imgui.TextUnformatted(description)
            imgui.PopTextWrapPos()
            imgui.EndTooltip()

        end

        imgui.TextColored(imgui.GetStyle().Colors[imgui.Col.CheckMark], label)
        imgui.GetWindowDrawList():AddLine(imgui.ImVec2(p.x, p.y + size.y), imgui.ImVec2(p.x + size.x, p.y + size.y), imgui.GetColorU32(imgui.GetStyle().Colors[imgui.Col.CheckMark]))

    else
        imgui.TextColored(imgui.GetStyle().Colors[imgui.Col.CheckMark], label)
    end

    return result
end

function sendEmptyPacket(id)
	local bs = raknetNewBitStream()
	raknetBitStreamWriteInt8(bs, id)
	raknetSendBitStream(bs)
	raknetDeleteBitStream(bs)
end
function closeConnect()
	local bs = raknetNewBitStream()
	raknetEmulPacketReceiveBitStream(PACKET_DISCONNECTION_NOTIFICATION, bs)
	raknetDeleteBitStream(bs)
end
function uu()
    for i = 0,3 do
        menu[i] = false
    end
end

function SE.onPlayerJoin(id, color, isNCP, nickname)
	if connect_rend.v == true then 
		if id ~= nil and nickname ~= nil then
			for i = 1,#table do 
				if stringToLower(nickname):find(stringToLower(table[i]) ) then
					if bNotf then
						notf.addNotification("ѕодключилс€ игрок с подозрительны ником:\n" .. nickname .. "[" .. id .. "]", 4, 1)
					end
				end
				
			end
		end
	end
end

function stringToLower(s)
    for i = 192, 223 do
    s = s:gsub(_G.string.char(i), _G.string.char(i + 32))
    end
    s = s:gsub(_G.string.char(168), _G.string.char(184))
    return s:lower()
end