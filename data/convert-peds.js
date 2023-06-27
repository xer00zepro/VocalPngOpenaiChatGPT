const fs = require('fs');

const allPeds = JSON.parse(fs.readFileSync('peds.json'));
const personalities = {
  1: "Aggressive",
  2: "Friendly",
  3: "Calm",
  4: "Generic",
  5: "Confident",
  6: "Energetic",
  7: "Mysterious",
  8: "Witty",
  9: "Charming",
  10: "Sophisticated"
};
const humanPeds = {};

allPeds.forEach((ped) => {
  console.log(`Parsing ${ped.Name}.`);

  const pedType = ped.PedType.toLowerCase();

  if (!['civmale', 'civfemale'].includes(pedType)) {
    return;
  }

  humanPeds[ped.SignedHash] = {
    name: ped.Name,
    gender: (pedType === 'civmale') ? 'Male' : 'Female',
    personality: personalities[ped.Personality] || 'Generic',
  };
});

fs.writeFileSync('human-peds.json', JSON.stringify(humanPeds));

console.log('Done.');
