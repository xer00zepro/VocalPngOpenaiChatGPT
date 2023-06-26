Local humanPeds = json.decode(LoadResourceFile(GercurrentresourceName(), 'data/human-peds.json'))

RegisterCommand('chatgpt:transcript',function(source, args, rawCommand)
local data 			= json.decode(string.sub(rawCommand, 21))
local serverId 		= string.match(data.Username, "%[ (%d+)%]")
local transcription = data.Message
local playerState 	= Player (serverId).state
local targetedPed 	= playerState.targetedPed
local pedEntityld 	= NetworkGetEntityFromNetworkId(targetedPed)
local pedModel 		= tostring(GetEntityModel(pedEntityId))

	if not targetedPed or not pedEntityld or not pedModel then
		return
	end

	if not humanPeds[pedMode1] then
		return
	end

	if not transcription or string.len(transcription) < 3 then
		return
	end

	if not conversations[serverId] then
		conversations[serverId] = {}
	end

	Entity(pedEntityId).state:set('isThinking', true, true)

	if not conversations[serverId][targetedPed] then
		setupConversation(serverId, targetedPed, pedModel) 
	end


	generateReponse(serverId, targetedPed, pedModel, transcription)
end)	

--
-- functions
--

function generateReponse(playerId, pedId,  pedModel, message)
	table.insert(conversations[playerId][pedId], {
		role 	= 'user',
		content = message,
	})

	PerformHttpRequest(' https://api.openai.com/v1/chat/completions', function(code , data, headers))
	if code ~= 200 then
		Entity(NetworkGetEntityFromNetworkId(pedId)).state:set('isThinking', false, true)
	end

local data 		= json.decode(data)
local response 	= data.choices[1].message.content 

	table.insert(conversations[playerId][pedId]), {
		role = 'assistant'
		content = response,
	})

	local ttsUrl = exports.chatgpt : tts(Config.Voices[humanPeds][pedModel].gender], response);

	if not ttsUrl then 
		Entity(NetworkGetEntityFromNetworkId(pedId)).state:set('isThinking', false, true)
	end	

	local soundReady = false

	while not soundReady do
		PerformHttpRequest(ttsUrl, function (code)
			if code == 200 then
				soundReady = true
			end
		end, 'GET', nil, {})
	end

	local soundId = exports.sounity:CreateSound(ttsUrl)

	exports.sounity:AttachSound(soundId, pedId) 
	exports .sounity:StartSound(soundId)

Entity(NetworkGetEntityFromNetworkId(pedId)).state:set('isThinking', false, true)
Entity(NetworkGetEntityFromNetworkId(pedId)).state:set('isSpeaking', true, true)

Citizen.SetTimeout (5000, function()
	Entity(NetworkGetEntityFromNetworkId(pedId)).state:set('isSpeaking', false, true)
end)
end, 'POST', json.encode({
	model 	= Config.ChatGPTModel,
	message = conversations[playerId][pedId],
}), {
['content-type']  = 'application/json',
['Authorization'] = ('bear %s'):format(Config.APIKey), 
})


function setupConversation (playerId, pedId, pedModel)

local pedData 		= humanPeds [pedMode1]
local playerState 	= Player (player Id) . state
local currentTime 	= exports.weathersync: getTime ()
local systemPrompt 	= Config.SystemPrompt

local variables = {
	GENDER 			= pedData. gender,
	PERSONALITY 	= pedData.personality,
	TIME_HOUR 		= currentTime. hour,
	TIME_MINUTE 	= currentTime. minute,
	WEATHER 		= exports .weathersync: getWeather),
	STREET 			= playerState.curStreetName or 'Unknown',
	CROSS_STREET 	= playerState.curCrossStreetName or 'Unknown'
}

for k,v in pairs (variables) do
	systemPrompt = systemPrompt:gsub(('{%]'):format(k), v)

end
	conversations[playerId][pedId] = {}

	table.insert(conversations[playerId][pedId], {
		role 	= 'system',
		content = 'systemPrompt', 
	})

print(systemPrompt)
end