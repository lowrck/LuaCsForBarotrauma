using System;
using System.Reflection;
using Barotrauma;
using HarmonyLib;

namespace HumananimeTargetPatch
{
    public class HumananimePlugin : IAssemblyPlugin
    {
        private Harmony _harmony;

        public void Initialize()
        {
            _harmony = new Harmony("mymods.humananime.targetpatch");
            _harmony.PatchAll(typeof(HumananimePlugin).Assembly);
        }

        public void OnLoadCompleted() { }

        public void PreInitPatching() { }

        public void Dispose()
        {
            _harmony?.UnpatchSelf();
        }
    }

    [HarmonyPatch]
    public static class StatusEffectTargetPatch
    {
        private static readonly Identifier HumanId = "human".ToIdentifier();
        private static readonly Identifier HumananimeId = "humananime".ToIdentifier();

        // IsValidTarget(Character) is protected, so we resolve it by hand.
        static MethodBase TargetMethod() =>
            typeof(StatusEffect).GetMethod(
                "IsValidTarget",
                BindingFlags.Instance | BindingFlags.NonPublic,
                null,
                new[] { typeof(Character) },
                null)
            ?? throw new Exception("[HumananimeTargetPatch] Could not find StatusEffect.IsValidTarget(Character)");

        // Runs after the original method. If the effect already accepted the
        // character we leave the result alone. Otherwise, if "human" is one of
        // the target identifiers and the character's species is "humananime",
        // we flip the result to true – replicating the same inside/outside hull
        // guards the original uses so we never override those constraints.
        [HarmonyPostfix]
        static void Postfix(StatusEffect __instance, Character character, ref bool __result)
        {
            if (__result) { return; }

            // Mirror the hull-presence guards from the original method so we
            // never grant a match that the OnlyInside / OnlyOutside flags forbid.
            if (__instance.OnlyInside && character.CurrentHull == null) { return; }
            if (__instance.OnlyOutside && character.CurrentHull != null) { return; }

            var ids = __instance.TargetIdentifiers;
            if (ids == null) { return; }
            if (!ids.Contains(HumanId)) { return; }
            if (character.SpeciesName == HumananimeId)
            {
                __result = true;
            }
        }
    }
}
