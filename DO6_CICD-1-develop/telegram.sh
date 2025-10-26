#!/bin/bash

if [ -f build_status.txt ]; then
	BUILDSTATUS="$(cat build_status.txt)"
else
	BUILDSTATUS="failed"
fi

if [ -f clang_status.txt ]; then
	CLANGSTATUS="$(cat clang_status.txt)"
else
	CLANGSTATUS="failed"
fi

if [ -f test_status.txt ]; then
	TESTSTATUS="$(cat test_status.txt)"
else
	TESTSTATUS="failed"
fi

if [ -f deploy_status.txt ]; then
	DEPLOYSTATUS="$(cat deploy_status.txt)"
else
	DEPLOYSTATUS="failed"
fi

TELEGRAM_USER_ID="SOME_USER_ID"
TELEGRAM_BOT_TOKEN="SOME_BOT_TOKEN"

URL="https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage"
TEXT="Build status: $BUILDSTATUS%0AClang-format status: $CLANGSTATUS%0AIntegration tests status: $TESTSTATUS%0ADeploy status: $DEPLOYSTATUS%0A%0AProject:+$CI_PROJECT_NAME%0AURL:+$CI_PROJECT_URL/pipelines/$CI_PIPELINE_ID/%0ABranch:+$CI_COMMIT_REF_SLUG"

curl -s -d "chat_id=$TELEGRAM_USER_ID$disable_web_page_preview=1&text=$TEXT" $URL > /dev/null
