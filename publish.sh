#!/bin/bash

if [ -d ~/public_html_www1/naubino2/ ]
then
	cp php/score.php ~/public_html_www1/naubino2/
	cp php/scoreserver.php ~/public_html_www1/naubino2/
	cp flash/audio/track2.mp3 ~/public_html_www1/naubino2/audio/
	cp flash/index.html ~/public_html_www1/naubino2/
	cp flash/naubino.swf ~/public_html_www1/naubino2/
	cp flash/wallpaper.png ~/public_html_www1/naubino2/

	chmod a+rx ~/public_html_www1/naubino2/score.php
	chmod a+rx ~/public_html_www1/naubino2/scoreserver.php
	chmod a+rx ~/public_html_www1/naubino2/naubino.swf
	chmod a+rx ~/public_html_www1/naubino2/index.html
	chmod a+rx ~/public_html_www1/naubino2/wallpaper.png

else
	mkdir ~/public_html_www1/naubino2/
fi
	
