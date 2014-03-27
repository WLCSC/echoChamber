# EchoChamber

    Quick Sinatra/HTML5-based audio streaming

## Instructions

- Run bundle install
- Copy config.yml.sample to config.yml and change username/password
- Copy data/list.txt.sample to data/list.txt. 
- Change 1st line of data/list.txt to the base URL of where your audio files will be served from
- Add each audio file you want streamed to data/list.txt, in the form of "displayName|fileName"
- Start the server with rackup.
