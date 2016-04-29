DEPLOY_BUCKET=18f-dap

production:
	bundle exec jekyll build

dev:
	bundle exec jekyll serve --watch --config=_config.yml,_development.yml

deploy:
	make production && \
	s3cmd put --recursive -P -M \
	--add-header="Cache-Control:max-age=0" \
	--add-header="X-Content-Type-Options:nosniff" \
	--add-header="X-XSS-Protection: 1; mode=block" \
	--add-header="X-Frame-Options: DENY" \
	_site/* s3://$(DEPLOY_BUCKET)/ && \
	s3cmd put -P --mime-type="text/css" \
	--add-header="Cache-Control:max-age=0" \
	_site/css/*.css s3://$(DEPLOY_BUCKET)/css/ \
	--add-header="X-Content-Type-Options:nosniff" \
	--add-header="X-XSS-Protection: 1; mode=block" \
	--add-header="X-Frame-Options: DENY" \
