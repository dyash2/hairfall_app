// data.ts
export const quizQuestionsData = [
    {
        _id: "stress_level",
        title: "How stressed have you felt in the last 2 weeks?",
        options: [
            { key: "low", label: "Low" },
            { key: "moderate", label: "Moderate" },
            { key: "high", label: "High" }
        ],
        order: 1,
        active: true
    },
    {
        _id: "diet_quality",
        title: "How would you rate your overall diet?",
        options: [
            { key: "balanced", label: "Balanced" },
            { key: "irregular", label: "Irregular" },
            { key: "deficient", label: "Deficient" }
        ],
        order: 2,
        active: true
    },
    {
        _id: "screen_time",
        title: "Average screen time per day?",
        options: [
            { key: "<3h", label: "<3h" },
            { key: "3-6h", label: "3–6h" },
            { key: ">6h", label: ">6h" }
        ],
        order: 3,
        active: true
    },
    {
        _id: "age_group",
        title: "Your age bracket?",
        options: [
            { key: "18-24", label: "18–24" },
            { key: "25-34", label: "25–34" },
            { key: "35-44", label: "35–44" },
            { key: "45+", label: "45+" }
        ],
        order: 4,
        active: true
    },
    {
        _id: "lifestyle_factor",
        title: "Which best describes your routine?",
        options: [
            { key: "tight_hairstyles", label: "Tight Hairstyles" },
            { key: "sleep_debt", label: "Sleep Debt" },
            { key: "recent_illness", label: "Recent Illness" },
            { key: "postpartum", label: "Postpartum (≤1yr)" },
            { key: "intense_workouts", label: "Intense Workouts" },
            { key: "chemical_treatments", label: "Chemical Treatments" }
        ],
        order: 5,
        active: true
    }
];


export const catalogItemsData = [
    { _id: "drug_a", name: "Drug A", type: "drug", copy: "OTC Biotin + Zinc combo", warnings: ["pregnancy", "lactation"] },
    { _id: "drug_b", name: "Drug B", type: "drug", copy: "Topical Minoxidil 2%", warnings: [] },
    { _id: "drug_c", name: "Drug C", type: "drug", copy: "DHT-blocking supplement", warnings: [] },
    { _id: "serum_a", name: "Serum A", type: "serum", copy: "Peptide + Redensyl serum", warnings: [] },
    { _id: "serum_b", name: "Serum B", type: "serum", copy: "Caffeine + Niacinamide scalp tonic", warnings: [] },
    { _id: "serum_c", name: "Serum C", type: "serum", copy: "Anti-breakage serum", warnings: [] },
    { _id: "life_l1", name: "Lifestyle Pack L1", type: "lifestyle", copy: "Sleep hygiene + scalp massage routine", warnings: [] }
];

export const recRuleV1Data = {
    _id: "v1",
    weights: {
        stress_level: { low: {}, moderate: { stress: 1 }, high: { stress: 2 } },
        diet_quality: { balanced: {}, irregular: { nutrition: 1 }, deficient: { nutrition: 2 } },
        screen_time: { "<3h": {}, "3-6h": { sleep_screen: 1 }, ">6h": { sleep_screen: 2 } },
        age_group: { "18-24": {}, "25-34": { androgenic: 1 }, "35-44": { androgenic: 2 }, "45+": { androgenic: 2 } },
        lifestyle_factor: {
            tight_hairstyles: { traction: 2 },
            sleep_debt: { sleep_screen: 2 },
            recent_illness: { illness_recovery: 2 },
            postpartum: { postpartum: 3 },
            intense_workouts: { nutrition: 1 },
            chemical_treatments: { overuse_chemicals: 2 }
        }
    },
    priority: ["postpartum", "traction", "illness_recovery", "overuse_chemicals", "androgenic", "stress", "nutrition", "sleep_screen"],
    mapping: {
        postpartum: ["drug_a", "serum_a", "life_l1"],
        traction: ["serum_b", "life_l1"],
        illness_recovery: ["drug_a", "serum_a"],
        overuse_chemicals: ["serum_c", "life_l1"],
        androgenic: ["drug_c", "serum_b"],
        stress: ["drug_b", "life_l1"],
        nutrition: ["drug_a", "serum_b"],
        sleep_screen: ["serum_a", "life_l1"]
    },
    rationale: {
        postpartum: "support postpartum shedding with gentle actives and routine",
        traction: "reduce tension and stimulate scalp circulation",
        illness_recovery: "replenish deficits and support regrowth",
        overuse_chemicals: "repair barrier and minimize breakage",
        androgenic: "counter DHT pathways and energize follicles",
        stress: "address stress-linked shedding with topical support",
        nutrition: "bridge micronutrient gaps and energize roots",
        sleep_screen: "improve sleep quality and nightly scalp care"
    },
    active: true
};