#!/bin/bash

if [ -d ~/public_html_www1/naubino/ ]
then
	cp php/score.php ~/public_html_www1/naubino/
	cp php/scoreserver.php ~/public_html_www1/naubino/
	cp flash/audio/track2.mp3 ~/public_html_www1/naubino/audio/
	cp flash/index.html ~/public_html_www1/naubino/
	cp flash/naubino.swf ~/public_html_www1/naubino/
	cp flash/wallpaper.png ~/public_html_www1/naubino/

	chmod a+rx ~/public_html_www1/naubino/score.php
	chmod a+rx ~/public_html_www1/naubino/scoreserver.php
	chmod a+rx ~/public_html_www1/naubino/naubino.swf
	chmod a+rx ~/public_html_www1/naubino/index.html
	chmod a+rx ~/public_html_www1/naubino/wallpaper.png

	touch ~/public_html_www1/naubino/score.txt
	touch ~/public_html_www1/naubino/log
	chmod a+wrx ~/public_html_www1/naubino/score.txt
	chmod a+wrx ~/public_html_www1/naubino/log

else
	mkdir ~/public_html_www1/naubino/
fi
	
