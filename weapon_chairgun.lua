SWEP.ViewModel			= "models/weapons/v_357.mdl" --first person model 
SWEP.WorldModel			= "models/weapons/w_357.mdl" --third person model

SWEP.ShootSound = Sound( "Metal.SawbladeStick" ) -- shoot sound DUH

-- First LUA file i've ever made 5/01/2021

function SWEP:PrimaryAttack()

self:SetNextPrimaryFire( CurTime() + 0.5 ) 
self:ThrowChair( "models/props/cs_office/Chair_office.mdl" )  -- you may need cs to see this model 
end  -- if you dont to so you can just change the model to a hl2 one

function SWEP:SecondaryAttack()
self:SetNextSecondaryFire( CurTime() + 0.1 )
self:ThrowChair( "models/props_c17/FurnitureChair001a.mdl" ) -- hl2 is cool ngl :) 
end


function SWEP:ThrowChair( model_file ) -- all of this was a pain to edit :( 
local owner = self:GetOwner() 

if ( not owner:IsValid() ) then return end 

self:EmitSound( self.ShootSound ) -- pew pew 

if ( CLIENT ) then return end 

local ent = ents.Create( "prop_physics" ) -- FINALLY IT WORKS 

if ( not ent:IsValid() ) then return end -- welcome to the secret dev thing

ent:SetModel( model_file ) 

local aimvec = owner:GetAimVector() 
local pos = aimvec * 16 -- what
pos:Add( owner:EyePos() ) 

ent:SetPos( pos ) 

ent:SetAngles( owner:EyeAngles() ) -- idk 
ent:Spawn() 

local phys = ent:GetPhysicsObject()
if ( not phys:IsValid() ) then ent:Remove() return end 

aimvec:Mul( 100 ) 
aimvec:Add( VectorRand( -10, 10 ) ) -- thx gmod wiki 
phys:ApplyForceCenter( aimvec ) 

cleanup.add(owner, "props", ent ) 
undo.Create( "Thrown_Chair" ) -- as i said above 
  undo.AddEntity ( ent ) 
  undo.SetPlayer( owner ) 
 undo.Finish() 
 end -- and... it's done 10 minutes of work lol
 
 -- Edited by frgdr62x