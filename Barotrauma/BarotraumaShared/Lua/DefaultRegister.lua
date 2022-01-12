local function RegisterBarotrauma(typeName)
    return LuaUserData.RegisterType("Barotrauma." .. typeName)
end

local AddCallMetaMember = LuaUserData.AddCallMetaMember

LuaUserData.RegisterType("System.TimeSpan")

if SERVER then
    RegisterBarotrauma("Networking.GameServer")
end

RegisterBarotrauma("CauseOfDeathType")
RegisterBarotrauma("Level+InterestingPosition")
RegisterBarotrauma("Level+PositionType")
RegisterBarotrauma("Networking.TraitorMessageType")
RegisterBarotrauma("SpawnType")
RegisterBarotrauma("Networking.ChatMessageType")
RegisterBarotrauma("InputType")

AddCallMetaMember(RegisterBarotrauma("Job"))
RegisterBarotrauma("JobPrefab")
RegisterBarotrauma("Level")
RegisterBarotrauma("Networking.ServerLog+MessageType")
RegisterBarotrauma("WayPoint")
RegisterBarotrauma("Character")
RegisterBarotrauma("Item")
RegisterBarotrauma("Submarine")
RegisterBarotrauma("Networking.Client")
RegisterBarotrauma("Networking.NetworkConnection")
RegisterBarotrauma("Networking.LidgrenConnection")
RegisterBarotrauma("Networking.SteamP2PConnection")
RegisterBarotrauma("AfflictionPrefab")
RegisterBarotrauma("Affliction")
RegisterBarotrauma("CharacterHealth")
RegisterBarotrauma("AnimController")
RegisterBarotrauma("Limb")
RegisterBarotrauma("Ragdoll")
RegisterBarotrauma("Networking.ChatMessage")
RegisterBarotrauma("CharacterHealth+LimbHealth")
RegisterBarotrauma("AttackResult")
RegisterBarotrauma("Entity")
RegisterBarotrauma("EntitySpawner")
RegisterBarotrauma("MapEntity")
RegisterBarotrauma("MapEntityPrefab")
RegisterBarotrauma("CauseOfDeath")
RegisterBarotrauma("CharacterTeamType")
RegisterBarotrauma("Items.Components.Connection")
RegisterBarotrauma("CharacterInventory")
RegisterBarotrauma("Hull")
RegisterBarotrauma("Gap")
RegisterBarotrauma("PhysicsBody")
RegisterBarotrauma("InvSlotType")
RegisterBarotrauma("ItemPrefab")
RegisterBarotrauma("SerializableProperty")

RegisterBarotrauma("StatusEffect")
RegisterBarotrauma("FireSource")
RegisterBarotrauma("ContentPackage")
RegisterBarotrauma("SubmarineBody")
RegisterBarotrauma("Explosion")
RegisterBarotrauma("Networking.ServerSettings")
RegisterBarotrauma("Inventory")
RegisterBarotrauma("ItemInventory")
AddCallMetaMember(RegisterBarotrauma("FireSource"))

RegisterBarotrauma("Items.Components.Fabricator")
RegisterBarotrauma("Items.Components.ItemComponent")
RegisterBarotrauma("Items.Components.WifiComponent")
RegisterBarotrauma("Items.Components.LightComponent")
RegisterBarotrauma("Items.Components.Holdable")
RegisterBarotrauma("Items.Components.CustomInterface")
RegisterBarotrauma("Items.Components.CustomInterface+CustomInterfaceElement")
RegisterBarotrauma("Items.Components.ItemContainer")
RegisterBarotrauma("Items.Components.PowerContainer")
RegisterBarotrauma("Items.Components.Pickable")
RegisterBarotrauma("Items.Components.Reactor")
RegisterBarotrauma("Items.Components.RelayComponent")
RegisterBarotrauma("Items.Components.MemoryComponent")
RegisterBarotrauma("Items.Components.Engine")
RegisterBarotrauma("Items.Components.Growable")
RegisterBarotrauma("Items.Components.MeleeWeapon")
RegisterBarotrauma("Items.Components.IdCard")
RegisterBarotrauma("Items.Components.Steering")
RegisterBarotrauma("Items.Components.Wire")
RegisterBarotrauma("Items.Components.Turret")
RegisterBarotrauma("Items.Components.Sprayer")
RegisterBarotrauma("Items.Components.SonarTransducer")
RegisterBarotrauma("Items.Components.Powered")
RegisterBarotrauma("Items.Components.PowerTransfer")
RegisterBarotrauma("Items.Components.Planter")
RegisterBarotrauma("Items.Components.OxygenGenerator")
RegisterBarotrauma("Items.Components.OutpostTerminal")
RegisterBarotrauma("Items.Components.Ladder")
RegisterBarotrauma("Items.Components.ElectricalDischarger")
RegisterBarotrauma("Items.Components.Door")
RegisterBarotrauma("Items.Components.DockingPort")
RegisterBarotrauma("Items.Components.Deconstructor")
RegisterBarotrauma("Items.Components.Connection")
RegisterBarotrauma("Items.Components.ConnectionPanel")
RegisterBarotrauma("Items.Components.GeneticMaterial")
RegisterBarotrauma("Items.Components.GrowthSideExtension")
RegisterBarotrauma("Items.Components.ButtonTerminal")
RegisterBarotrauma("Items.Components.Propulsion")
RegisterBarotrauma("Items.Components.Pump")
RegisterBarotrauma("Items.Components.RangedWeapon")
RegisterBarotrauma("Items.Components.Terminal")
RegisterBarotrauma("Items.Components.Throwable")
RegisterBarotrauma("Items.Components.Wearable")
RegisterBarotrauma("Items.Components.SmokeDetector")
RegisterBarotrauma("Items.Components.Repairable")
RegisterBarotrauma("Items.Components.RepairTool")
RegisterBarotrauma("Items.Components.NameTag")
RegisterBarotrauma("Items.Components.LevelResource")

RegisterBarotrauma("AIController")
RegisterBarotrauma("EnemyAIController")
RegisterBarotrauma("HumanAIController")
RegisterBarotrauma("AICharacter")
RegisterBarotrauma("AITarget")
RegisterBarotrauma("AITargetMemory")
RegisterBarotrauma("AIChatMessage")
RegisterBarotrauma("AIObjectiveManager")
RegisterBarotrauma("AITrigger")

AddCallMetaMember(RegisterBarotrauma("AIObjective"))
AddCallMetaMember(RegisterBarotrauma("AIObjectiveChargeBatteries"))
AddCallMetaMember(RegisterBarotrauma("AIObjectiveCleanupItem"))
AddCallMetaMember(RegisterBarotrauma("AIObjectiveCleanupItems"))
AddCallMetaMember(RegisterBarotrauma("AIObjectiveCombat"))
AddCallMetaMember(RegisterBarotrauma("AIObjectiveContainItem"))
AddCallMetaMember(RegisterBarotrauma("AIObjectiveDecontainItem"))
AddCallMetaMember(RegisterBarotrauma("AIObjectiveEscapeHandcuffs"))
AddCallMetaMember(RegisterBarotrauma("AIObjectiveExtinguishFire"))
AddCallMetaMember(RegisterBarotrauma("AIObjectiveExtinguishFires"))
AddCallMetaMember(RegisterBarotrauma("AIObjectiveFightIntruders"))
AddCallMetaMember(RegisterBarotrauma("AIObjectiveFindDivingGear"))
AddCallMetaMember(RegisterBarotrauma("AIObjectiveFindSafety"))
AddCallMetaMember(RegisterBarotrauma("AIObjectiveFixLeak"))
AddCallMetaMember(RegisterBarotrauma("AIObjectiveFixLeaks"))
AddCallMetaMember(RegisterBarotrauma("AIObjectiveGetItem"))
AddCallMetaMember(RegisterBarotrauma("AIObjectiveGoTo"))
AddCallMetaMember(RegisterBarotrauma("AIObjectiveIdle"))
AddCallMetaMember(RegisterBarotrauma("AIObjectiveOperateItem"))
AddCallMetaMember(RegisterBarotrauma("AIObjectiveOperateItem"))
AddCallMetaMember(RegisterBarotrauma("AIObjectivePumpWater"))
AddCallMetaMember(RegisterBarotrauma("AIObjectiveRepairItem"))
AddCallMetaMember(RegisterBarotrauma("AIObjectiveRepairItems"))
AddCallMetaMember(RegisterBarotrauma("AIObjectiveRescue"))
AddCallMetaMember(RegisterBarotrauma("AIObjectiveRescueAll"))
AddCallMetaMember(RegisterBarotrauma("AIObjectiveReturn"))
RegisterBarotrauma("AIObjectiveCombat+CombatMode")

RegisterBarotrauma("TalentPrefab")
RegisterBarotrauma("TalentOption")
RegisterBarotrauma("TalentSubTree")
RegisterBarotrauma("TalentTree")
RegisterBarotrauma("CharacterTalent")
RegisterBarotrauma("Upgrade")
RegisterBarotrauma("UpgradeCategory")
RegisterBarotrauma("UpgradePrefab")
RegisterBarotrauma("UpgradeManager")

RegisterBarotrauma("Screen")
RegisterBarotrauma("GameScreen")
RegisterBarotrauma("GameSession")
RegisterBarotrauma("CampaignMode")

RegisterBarotrauma("DebugConsole+Command")

RegisterBarotrauma("TextManager")

local descriptor = RegisterBarotrauma("NetLobbyScreen")

if SERVER then
    LuaUserData.MakeFieldAccessible(descriptor, "subs")
end

RegisterBarotrauma("Networking.IWriteMessage")
RegisterBarotrauma("Networking.IReadMessage")
RegisterBarotrauma("Networking.ServerPacketHeader")
RegisterBarotrauma("Networking.ClientPacketHeader")
RegisterBarotrauma("Networking.DeliveryMethod")
RegisterBarotrauma("Networking.DeliveryMethod")
RegisterBarotrauma("Networking.NetEntityEvent")
RegisterBarotrauma("Networking.NetEntityEvent+Type")
RegisterBarotrauma("Networking.INetSerializable")
RegisterBarotrauma("Networking.DisconnectReason")
LuaUserData.RegisterType("Lidgren.Network.NetIncomingMessage")

RegisterBarotrauma("Rand+RandSync")
RegisterBarotrauma("Skill")
RegisterBarotrauma("SkillPrefab")
RegisterBarotrauma("TraitorMissionPrefab")
RegisterBarotrauma("TraitorMissionResult")

LuaUserData.RegisterType("FarseerPhysics.Dynamics.World")
LuaUserData.RegisterType("FarseerPhysics.Dynamics.Fixture")
RegisterBarotrauma("Physics")

RegisterBarotrauma("Camera")
RegisterBarotrauma("InputType")
RegisterBarotrauma("Key")

RegisterBarotrauma("PrefabCollection`1[[Barotrauma.ItemPrefab]]")
RegisterBarotrauma("PrefabCollection`1[[Barotrauma.JobPrefab]]")
RegisterBarotrauma("PrefabCollection`1[[Barotrauma.CharacterPrefab]]")
RegisterBarotrauma("PrefabCollection`1[[Barotrauma.AfflictionPrefab]]")
RegisterBarotrauma("PrefabCollection`1[[Barotrauma.TalentPrefab]]")

RegisterBarotrauma("Pair`2[[Barotrauma.JobPrefab],[System.Int32]]")

AddCallMetaMember(RegisterBarotrauma("CharacterInfo"))
AddCallMetaMember(RegisterBarotrauma("Items.Components.Signal"))
AddCallMetaMember(RegisterBarotrauma("SubmarineInfo"))

RegisterBarotrauma("MapCreatures.Behavior.BallastFloraBehavior")
RegisterBarotrauma("MapCreatures.Behavior.BallastFloraBranch")

AddCallMetaMember(LuaUserData.RegisterType("Microsoft.Xna.Framework.Vector2"))
AddCallMetaMember(LuaUserData.RegisterType("Microsoft.Xna.Framework.Vector3"))
AddCallMetaMember(LuaUserData.RegisterType("Microsoft.Xna.Framework.Vector4"))
AddCallMetaMember(LuaUserData.RegisterType("Microsoft.Xna.Framework.Color"))
AddCallMetaMember(LuaUserData.RegisterType("Microsoft.Xna.Framework.Point"))
AddCallMetaMember(LuaUserData.RegisterType("Microsoft.Xna.Framework.Rectangle"))

if SERVER then
RegisterBarotrauma("Networking.ServerPeer")
RegisterBarotrauma("Networking.ServerPeer+PendingClient")

RegisterBarotrauma("Traitor")
RegisterBarotrauma("Traitor+TraitorMission")

elseif CLIENT then

RegisterBarotrauma("Networking.ClientPeer")

RegisterBarotrauma("LuaSetup+LuaGUI")
RegisterBarotrauma("ChatBox")
RegisterBarotrauma("GUICanvas")
RegisterBarotrauma("Anchor")
RegisterBarotrauma("Alignment")
RegisterBarotrauma("Pivot")
RegisterBarotrauma("Key")
RegisterBarotrauma("PlayerInput")

LuaUserData.RegisterType("Microsoft.Xna.Framework.Graphics.Texture2D")
LuaUserData.RegisterType("EventInput.KeyEventArgs")
LuaUserData.RegisterType("Microsoft.Xna.Framework.Input.Keys")

AddCallMetaMember(RegisterBarotrauma("Sprite"))
AddCallMetaMember(RegisterBarotrauma("GUILayoutGroup"))
AddCallMetaMember(RegisterBarotrauma("GUITextBox"))
AddCallMetaMember(RegisterBarotrauma("GUITextBlock"))
AddCallMetaMember(RegisterBarotrauma("GUIButton"))
AddCallMetaMember(RegisterBarotrauma("RectTransform"))
AddCallMetaMember(RegisterBarotrauma("GUIFrame"))
AddCallMetaMember(RegisterBarotrauma("GUITickBox"))
AddCallMetaMember(RegisterBarotrauma("GUICustomComponent"))
AddCallMetaMember(RegisterBarotrauma("GUIImage"))
AddCallMetaMember(RegisterBarotrauma("GUIListBox"))
AddCallMetaMember(RegisterBarotrauma("GUIScrollBar"))
AddCallMetaMember(RegisterBarotrauma("GUIDropDown"))

end