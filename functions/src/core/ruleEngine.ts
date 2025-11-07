type Answers = {
  stress_level: string;
  diet_quality: string;
  screen_time: string;
  age_group: string;
  lifestyle_factor: string;
};

// weights 
// Mapping : Question -> Answer -> Cause -> Score
// stress_level → bad → { stress: 2, diet: 1 }
const weights: Record<string, Record<string, Record<string, number>>> = {
  stress_level: {
    low: { stress: 0 },
    moderate: { stress: 1 },
    high: { stress: 2 }
  },
  diet_quality: {
    balanced: { nutrition: 0 },
    irregular: { nutrition: 1 },
    deficient: { nutrition: 2 }
  },
  screen_time: {
    "<3h": { sleep_screen: 0 },
    "3–6h": { sleep_screen: 1 },
    ">6h": { sleep_screen: 2 }
  },
  age_group: {
    "18–24": { androgenic: 0 },
    "25–34": { androgenic: 1 },
    "35–44": { androgenic: 2 },
    "45+": { androgenic: 2 }
  },
  lifestyle_factor: {
    tight_hairstyles: { traction: 2 },
    sleep_debt: { sleep_screen: 2 },
    recent_illness: { illness_recovery: 2 },
    "postpartum(≤1yr)": { postpartum: 3 },
    intense_workouts: { nutrition: 1 },
    chemical_treatments: { overuse_chemicals: 2 }
  }
};

// priority list (tie breaking)
const priorityOrder = [
  "postpartum",
  "traction",
  "illness_recovery",
  "overuse_chemicals",
  "androgenic",
  "stress",
  "nutrition",
  "sleep_screen"
];

export function calculateRecommendation(answers: Answers) {
  // start all bucket scores at 0
  const scores: Record<string, number> = {
    stress: 0,
    nutrition: 0,
    sleep_screen: 0,
    androgenic: 0,
    traction: 0,
    postpartum: 0,
    illness_recovery: 0,
    overuse_chemicals: 0
  };

  // apply weights
  for (const key in answers) {
    const ans = answers[key as keyof Answers];
    const effects = weights[key][ans];
    for (const cause in effects) {
      scores[cause] += effects[cause];
    }
  }

  // find primary cause by max score + priority rule
  let primary_cause = priorityOrder[0];
  for (const cause of priorityOrder) {
    if (scores[cause] > scores[primary_cause]) {
      primary_cause = cause;
    }
  }

  return { scores, primary_cause };
}
