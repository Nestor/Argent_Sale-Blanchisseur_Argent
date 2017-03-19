AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
include("shared.lua");

function ENT:Initialize()
	self:SetModel("models/props/cs_assault/Money.mdl");
	self:PhysicsInit(SOLID_VPHYSICS);
	
	self:SetMoveType(MOVETYPE_VPHYSICS);
	self:SetSolid(SOLID_VPHYSICS);
	
	self:SetNWFloat("distance", 256);
	self:SetNWInt("amount", 500);
	self:GetPhysicsObject():SetMass(105);
end;
 
function ENT:SpawnFunction(ply, trace,ennt)
	local ent = ents.Create(ennt);
	ent:SetPos(trace.HitPos + trace.HitNormal * 16);
	ent:Spawn();
	ent:Activate();
     
	return ent;
end;

function ENT:Use(activator, caller)
local curTime = CurTime();
	if (!self.nextUse or curTime >= self.nextUse) then
		activator:SetNWInt("player_argent_sale", activator:GetNWInt("player_argent_sale") + self:GetNWInt("amount"));
		activator:SendLua("local tab = {Color(218,218,218,255), [["..AS_Name..": ]], Color(255,255,255), [[Vous avez rammassé de l'argent sale, il faut me le donner pour pouvoir l'utiliser, trouver moi !]] } chat.AddText(unpack(tab))");
		self:EmitSound("ambient/levels/labs/coinslot1.wav");
		self:Remove();
		self.nextUse = curTime + 1;	
	end;
end;


function ENT:OnTakeDamage(dmginfo)
	self:Remove();
end;

