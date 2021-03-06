surface.CreateFont("MainFont", {
    font = "Comic Sans MS",
    size = 40,
    weight = 500,
})
include("shared.lua")

function ENT:Draw()
    self:DrawModel()
    local distance = LocalPlayer():GetPos():Distance(self:GetPos())
    local displayAng = LocalPlayer():EyeAngles()
    local displayPos = self:GetPos() + Vector(0, 0, 80)
    
    if (IsValid(self) and distance < 400) then
        cam.Start3D2D(displayPos, Angle(0, displayAng.y - 90, 90), 0.15) 
            draw.SimpleText( "Munitionshändler", "MainFont", 0 , -35, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
        cam.End3D2D()
    end
end

local function myMenu() --Start
    local randyChat = math.random(1, 3)
    local white = Color(255, 255, 255)

    if randyChat == 1 then
        chat.AddText(white, "Was brauchst du?")
        chat.PlaySound() 
    else
        if randyChat == 2 then
            chat.AddText(white, "Kann man helfen?")
            chat.PlaySound()
        else
            if randyChat == 3 then
                chat.AddText(white, "Pssss. Hier gibts die beste Munition")
                chat.PlaySound()
            else
                return
            end
        end
    end

    local randyVoice = math.random(1, 2)

    if randyVoice == 1 then
        surface.PlaySound("vo/npc/male01/hi01.wav")
    else
        surface.PlaySound("vo/npc/male01/hi02.wav")
    end

    -- vo/npc/male01/letsgo01.wav"
    local frame = vgui.Create("DFrame")
    frame:SetSize(600, 720)
    frame:Center()
    frame:SetVisible(true)
    frame:MakePopup()
    frame:SetTitle("Munitions Verkäufer")

    frame.Paint = function(s, w, h)
        draw.RoundedBox(12, 0, 0, w, h, Color(105, 105, 105, 150)) ---Allgemeines Derma-Menümenü
        draw.RoundedBox(12, 2, 2, w - 4, h - 4, Color(0, 0, 0, 150)) --Das auch nur Außenlinie
        draw.RoundedBox(20, 28, 40, 545, 65, Color(192, 192, 192, 100)) --1
        draw.RoundedBox(20, 28, 130, 545, 65, Color(192, 192, 192, 100)) --2
        draw.RoundedBox(20, 28, 220, 545, 65, Color(192, 192, 192, 100)) --3
        draw.RoundedBox(20, 28, 310, 545, 65, Color(192, 192, 192, 100)) --4
    end

    local Icon1 = vgui.Create("SpawnIcon", frame)
    Icon1:SetPos(30, 40)
    Icon1:SetModel("models/Items/BoxSRounds.mdl")
    Icon1:SetTooltip(nil)
    --Icon1:SetParent(frame)
    local icon2 = vgui.Create("SpawnIcon", frame)
    icon2:SetPos(30, 130)
    icon2:SetModel("models/Items/BoxMRounds.mdl")
    icon2:SetTooltip(nil)
    local icon3 = vgui.Create("SpawnIcon", frame)
    icon3:SetPos(30, 220)
    icon3:SetModel("models/Items/BoxBuckshot.mdl")
    icon3:SetTooltip(nil)
    local icon4 = vgui.Create("SpawnIcon", frame)
    icon4:SetPos(30, 310)
    icon4:SetModel("models/Items/357ammobox.mdl")
    icon4:SetTooltip(nil)
    local button = vgui.Create("DButton", frame) --Button
    button:SetMouseInputEnabled(true)
    button:SetPos(400, 54)
    button:SetSize(90, 35)
    button:SetText("Für 50€ Kaufen")
    local button2 = vgui.Create("DButton", frame)
    button2:SetPos(400, 143)
    button2:SetSize(90, 35)
    button2:SetText("Für 50€ Kaufen")
    button2:SetMouseInputEnabled(true)
    local button3 = vgui.Create("DButton", frame)
    button3:SetPos(400, 233)
    button3:SetSize(90, 35)
    button3:SetText("Für 50€ Kaufen")
    button3:SetMouseInputEnabled(true)
    local button4 = vgui.Create("DButton", frame)
    button4:SetPos(400, 323)
    button4:SetSize(90, 35)
    button4:SetText("Für 50€ Kaufen")
    button4:SetMouseInputEnabled(true)
    local info1 = vgui.Create("DLabel", frame)
    info1:SetText("Pistolen Munition")
    info1:SetTextColor(Color(0, 0, 0))
    info1:SetFont("MainFont")
    info1:SetSize(300, 30)
    info1:SetPos(120, 55)
    local info2 = vgui.Create("DLabel", frame)
    info2:SetText("SMG Munition")
    info2:SetTextColor(Color(0, 0, 0))
    info2:SetFont("MainFont")
    info2:SetSize(300, 30)
    info2:SetPos(120, 145)
    local info3 = vgui.Create("DLabel", frame)
    info3:SetText("Shotgun Munition")
    info3:SetTextColor(Color(0, 0, 0))
    info3:SetFont("MainFont")
    info3:SetSize(300, 40)
    info3:SetPos(120, 230)
    local info4 = vgui.Create("DLabel", frame)
    info4:SetText("Sniper Munition")
    info4:SetTextColor(Color(0, 0, 0))
    info4:SetFont("MainFont")
    info4:SetSize(300, 40)
    info4:SetPos(120, 320)
    local buttonClose = vgui.Create("DButton", frame)
    buttonClose:SetText("Close")
    buttonClose:SetPos(600 - 60, 6)
    buttonClose:SetSize(50, 30)

    net.Receive("npc_voice", function(len, ply)
        local npc_voice_2 = {}
        npc_voice_2[1] = "vo/canals/shanty_go_nag03.wav"
        npc_voice_2[2] = "vo/canals/shanty_go_nag01.wav"
        npc_voice_2[3] = "vo/npc/male01/notthemanithought01.wav"
        surface.PlaySound(table.Random(npc_voice_2))
    end)

    function button:OnMousePressed()
        net.Start("ammo_buy")
        net.WriteString("pistol")
        net.SendToServer()
    end

    function button2:OnMousePressed()
        net.Start("ammo_buy")
        net.WriteString("smg")
        net.SendToServer()
    end

    function button3:OnMousePressed()
        net.Start("ammo_buy")
        net.WriteString("shotgun")
        net.SendToServer()
    end

    function button4:OnMousePressed()
        net.Start("ammo_buy")
        net.WriteString("sniper")
        net.SendToServer()
    end
    function buttonClose:OnMousePressed()
        frame:Close()
        surface.PlaySound("vo/npc/male01/fantastic01.wav")
    end
end
usermessage.Hook("Dermastart", myMenu) 
