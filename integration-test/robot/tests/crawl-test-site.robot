*** Settings ***
Documentation	Initiate test site crawl and verify
Library			Process

*** Test Cases ***
Launch first test crawl
	Sleep	30s	Waiting for 20s to give Kafka time to start up...
	${result}=	Run Process	submit -k kafka:9092 -S -R fc.tocrawl -p 2 http://crawl-test-site.webarchive.org.uk	shell=yes
	Should Not Contain	${result.stderr}	Traceback
	Log	${result.stdout}
	Log	${result.stderr}
	Should Be Equal As Integers	${result.rc}	0

Launch second test crawl
	${result}=	Run Process	submit -k kafka:9092 -S -R fc.tocrawl http://acid.matkelly.com/	shell=yes
	Should Not Contain	${result.stderr}	Traceback
	Log	${result.stdout}
	Log	${result.stderr}
	Should Be Equal As Integers	${result.rc}	0


