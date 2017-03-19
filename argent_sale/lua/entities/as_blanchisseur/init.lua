AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

--Cops_Job = {"Agent de Police", "Commissaire", "[VIP] Gendarme", "[VIP] RAID", "[VIP] BAC", "Civil Protection"}

PlayerUseNPC = {}


function ENT:Initialize( )
	
	self:SetModel( AS_Model ) -- <-- LE MODEL DE VOTRE NPC
	self:SetHullType( HULL_HUMAN )
	self:SetHullSizeNormal( )
	self:SetNPCState( NPC_STATE_SCRIPT )
	self:SetSolid(  SOLID_BBOX )
	self:CapabilitiesAdd( CAP_ANIMATEDFACE )
	self:SetUseType( SIMPLE_USE )
	self:DropToFloor()
	self:SetMaxYawSpeed( 90 )

	self:SetNWInt("Scary", AS_Scary)

	self:SetNWInt("TimeForDropMoney", AS_TimeDrop)

		local Text = ents.Create("as_blanchisseur_text");
		Text:SetPos(self:GetPos() + Vector(0, 0, 72));
		Text:SetParent(self);
		Text:Spawn();
	
end

function ENT:OnTakeDamage()
	self:SetNWInt("Scary", self:GetNWInt("Scary") -1)
	return true --<-- SI TRUE ALORS VOTRE NPC PREND DES DEGATS
end

function ENT:AcceptInput(name, activator, caller)
	if (!self.nextUse or CurTime() >= self.nextUse) then


		if (name == "Use" and caller:IsPlayer() and (caller:GetNWInt("player_argent_sale") <= 0)) then	
			if not (table.HasValue(Cops_Job, team.GetName(activator:Team()))) then
				caller:SendLua("local tab = {Color(218,218,218,255), [["..AS_Name..": ]], Color(255,255,255), [["..table.Random(AS_not).."]] } chat.AddText(unpack(tab))");
				timer.Simple(0.25, function() self:EmitSound(table.Random(AS_not_sond), 100, 100) end);
			end

		elseif (name == "Use") and (caller:IsPlayer()) and (caller:GetNWInt("player_argent_sale") > 0) then
			if not (table.HasValue(Cops_Job, team.GetName(activator:Team()))) then
				taxeargentsale = math.Round(math.Round(caller:GetNWInt("player_argent_sale")*AS_Taxe))
				--DarkRP.notify(caller,1,5, "Vous avez gagner ["math.Round(caller:GetNWInt("player_argent_sale") - taxe)"] moins la taxe de "..taxe.."€")
				caller:addMoney(math.Round(caller:GetNWInt("player_argent_sale") - taxe));
				caller:SendLua("local tab = {Color(218,218,218,255), [["..AS_Name..": ]], Color(255,255,255), [["..table.Random(AS_yes)..", tient tes ]], Color(128, 255, 128), [["..math.Round(caller:GetNWInt("player_argent_sale") - taxe).."€.]], Color(255,255,255), [[Je t'ai pris "..taxe.."€,il me faut des sous !]] } chat.AddText(unpack(tab))");
				caller:SetNWInt("player_argent_sale", 0); 
				timer.Simple(0.25, function() self:EmitSound(table.Random(AS_yes_sond), 100, 100) end);
				caller:SetNWInt("iftradewithwhite", 1)

			end
		end;

		if (table.HasValue(Cops_Job, team.GetName(activator:Team()))) then
			if (self:GetNWInt("Scary") < 1) then
				self:SetNWInt("Scary", AS_Scary)
				caller:SendLua("local tab = {Color(218,218,218,255), [["..AS_Name..": ]], Color(255,255,255), [[Voilà les noms de mes clients !]] } chat.AddText(unpack(tab))");
				for k, client in pairs( player:GetAll() ) do
					if (client:GetNWInt("iftradewithwhite") == 1 ) then
							caller:SendLua("local tab = {Color(218,218,218,255), [["..AS_Name..": ]], Color(255,255,255), [["..client:Nick().."]] } chat.AddText(unpack(tab))");
							client:SetNWInt("iftradewithwhite", 0)
					end

				end

			else
				caller:SendLua("local tab = {Color(218,218,218,255), [["..AS_Name..": ]], Color(255,255,255), [[Je ne parlerais pas !]] } chat.AddText(unpack(tab))");
			end
		end
		self.nextUse = CurTime() + 1;
	end;

end