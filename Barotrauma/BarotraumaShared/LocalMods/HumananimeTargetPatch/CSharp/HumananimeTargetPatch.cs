using System;
using System.Reflection;
using System.Collections.Immutable;
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
    public static class StatusEffectConstructorPatch
    {
        private static readonly Identifier HumanId = "human".ToIdentifier();
        private static readonly Identifier HumananimeId = "humananime".ToIdentifier();

        // Cache the FieldInfo so we only pay the reflection cost once.
        private static readonly FieldInfo TargetIdentifiersField =
            typeof(StatusEffect).GetField("TargetIdentifiers", BindingFlags.Instance | BindingFlags.Public)
            ?? throw new Exception("[HumananimeTargetPatch] Could not find StatusEffect.TargetIdentifiers");

        // The constructor is protected, so resolve it via AccessTools.
        static MethodBase TargetMethod() =>
            AccessTools.Constructor(typeof(StatusEffect), new[] { typeof(ContentXElement), typeof(string) })
            ?? throw new Exception("[HumananimeTargetPatch] Could not find StatusEffect(ContentXElement, string)");

        // Runs once per StatusEffect instance, right after the constructor has
        // parsed and stored TargetIdentifiers. If "human" is in the set we add
        // "humananime" so every downstream reader of TargetIdentifiers sees it
        // without any per-call overhead.
        [HarmonyPostfix]
        static void Postfix(StatusEffect __instance)
        {
            var ids = __instance.TargetIdentifiers;
            if (ids == null) { return; }
            if (!ids.Contains(HumanId)) { return; }
            if (ids.Contains(HumananimeId)) { return; } // already present, nothing to do

            // ImmutableHashSet.Add returns a new set; we then write it back
            // through reflection because the field is declared readonly.
            TargetIdentifiersField.SetValue(__instance, ids.Add(HumananimeId));
        }
    }
}
