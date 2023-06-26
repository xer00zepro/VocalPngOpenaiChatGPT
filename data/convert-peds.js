const fs = require('fs');

const allPeds		= JSON.parse(fs. readFileSync('peds. json ' ));
const personalities = JSON.parse(fs.readFileSync('personalities.json'));
const humanPeds		= {}

allPeds.forEach( (ped) => {
	console.log(`Parsing ${ped.Name}.`);

	const pedType = ped.Pedtype.toLowerCase();

	if (!['civmale', 'civfemale'].includes(pedType)) {
	return;
	}

	humanPeds[ped.SignedHash] = {
		name: ped.Name,
		gender: (pedType === 'civmale') ? 'Male' : 'Female',
		personality: personalities[ped.Personality] ||'Generic',
	};
});

fs.writeFileSync('human-peds.json', JSON.stringify(humanPeds));

console. log('Done.');