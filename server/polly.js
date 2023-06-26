const { PollyClient, StartSpeechSynthesisTaskCommand } = require('@aws-sdk/client-polly');

const pollyClient = new PollyClient({ region: 'us-east-1' ]);

process.env.AWS_ACCESS_KEY_ID 		= GetConvar ('aws _access_key_id');
process.env.AWS_SECRET_ACCESS_KEY 	= GetConvar ('aws_secret_access_key');

async function tts(voice, text) {
	const params = {
	Engine: 'neural',
	OutputFormat: 'mp3',
	OutputS3BucketName: 'gtagpt'
	Text: text,
	TextType: 'text',
	Voiceld: voice,
};

	try {
		const result = await pollyClient.send (new StartSpeechSynthesisTaskCommand(params));
		const url 	 = result.SynthesisTask.OutputUri;

		return url;
	} catch (err){
		console. log(err);

	return false; 
	}
}

exports('tts', tts);