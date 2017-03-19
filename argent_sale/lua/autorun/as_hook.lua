function DropASOnDeath(player, attacker )
	if (player:GetNWInt("player_argent_sale") > 0) then
			local billetsale = ents.Create("as_billet_sale");
			billetsale:SetPos(player:GetPos()+(player:GetUp()*48));		
			billetsale:SetAngles(player:GetAngles());
			billetsale:Spawn();
			billetsale:SetNWInt("amount", player:GetNWInt("player_argent_sale"));
			billetsale:GetPhysicsObject():SetVelocity((billetsale:GetUp()*128)+(billetsale:GetForward()*math.random(-256, 256))+(billetsale:GetRight()*math.random(-128, 128)));
			player:SetNWInt("player_argent_sale", 0);
			player:EmitSound("physics/flesh/flesh_impact_hard3.wav", 70, 100);
			player:SendLua("local tab = {Color(255,255,255),[[Vous êtes mort, vous avez fait tomber vos ]], Color(255,255,255),[["..billetsale:GetNWInt("player_argent_sale").."€]],Color(255,255,255),[[.]]}chat.AddText(unpack(tab))");
		end;
end
hook.Add("PostPlayerDeath", "DropASOnDeath", DropASOnDeath)

TimeForDropMoney = 0
nextSecond = 0
function ThinkDropAS()
	if (CurTime() >= nextSecond) then
		for k,v in pairs (player:GetAll()) do
			if(v:GetNWInt("player_argent_sale") < 0) then
				v:SetNWInt("player_argent_sale", 0)
			end

			if (TimeForDropMoney < 1 ) then
				if (v:GetNWInt("player_argent_sale") >= AS_MoneyMax) then

					TimeForDropMoney = AS_TimeDrop
					DarkRP.notify(v,1,5, "Vous avez fait tombé votre argent sale car vous en avez trop sur vous. ["..math.Round(v:GetNWInt("player_argent_sale") * 0.25).."]")
					MoneyDropASS = ents.Create("desantarp_billet_sale");
					MoneyDropASS:SetPos(v.GetPos()+ (v:GetUp()*48));
					MoneyDropASS:Spawn()
					MoneyDropASS:SetNWInt("amount", v:GetNWInt("player_argent_sale") * AS_DropAmout)
					MoneyDropASS:GetPhysicsObject():SetVelocity((MoneyDropASS:GetForward()*-16)+(MoneyDropASS:GetUp()*8));
				end
			end
		end
	TimeForDropMoney = TimeForDropMoney -1
	nextSecond = CurTime() + 1;
	end;
end
hook.Add("Think", "ThinkDropAS", ThinkDropAS)