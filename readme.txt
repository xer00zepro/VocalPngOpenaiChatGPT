README.md

# Script de Communication PNJ-Joueur FiveM

Ce script client-serveur pour FiveM permet aux personnages non-joueurs (PNJ) du jeu de communiquer avec les joueurs réels en utilisant l'intelligence artificielle (IA) et le modèle GPT (Generative Pre-trained Transformer) de l'API OpenAI. Il offre une expérience immersive en permettant aux PNJ de tenir des conversations conversationnelles avec les joueurs.

## Fonctionnalités

### Côté client (Client-Side)
- Utilise un fichier JSON (`human-peds.json`) pour stocker les informations sur les PNJ humains du jeu.
- Met à jour les informations de localisation du joueur et les stocke dans l'état du joueur.
- Effectue un raycast à partir de la caméra du joueur pour détecter les PNJ humains à proximité.
- Gère le ciblage et le gel des PNJ lorsqu'ils sont visés par le joueur.
- Fournit des fonctions pour la désélection des PNJ ciblés et pour effectuer des raycasts depuis la caméra du joueur.

### Côté serveur (Server-Side)
- Utilise un script serveur en Lua pour les fonctionnalités spécifiques à FiveM.
- Utilise l'API Amazon Polly pour la synthèse vocale via le fichier JavaScript `polly.js`.
- Enregistre une commande côté serveur (`/transcribe`) pour transcrire les messages du chat.
- Génère des réponses à partir des transcriptions, envoie des requêtes à l'API OpenAI ChatGPT pour obtenir des réponses, génère des fichiers audio de synthèse vocale à partir des réponses et les fait jouer sur les PNJ correspondants.

## Configuration

Le fichier `config.lua` contient les variables de configuration suivantes :
- Clé d'API OpenAI : spécifie la clé d'API pour accéder à l'API OpenAI ChatGPT.
- Modèle de chat GPT : définit le modèle GPT à utiliser pour les conversations.
- Voix disponibles : spécifie les voix disponibles pour la synthèse vocale via l'API Amazon Polly.
- Prompt système : fournit un modèle de prompt système pour les conversations avec les PNJ.

## Utilisation

1. Assurez-vous d'avoir configuré les fichiers de configuration `config.lua` et `human-peds.json` selon vos besoins.
2. Démarrez votre serveur FiveM.
3. Installez et configurez les dépendances nécessaires, telles que l'API OpenAI et l'API Amazon Polly.
4. Copiez les fichiers du script dans les répertoires appropriés de votre serveur FiveM.
5. Lancez le script côté client et serveur.
6. Profitez de l'expérience immersive de communication avec les PNJ du jeu.

## Remarque

Ce README fournit une vue d'ensemble du script et de ses fonctionnalités, basée sur les extraits de code et les informations fournies. Pour une utilisation détaillée et une compréhension approfondie du script, veuillez consulter les fichiers de code source complets.

N'hésitez pas à poser des questions ou à demander des clarifications sur des parties spécifiques du script. Je suis là pour vous aider à mieux comprendre et à optimiser le script ! 